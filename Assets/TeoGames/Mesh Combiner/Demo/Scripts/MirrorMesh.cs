using TeoGames.Mesh_Combiner.Scripts.Combine;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Demo.Scripts {
	[AddComponentMenu("Mesh Combiner/Demo/MC Mirror Mesh")]
	public class MirrorMesh : MonoBehaviour {
		public Vector3 axis = Vector3.one;

		private void Awake() {
			if (TryGetComponent<MeshFilter>(out var filter)) {
				var mesh = filter.sharedMesh.Mirror(axis);
				filter.sharedMesh = mesh;
				if (TryGetComponent<MeshCollider>(out var col)) col.sharedMesh = mesh;
			} else if (TryGetComponent<SkinnedMeshRenderer>(out var ren)) {
				var mesh = ren.sharedMesh.Mirror(axis);
				ren.sharedMesh = mesh;
				if (TryGetComponent<MeshCollider>(out var col)) col.sharedMesh = mesh;
			}
			
			if (TryGetComponent<Combinable>(out var comb)) comb.ClearCache(true);
		}
	}
}