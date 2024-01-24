using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using TeoGames.Mesh_Combiner.Scripts.Profile;
using UnityEngine;
using UnityEngine.Rendering;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.MeshRendererManager {
	public abstract class AbstractMeshRenderer {
		public readonly List<BasicMaterial> Materials = new List<BasicMaterial>();
		public bool IsChanged = false;

		protected readonly ShadowCastingMode Shadow;
		protected Mesh OutMesh;

		public bool ShouldBeActive => Materials.Any();

		public abstract bool Validate(bool isStatic, ShadowCastingMode shadow);
		public abstract Renderer BuildRenderer();
		public abstract Renderer Renderer { get; }

		protected AbstractMeshRenderer(ShadowCastingMode shadow) {
			Shadow = shadow;
		}

		public virtual Task BuildMesh(Timer timer) {
			if (IsChanged) {
				if (OutMesh) ProfilerModule.Vertices.Value -= OutMesh.vertexCount;

				OutMesh = new Mesh() { indexFormat = IndexFormat.UInt32 };
#if MC_DEBUG
				OutMesh.name = $"[REN] {Renderer.name}";
#endif

				OutMesh.CombineMeshes(Materials.Convert(m => m.Mesh), false, false);

				ProfilerModule.Vertices.Value += OutMesh.vertexCount;
			}

			return Task.CompletedTask;
		}

		public virtual void Reset() {
			if (ShouldBeActive) ProfilerModule.MeshRenderers.Value--;

			Materials.Clear();
		}

		public virtual void Clear() {
			if (ShouldBeActive) ProfilerModule.MeshRenderers.Value--;
			if (OutMesh) ProfilerModule.Vertices.Value -= OutMesh.vertexCount;
		}

		public virtual void RegisterMaterial(BasicMaterial material) => Materials.Add(material);
	}
}