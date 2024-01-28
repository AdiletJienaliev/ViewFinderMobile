using System.Collections.Generic;
using System.Linq;
using TeoGames.Mesh_Combiner.Scripts.Combine;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEngine;
using UnityEngine.Events;

namespace TeoGames.Mesh_Combiner.Demo.Scripts {
	[AddComponentMenu("Mesh Combiner/Demo/MC Set Combiner Material")]
	public class SetCombinerMaterial : MonoBehaviour {
		public Material[] materials;
		[SerializeField] private List<AbstractMeshCombiner> attachedCombiners;
		private readonly Dictionary<LODGroup, Material> _Lods = new Dictionary<LODGroup, Material>();

		private readonly List<Material> _MaterialsLeft = new List<Material>();
		private readonly Dictionary<Renderer, Material[]> _OriginalMaterials = new Dictionary<Renderer, Material[]>();
		private readonly UnityEvent _OnEnable = new UnityEvent();

		private void Update() {
			if (Time.frameCount % 60 != 0) return;

			ListenForUpdates();
		}

		private void ListenForUpdates() {
			GetComponentsInChildren<MeshCombiner>().ForEach(
				c => {
					if (attachedCombiners.Contains(c)) return;

					var lod = c.GetComponentInParent<LODGroup>();
					if (!lod || !_Lods.TryGetValue(lod, out var mat)) {
						if (!_MaterialsLeft.Any()) _MaterialsLeft.AddRange(materials);
						mat = _MaterialsLeft[Random.Range(0, _MaterialsLeft.Count - 1)];
						_MaterialsLeft.Remove(mat);
						if (lod) _Lods[lod] = mat;
					}

					attachedCombiners.Add(c);

					SetMaterial(c, mat);
					c.onUpdated.AddListener(() => SetMaterial(c, mat));
					_OnEnable.AddListener(() => SetMaterial(c, mat));
				}
			);
		}

		private void OnEnable() {
			_OnEnable?.Invoke();
		}

		private void OnDisable() {
			_OriginalMaterials.ForEach(pair => pair.Key.sharedMaterials = pair.Value);
		}

		private void SetMaterial(MeshCombiner combiner, Material material) {
			if (!this || !enabled) return;

			combiner.GetRenderers().ForEach(
				r => {
					_OriginalMaterials[r] = r.sharedMaterials;
					r.sharedMaterials = Enumerable.Repeat(material, r.sharedMaterials.Length).ToArray();
				}
			);
		}
	}
}