using System.Collections.Generic;
using System.Threading.Tasks;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using TeoGames.Mesh_Combiner.Scripts.Profile;
using UnityEngine;
using UnityEngine.Rendering;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.MeshRendererManager {
	public class DynamicMeshRenderer : AbstractMeshRenderer {
		private readonly SkinnedMeshRenderer _Renderer;
		private readonly Transform _Parent;
		private readonly List<Transform> _Bones = new List<Transform>();

		public override Renderer Renderer => _Renderer;

		public DynamicMeshRenderer(ShadowCastingMode shadow, GameObject obj) : base(shadow) {
			obj.name = $"[SMR] [S={shadow.ToString()}] {obj.name}";

			_Parent = obj.transform;
			_Renderer = obj.AddComponent<SkinnedMeshRenderer>();
			_Renderer.shadowCastingMode = shadow;

			// Weird fix that will increase SMR performance twice...
			_Renderer.updateWhenOffscreen = false;
			Task.CompletedTask.WaitForUpdate().ContinueWith(() => _Renderer.updateWhenOffscreen = true).Forget();
		}

		public override void Reset() {
			base.Reset();

			ProfilerModule.TotalBones.Value -= _Bones.Count;

			_Bones.Clear();
		}

		public override void Clear() {
			base.Clear();

			ProfilerModule.TotalBones.Value -= _Bones.Count;
		}

		public override bool Validate(bool isStatic, ShadowCastingMode shadow) => 
			!isStatic && shadow == Shadow;

		public override async Task BuildMesh(Timer timer) {
			if (!IsChanged) return;

			await base.BuildMesh(timer);

			foreach (var m in Materials) {
				_Bones.AddRange(m.Bones);
			}
			
			ProfilerModule.TotalBones.Value += _Bones.Count;
		}

		public override Renderer BuildRenderer() {
			if (!IsChanged) return Renderer;

			IsChanged = false;
			var mesh = _Renderer.sharedMesh;
			if (mesh) {
				mesh.Clear();
				Object.DestroyImmediate(mesh, true);
			}

			var isEnabled = Renderer.enabled = ShouldBeActive;
			if (!isEnabled) return null;

			ProfilerModule.MeshRenderers.Value++;

			_Renderer.rootBone = _Parent;
			_Renderer.sharedMesh = OutMesh;
			_Renderer.bones = _Bones.ToArray();
			_Renderer.materials = Materials.Convert(m => m.material);

			return _Renderer;
		}
	}
}