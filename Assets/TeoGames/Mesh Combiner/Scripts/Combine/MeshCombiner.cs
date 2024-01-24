using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial;
using TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial.MaterialBake;
using TeoGames.Mesh_Combiner.Scripts.Combine.Interfaces;
using TeoGames.Mesh_Combiner.Scripts.Combine.MaterialStorage;
using TeoGames.Mesh_Combiner.Scripts.Combine.MeshRendererManager;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using TeoGames.Mesh_Combiner.Scripts.Profile;
using TeoGames.Mesh_Combiner.Scripts.Util;
using UnityEngine;
using UnityEngine.Events;

namespace TeoGames.Mesh_Combiner.Scripts.Combine {
	using MaterialType = ValueTuple<bool, MeshParser, BasicMaterial>;

	public enum UpdateType {
		Include,
		Exclude
	}

	[AddComponentMenu("Mesh Combiner/MC Mesh Combiner")]
	public class MeshCombiner : AbstractMeshCombiner, IAsyncCombiner, IPostBakeAction {
		protected static readonly ThreadsPool Pool = new ThreadsPool();
		private static readonly Timer _TIMER = new Timer();

		public readonly List<AbstractMeshRenderer> RendererManagers = new List<AbstractMeshRenderer>();

		[Tooltip("Will trigger after each bake")]
		public UnityEvent onUpdated = new UnityEvent();

		public UnityAction<Renderer[]> OnRenderersUpdated;

		private AbstractMaterialStorage _Materials;

		private readonly Dictionary<int, BasicMaterial[]>
			_CombinableToMaterial = new Dictionary<int, BasicMaterial[]>();

		private readonly Dictionary<AbstractCombinable, UpdateType> _Updates =
			new Dictionary<AbstractCombinable, UpdateType>();

		public Task UpdateTask { get; protected set; } = Task.CompletedTask;

		private GameObject _GameObject;
		private int _LastUpdateTime;

		private Func<AbstractCombinable, bool> _StaticInclude;
		private Func<AbstractCombinable, bool> _DynamicInclude;
		private Transform[] _StaticBones;
		private Matrix4x4 _Matrix;

		[HideInInspector] public bool asyncMode = true;
		private Renderer[] _RendererComponents = Array.Empty<Renderer>();

		public int CombinableCount => _CombinableToMaterial.Count;

		private void Awake() {
			if (!name.StartsWith("__SKIP__")) Init();
		}

		private void OnDestroy() {
			RendererManagers.ForEach(r => r.Clear());
			ProfilerModule.Meshes.Value -= CombinableCount;
		}

		public override void Init() {
			_Materials = new BasicMaterialStorage();
			_StaticBones = new[] { transform };

			var supportStatic = (rendererTypes & TargetRendererType.MeshRenderer) != 0;
			var supportDynamic = (rendererTypes & TargetRendererType.SkinnerMeshRenderer) != 0;
			if (!supportDynamic && !supportStatic) {
				throw new Exception("You should pick at least one type of renderer to make combinable work");
			}

			_StaticInclude = supportStatic ? (Func<AbstractCombinable, bool>)IncludeAsStatic : IncludeAsDynamic;
			_DynamicInclude = supportDynamic ? (Func<AbstractCombinable, bool>)IncludeAsDynamic : IncludeAsStatic;
		}

		public override void Clear() {
			_RendererComponents.ForEach(
				r => {
					if (!r) return;

					r.DeleteMesh();
					DestroyImmediate(r.gameObject);
				}
			);
			_RendererComponents = Array.Empty<Renderer>();

			RendererManagers.ForEach(
				r => {
					if (r.Renderer) DestroyImmediate(r.Renderer.gameObject);
				}
			);
			RendererManagers.Clear();

			if (IsLodReady) Lod.Clear();
		}

		public override Renderer[] GetRenderers() =>
			IsLodReady
				? _RendererComponents.Concat(Lod.Combiner.GetRenderers()).ToArray()
				: _RendererComponents;

		private bool IncludeAsStatic(AbstractCombinable combinable) {
			var cache = combinable.GetCache();
			var mats = cache.materials;
			var subMeshes = Math.Min(mats.Length, cache.mesh.subMeshCount);
			var shadow = cache.renderer.shadowCastingMode;
			var offset = 1 + ((int)shadow + 1) * 10 + 0;
			var newMaterials = new BasicMaterial[subMeshes];
			var cID = combinable.GetInstanceID();
			var rTransform = cache.transform;

			for (var i = 0; i < subMeshes; i++) {
				var mat = mats[i];
				var mID = mat.GetCombineID(offset);
				var (parser, material) = _Materials.Get(mID, mat, offset, shadow, true);
				newMaterials[i] = material;

				material.SetMesh(cID, parser, null, i, cache.mesh, true, _Matrix, rTransform);
			}

			AddMaterialMap(cID, newMaterials);

			return true;
		}

		private bool IncludeAsDynamic(AbstractCombinable combinable) {
			var cache = combinable.GetCache();
			var mats = cache.materials;
			var subMeshes = Math.Min(mats.Length, cache.mesh.subMeshCount);
			var shadow = cache.renderer.shadowCastingMode;
			var offset = ((int)shadow + 1) * 10;
			var newMaterials = new BasicMaterial[subMeshes];
			var cID = combinable.GetInstanceID();
			var isStatic = combinable.IsStatic;
			var parsedMesh = cache.isCorrectionRequired switch {
				MeshCorrection.Stat => cache.mesh.ToStatic(),
				MeshCorrection.Anim => cache.mesh.ToAnimated(),
				_ => cache.mesh
			};
			var rTransform = cache.transform;
			var realBones = isStatic ? _StaticBones : cache.Bones ?? new[] { rTransform };

			for (var i = 0; i < subMeshes; i++) {
				var mat = mats[i];
				var mID = mat.GetCombineID(offset);
				var (parser, material) = _Materials.Get(mID, mat, offset, shadow, false);
				newMaterials[i] = material;

				material.SetMesh(
					cID,
					parser,
					realBones,
					i,
					parsedMesh,
					isStatic,
					_Matrix,
					rTransform
				);
			}

			AddMaterialMap(cID, newMaterials);

			return true;
		}

		private void AddMaterialMap(int cID, BasicMaterial[] newMaterials) {
			if (_CombinableToMaterial.TryGetValue(cID, out var existing)) {
				for (var i = 0; i < existing.Length; i++) {
					var material = existing[i];
					if (newMaterials.Contains(material)) continue;

					var meshKey = cID * 100 + i;
					if (!material.Meshes.ContainsKey(meshKey)) continue;

					material.Meshes.Remove(meshKey);
					material.Updated();
				}
			}

			_CombinableToMaterial[cID] = newMaterials;
			ProfilerModule.Meshes.Value++;
		}

		public override void Include(AbstractCombinable combinable) {
			_Updates[combinable] = UpdateType.Include;

			ScheduleUpdate();
		}

		public override void Exclude(AbstractCombinable combinable) {
			_Updates[combinable] = UpdateType.Exclude;

			ScheduleUpdate();
		}

		protected void ScheduleUpdate(bool force = false) {
			if (!force && UpdateTask.Status < TaskStatus.RanToCompletion) return;

			UpdateTask = Pool.Schedule(RunUpdate);
		}

		private async Task RunUpdate() {
			var added = new List<IVisibilityToglable>();
			var removed = new List<IVisibilityToglable>();

			try {
				await UpdateMeshList(added, removed);
				await UpdateMesh();
				await ParseRenderers(added, removed);
			} catch (Exception ex) {
				Debug.LogException(ex);

				if (this) throw;
			} finally {
				_TIMER.Stop();
				if (_Updates.Count > 0 && this) ScheduleUpdate(true);
			}
		}

		protected async Task UpdateMeshList(List<IVisibilityToglable> added, List<IVisibilityToglable> removed) {
			if (!this) return;

			_TIMER.Start(maxBuildTime, asyncMode);
			if (_TIMER.IsTimeoutRequired) await _TIMER.Wait();
			var list = new Dictionary<AbstractCombinable, UpdateType>(_Updates);
			_Updates.Clear();

			_Matrix = transform.worldToLocalMatrix;

			var i = 0;
			foreach (var (comb, action) in list) {
				if (i++ % 10 == 0 && _TIMER.IsTimeoutRequired) await _TIMER.Wait();

				try {
					if (action == UpdateType.Include) {
						if (IncludeCombinable(comb) && comb is IVisibilityToglable toglable) added.Add(toglable);
					} else {
						if (ExcludeCombinable(comb) && comb is IVisibilityToglable toglable) removed.Add(toglable);
					}
				} catch (Exception e) {
					Debug.LogException(e, comb);
				}
			}

			_TIMER.Stop();
		}

		protected async Task ParseRenderers(List<IVisibilityToglable> added, List<IVisibilityToglable> removed) {
			if (!this) return;

			_TIMER.Start(maxBuildTime, asyncMode);

			// Enable renderers that should be active
			var renderers = new List<Renderer>();
			foreach (var ren in RendererManagers) {
				if (!ren.ShouldBeActive) continue;

				var res = ren.BuildRenderer();
				if (res) renderers.Add(res);
			}

			var list = renderers.ToArray();
			OnRenderersUpdated?.Invoke(list);

			var i = 0;
			foreach (var comb in added) {
				if (i++ % 10 == 0 && _TIMER.IsTimeoutRequired) {
					await _TIMER.Wait();
					if (!this) return;
				}

				comb.OnInclude();
			}

			foreach (var comb in removed) {
				if (i++ % 10 == 0 && _TIMER.IsTimeoutRequired) {
					await _TIMER.Wait();
					if (!this) return;
				}

				comb.OnExclude();
			}

			// Disable renderers that should be disabled
			foreach (var ren in RendererManagers) {
				if (!ren.ShouldBeActive) ren.BuildRenderer();
			}

			_RendererComponents = list;
			onUpdated?.Invoke();
			_TIMER.Stop();
		}

		protected bool IncludeCombinable(AbstractCombinable combinable) {
			if (!combinable.IsActive) return false;

			combinable.ClearCache();

			return combinable.IsStatic ? _StaticInclude(combinable) : _DynamicInclude(combinable);
		}

		protected bool ExcludeCombinable(AbstractCombinable combinable) {
			var cID = combinable.GetInstanceID();
			if (!_CombinableToMaterial.TryGetValue(cID, out var matList)) return false;

			for (var i = 0; i < matList.Length; i++) {
				var material = matList[i];
				var meshKey = cID * 100 + i;
				if (!material.Meshes.ContainsKey(meshKey)) continue;

				material.Meshes.Remove(meshKey);
				material.Updated();
			}

			_CombinableToMaterial.Remove(cID);
			ProfilerModule.Meshes.Value--;

			return true;
		}

		private async Task UpdateMesh() {
			if (!this) return;

			var time = Timer.MS();
			_TIMER.Start(maxBuildTime, asyncMode);

			foreach (var ren in RendererManagers) ren.Reset();

			foreach (var material in _Materials.List) {
				var ren = GetRenderer(material);
				var isChanged = material.LastUpdatedAt > _LastUpdateTime;

				if (isChanged) {
					if (_TIMER.IsTimeoutRequired) await _TIMER.Wait();
					if (!this) return;

					material.Build();
					material.LastUpdatedAt = time;
				}

				ren.IsChanged |= isChanged;
				if (material.Mesh.mesh.vertexCount > 0) ren.RegisterMaterial(material);
			}

			foreach (var ren in RendererManagers) {
				if (_TIMER.IsTimeoutRequired) await _TIMER.Wait();

				await ren.BuildMesh(_TIMER);
			}

			_LastUpdateTime = Timer.MS();
			_TIMER.Stop();
		}

		protected AbstractMeshRenderer GetRenderer(BasicMaterial mat) {
			var isStatic = mat.isStatic;
			var shadow = mat.shadow;

			foreach (var ren in RendererManagers) {
				if (ren.Validate(isStatic, shadow)) return ren;
			}

			var obj = new GameObject(name) {
				transform = {
					parent = transform,
					localPosition = Vector3Extensions.Zero,
					localScale = Vector3Extensions.One,
					localEulerAngles = Vector3Extensions.Zero
				}
			};

			var res = isStatic
				? (AbstractMeshRenderer)new StaticMeshRenderer(shadow, obj)
				: new DynamicMeshRenderer(shadow, obj);
			RendererManagers.Add(res);

			return res;
		}

		public void PostBakeAction() {
			Clear();
			if (IsLodReady) Lod.Clear();
		}
	}
}