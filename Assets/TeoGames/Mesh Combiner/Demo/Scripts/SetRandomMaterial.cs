using TeoGames.Mesh_Combiner.Scripts.Combine;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Demo.Scripts {
	[AddComponentMenu("Mesh Combiner/Demo/MC Set random material")]
	[RequireComponent(typeof(AbstractCombinable))]
	public class SetRandomMaterial : MonoBehaviour {
		public Material[] materials;

		private void Awake() {
			var ren = GetComponent<AbstractCombinable>();
			var cache = ren.GetCache();
			var mats = materials.GetRandomElements(cache.renderer.sharedMaterials.Length);
			cache.materials = cache.renderer.sharedMaterials = mats;
		}
	}
}