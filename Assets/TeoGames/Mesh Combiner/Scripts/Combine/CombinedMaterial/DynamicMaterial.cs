using System;
using System.Collections.Generic;
using TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial.MaterialBake;
using UnityEngine;
using UnityEngine.Rendering;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial {
	public class DynamicMaterial : BasicMaterial {
		private static readonly Matrix4x4 _DEFAULT_MATRIX = Matrix4x4.identity;

		private readonly List<Transform> _Bones = new List<Transform>();

		public DynamicMaterial(Material mat, ShadowCastingMode shadow) : base(mat, shadow) {
			isStatic = false;
		}

		public override void SetMesh(
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

			var obj = new AdvancedCombineInstance {
				Combine = new CombineInstance {
					transform = isStaticMesh
						? rootMat * renTransform.localToWorldMatrix
						: _DEFAULT_MATRIX,
					subMeshIndex = subMeshIndex,
					mesh = mesh,
				},
				Bones = bones
			};

			Meshes[cID * 100 + subMeshIndex] = obj;

			Updated();
		}

		public override void Build() {
			base.Build();

			_Bones.Clear();

			foreach (var m in Meshes.Values) {
				if (m.Bones != null) _Bones.AddRange(m.Bones);
			}

			Bones = _Bones.ToArray();
		}

		public override void Clear() {
			base.Clear();

			Bones = Array.Empty<Transform>();
		}
	}
}