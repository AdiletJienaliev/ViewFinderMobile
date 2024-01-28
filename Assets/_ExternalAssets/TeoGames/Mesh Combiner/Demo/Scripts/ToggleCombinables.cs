using TeoGames.Mesh_Combiner.Scripts.Combine;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Demo.Scripts {
	[AddComponentMenu("Mesh Combiner/Demo/MC Toggle Combinables")]
	public class ToggleCombinables : MonoBehaviour {
		public Transform target;

		public void SetState(bool state) {
			target.GetComponentsInChildren<Combinable>().ForEach(c => c.enabled = state);
		}
	}
}