using System;
using System.Collections.Generic;
using TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial.MaterialBake;
using TeoGames.Mesh_Combiner.Scripts.Profile;
using UnityEngine;
using UnityEngine.Rendering;
using Object = UnityEngine.Object;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial {
	[Serializable]
	public class BasicMaterial {
		public Material material;
		public ShadowCastingMode shadow;
		public bool isStatic = true;

		public readonly Dictionary<int, AdvancedCombineInstance> Meshes =
			new Dictionary<int, AdvancedCombineInstance>();

		public CombineInstance Mesh { get; protected set; }

		public Transform[] Bones { get; protected set; } = Array.Empty<Transform>();

		public int LastUpdatedAt { get; set; } = Timer.MS();

		public BasicMaterial(Material mat, ShadowCastingMode shadow) {
			this.shadow = shadow;
			material = mat;
		}

		public void Updated() {
			LastUpdatedAt = Timer.MS();
		}

		public virtual void SetMesh(
			int cID,
			MeshParser parser,
			Transform[] bones,
			int subMeshIndex,
			Mesh mesh,
			bool isStaticMesh,
			Matrix4x4 rootMat,
			Transform renTransform
		) {
			if (parser != null) mesh = parser.GetParsedMesh(mesh);

			Meshes[cID * 100 + subMeshIndex] = new AdvancedCombineInstance {
				Combine = new CombineInstance {
					transform = rootMat * renTransform.localToWorldMatrix, subMeshIndex = subMeshIndex, mesh = mesh,
				},
			};

			Updated();
		}

		public virtual void Build() {
			Clear();

			var mesh = new Mesh { indexFormat = IndexFormat.UInt32 };
#if MC_DEBUG
			var matName = material ? material.name : "null";
			mesh.name = $"[MAT] {matName}";
#endif

			var meshes = new CombineInstance[Meshes.Count];
			var i = 0;
			foreach (var pair in Meshes) meshes[i++] = pair.Value.Combine;

			mesh.CombineMeshes(meshes, true, true);
			Mesh = new CombineInstance { mesh = mesh, subMeshIndex = 0 };
		}

		public virtual void Clear() {
			if (Mesh.mesh) Object.DestroyImmediate(Mesh.mesh, true);
			Updated();
		}
	}
}