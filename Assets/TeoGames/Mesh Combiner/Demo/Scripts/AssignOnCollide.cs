using TeoGames.Mesh_Combiner.Scripts.Combine;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Demo.Scripts {
	[AddComponentMenu("Mesh Combiner/Demo/MC Assign On Collide")]
	public class AssignOnCollide : MonoBehaviour {
		private void OnTriggerEnter(Collider other) {
			if (!other.TryGetComponent<Combinable>(out var combinable)) return;

			combinable.transform.parent = transform;
		}
	}
}