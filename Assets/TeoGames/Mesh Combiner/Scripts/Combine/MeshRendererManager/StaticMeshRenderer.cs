using TeoGames.Mesh_Combiner.Scripts.Extension;
using TeoGames.Mesh_Combiner.Scripts.Profile;
using UnityEngine;
using UnityEngine.Rendering;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.MeshRendererManager {
	public class StaticMeshRenderer : AbstractMeshRenderer {
		private readonly MeshRenderer _Renderer;
		private readonly MeshFilter _Filter;

		public override Renderer Renderer => _Renderer;

		public StaticMeshRenderer(ShadowCastingMode shadow, GameObject obj) : base(shadow) {
			obj.name = $"[MR] [S={shadow.ToString()}] {obj.name}";

			_Filter = obj.AddComponent<MeshFilter>();

			_Renderer = obj.AddComponent<MeshRenderer>();
			_Renderer.shadowCastingMode = shadow;
		}

		public override bool Validate(bool isStatic, ShadowCastingMode shadow) => isStatic && shadow == Shadow;

		public override Renderer BuildRenderer() {
			if (!IsChanged) {
				ProfilerModule.MeshRenderers.Value++;
				return Renderer;
			}

			IsChanged = false;

			// Build mesh
			var mesh = _Filter.sharedMesh;
			if (mesh) {
				mesh.Clear();
				Object.DestroyImmediate(mesh, true);
			}

			Renderer.enabled = ShouldBeActive;
			if (!Renderer.enabled) return null;

			ProfilerModule.MeshRenderers.Value++;

			_Filter.sharedMesh = OutMesh;

			// Assign materials
			_Renderer.materials = Materials.Convert(m => m.material);
			return _Renderer;
		}
	}
}