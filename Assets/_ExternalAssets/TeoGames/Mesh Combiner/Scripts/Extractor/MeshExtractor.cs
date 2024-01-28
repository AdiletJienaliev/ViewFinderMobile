using System.Linq;
using System.Threading.Tasks;
using TeoGames.Mesh_Combiner.Scripts.Combine;
using TeoGames.Mesh_Combiner.Scripts.Combine.MeshRendererManager;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEngine;
using UnityEngine.Events;

namespace TeoGames.Mesh_Combiner.Scripts.Extractor {
	[AddComponentMenu("Mesh Combiner/MC Mesh Extractor")]
	public class MeshExtractor : MonoBehaviour {
		[Tooltip("Will show all meshes by default if TRUE")]
		public bool showByDefault = true;

		[Tooltip("Meshes will be scaled independent from game object scale if TRUE")]
		public bool useRelativeScale;

		[Tooltip(
			"Meshes will be build in lazy mode if TRUE. Will take more time to build but cause less performance drops")]
		public bool asyncMode = true;

		[Tooltip("Define which renderers can be used")]
		public TargetRendererType rendererTypes =
			TargetRendererType.MeshRenderer | TargetRendererType.SkinnerMeshRenderer;

		[Tooltip("Will replace all materials with specified one if passed")]
		public Material globalMaterial;
		
		[Tooltip("Will add mesh combiner to bake all meshes into single one")]
		public bool combineMeshes = true;

		public UnityEvent<Mesh[]> onUpdated;

		public int Count => _Meshes.Length;
		private Transform[] _Meshes = new Transform[] { };
		private BindTransform _Bind;
		private bool _IsStaticMode;
		private MeshCombiner _Combiner;
		private Transform _Parent;

		public virtual void Clean() => transform.RemoveAll();

		public virtual void Show(int id) => Show(_Meshes[id]);

		protected virtual void Show(Transform target) {
			if (IsVisible(target)) return;

			if (_IsStaticMode) target.gameObject.SetActive(true);
			else target.localScale = Vector3Extensions.One;
		}

		public virtual void ShowAll() => _Meshes.ForEach(Show);

		public virtual void Hide(int id) => Hide(_Meshes[id]);

		protected virtual void Hide(Transform target) {
			if (!IsVisible(target)) return;

			if (_IsStaticMode) target.gameObject.SetActive(false);
			else target.localScale = Vector3Extensions.Zero;
		}

		public virtual bool IsVisible(int id) => IsVisible(_Meshes[id]);

		protected virtual bool IsVisible(Transform target) => _IsStaticMode
			? target.gameObject.activeSelf
			: target.localScale == Vector3Extensions.One;

		public virtual void HideAll() => _Meshes.ForEach(Hide);

		protected virtual bool IsValidCombinable(Combinable combinable) => true;

		public virtual Task Build(Transform original) =>
			Build(original, Vector3Extensions.Zero, Vector3Extensions.Zero, 0);

		public virtual async Task Build(Transform original, Vector3 offset, Vector3 rotation, float scale) {
			Clean();

			var instance = new GameObject {
				name = "Extracted Meshes",
				transform = {
					parent = transform,
					localPosition = offset,
					localScale = Vector3Extensions.One,
					localEulerAngles = rotation,
				},
			};
			_Parent = instance.transform;

			_IsStaticMode = rendererTypes == TargetRendererType.MeshRenderer || original.gameObject.scene.name == null;
			if (combineMeshes) {
				instance.SetActive(false);
				_Combiner = instance.AddComponent<MeshCombiner>();
				_Combiner.rendererTypes = _IsStaticMode ? TargetRendererType.MeshRenderer : rendererTypes;
				_Combiner.asyncMode = asyncMode;
				_Combiner.onUpdated = new UnityEvent();
				_Combiner.onUpdated.AddListener(TriggerUpdate);
				instance.SetActive(true);
			}

			_Bind = instance.AddComponent<BindTransform>();
			_Bind.alignParent = original;

			_Meshes = original
				.GetComponentsInChildren<Combinable>(false)
				.Select(c => ParseCombinable(scale, c))
				.NotNull()
				.ToArray();

			if (combineMeshes) await _Combiner.UpdateTask;
		}

		private void TriggerUpdate() => onUpdated?.Invoke(_Combiner.GetRenderers().Select(c =>
			c.TryGetComponent<SkinnedMeshRenderer>(out var smr)
				? smr.sharedMesh
				: c.GetComponent<MeshFilter>().sharedMesh).ToArray());

		private Transform ParseCombinable(float scale, Combinable obj) {
			if (!IsValidCombinable(obj) || !obj.enabled) return null;

			obj.ClearCache();
			var root = new GameObject {
				name = obj.name,
				transform = {
					parent = _Parent,
					localPosition = Vector3Extensions.Zero,
					localScale = Vector3Extensions.One,
					localEulerAngles = Vector3Extensions.Zero,
				}
			};
			
			var cache = obj.GetCache();
			var objTransform = obj.transform;
			var objScale = useRelativeScale ? Vector3Extensions.One : objTransform.lossyScale;

			if (_IsStaticMode) {
				var filter = root.AddComponent<MeshFilter>();
				filter.sharedMesh = cache.mesh.Scale(objScale, scale);

				var ren = root.AddComponent<MeshRenderer>();
				ren.shadowCastingMode = cache.renderer.shadowCastingMode;
				ren.sharedMaterials = globalMaterial
					? Enumerable.Repeat(globalMaterial, cache.renderer.sharedMaterials.Length).ToArray()
					: cache.renderer.sharedMaterials;

				_Bind.Sync(true, root.transform, objTransform);
			} else {
				var ren = root.AddComponent<SkinnedMeshRenderer>();
				ren.sharedMesh = cache.mesh.Scale(objScale, scale);
				ren.shadowCastingMode = cache.renderer.shadowCastingMode;
				ren.sharedMaterials = globalMaterial
					? Enumerable.Repeat(globalMaterial, cache.renderer.sharedMaterials.Length).ToArray()
					: cache.renderer.sharedMaterials;

				ren.bones = (cache.Bones ?? new[] { objTransform })
					.Select(b => {
						var bone = new GameObject {
							name = b.name,
							transform = {
								parent = root.transform,
								localPosition = Vector3Extensions.Zero,
								localScale = Vector3Extensions.One,
								localEulerAngles = Vector3Extensions.Zero,
							}
						}.transform;

						_Bind.Sync(obj.isStatic, bone, b);

						return bone;
					})
					.ToArray();
				ren.rootBone = ren.bones[0];
			}

			root.SetActive(showByDefault);
			var combinable = root.AddComponent<Combinable>();
			combinable.isStatic = _IsStaticMode;
			combinable.ClearCache();

			return root.transform;
		}
	}
}