using UnityEngine;

namespace TeoGames.Mesh_Combiner.Demo.Scripts {
	[AddComponentMenu("Mesh Combiner/Demo/MC Move To Point")]
	public class MoveToPoint : MonoBehaviour {
		public float speed = 1f;
		public Transform destination;
		public Transform target;

		private void Update() {
			var progress = Mathf.Abs(Mathf.Sin(Time.realtimeSinceStartup * speed));
			target.position = Vector3.Lerp(transform.position, destination.position, progress);
		}
	}
}