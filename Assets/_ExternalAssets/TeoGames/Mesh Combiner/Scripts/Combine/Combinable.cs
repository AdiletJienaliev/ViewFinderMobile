using System;
using System.Linq;
using TeoGames.Mesh_Combiner.Scripts.Combine.Interfaces;
using TeoGames.Mesh_Combiner.Scripts.Combine.SceneCombiner;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEngine;
#if !UNITY_EDITOR
using TeoGames.Mesh_Combiner.Scripts.Util;
#endif

namespace TeoGames.Mesh_Combiner.Scripts.Combine {
	[RequireComponent(typeof(Renderer))]
	[AddComponentMenu("Mesh Combiner/MC Combinable")]
	public class Combinable : AbstractCombinable, IVisibilityToglable {
		[Space, Space] [Tooltip("Will find combiner with specified tag")]
		public string key = "";

		[Tooltip("Each instance will have it's own bone if TRUE, so moving model will be affected in baked mesh")]
		public bool isStatic = true;

		[Tooltip("Will disable renderer when combined")]
		public bool disableRenderer = true;

		[Tooltip("Will remove all materials when combined")]
		public bool removeMaterials;

		[Tooltip("Defines which sources combinable will use to bake")]
		public CombinerSourceType combinerSource =
			CombinerSourceType.SearchHierarchy | CombinerSourceType.SceneCombiner;

		private AbstractMeshCombiner _LastCombiner;

		public override bool IsStatic => isStatic;

		protected virtual void OnEnable() => Include();

		protected virtual void OnTransformParentChanged() {
			if (!IsActive) return;

			var cur = GetCurrentCombiner();
			if (cur == _LastCombiner) return;

			if (_LastCombiner) _LastCombiner.Exclude(this);
			if (cur) cur.Include(this);

			_LastCombiner = cur;
		}

		protected virtual void OnDisable() => Exclude();

		public override bool IsActive {
			get {
#if !UNITY_EDITOR
			if (!cache.mesh.isReadable) {
				ErrorPool.Error(
					$"Unable to bake mesh '{cache.mesh.name}' that is not readable. " +
					$"Please see docs for more info: https://teogames.gitbook.io/dynamic-mesh-combiner/components/mc-combinable#mark-mesh-as-readable"
				);

				return false;
			}
#endif

				return isActiveAndEnabled;
			}
		}

		public override void Include() {
			var obj = GetCombiner();
			if (obj) {
				if (gameObject.isStatic) gameObject.isStatic = false;
				obj.Include(this);
			}
		}

		public override void Exclude() {
			var obj = GetCombiner();
			if (obj) obj.Exclude(this);
		}

		public override AbstractMeshCombiner GetCombiner() {
			if (!_LastCombiner) _LastCombiner = GetCurrentCombiner();

			return _LastCombiner;
		}

		public AbstractMeshCombiner GetCurrentCombiner() {
			if ((combinerSource & CombinerSourceType.SearchHierarchy) != 0) {
				foreach (var parent in GetComponentsInParent<AbstractMeshCombiner>(true)) {
					if (IsCompatible(parent)) return parent;
				}
			}

			if ((combinerSource & CombinerSourceType.SceneCombiner) != 0) {
				foreach (var parent in SceneCombinerRegistry.Combiners) {
					if (IsCompatible(parent)) return parent;
				}
			}

			return null;
		}

		public override bool IsCompatible(AbstractMeshCombiner combiner) {
			return combiner && (!combiner.keys.Any() || combiner.keys.Contains(key));
		}

		public void UpdateStatus() {
			cache.materials = cache.renderer.sharedMaterials;
			if (IsActive) Include();
			else Exclude();
		}

		public static T[] GetCombinableList<T>(GameObject target) where T : Combinable {
			return Array.FindAll(target.GetComponentsInChildren<T>(true), c => c.enabled);
		}

		public static void ForEach<T>(GameObject target, Action<T> action) where T : Combinable {
			Array.ForEach(GetCombinableList<T>(target), action);
		}

		public static void ForEach(GameObject target, Action<Combinable> action) => ForEach<Combinable>(target, action);

		public static void NotifyForUpdates(GameObject target) {
			ForEach(target, c => c.UpdateStatus());
		}

        protected override void PostCacheSet()
        {
            base.PostCacheSet();

            if (cache.mesh)
            {
                var bp = cache.mesh.bindposes;
                if (isStatic || !cache.isSkinnedMesh || cache.skinnedMeshRenderer.bones == null)
                {
                    cache.isCorrectionRequired = bp.Length != 1 ? MeshCorrection.Stat : MeshCorrection.None;
                }
                else
                {
                    cache.isCorrectionRequired = bp.Length == 0 ? MeshCorrection.Anim : MeshCorrection.None;
                }
            }
            else
            {
                Debug.LogError($"There is no mesh set for object {name}", this);
            }
        }

		private int _ActiveInclusions = 0;

		public virtual void OnExclude() {
			if (_ActiveInclusions-- != 1 || !cache.renderer) return;
			if (disableRenderer) cache.renderer.Enable();
			if (removeMaterials) cache.renderer.sharedMaterials = cache.materials;
		}

		public virtual void OnInclude() {
			if (_ActiveInclusions++ > 0 || !cache.renderer) return;
			if (disableRenderer) cache.renderer.Disable();
			if (removeMaterials) cache.renderer.sharedMaterials = Array.Empty<Material>();
		}
	}
}