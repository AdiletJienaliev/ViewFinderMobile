using System.Collections;
using System.Collections.Generic;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Demo.Scripts {
	[AddComponentMenu("Mesh Combiner/Demo/MC Spawn Objects Inside Circle")]
	public class SpawnObjectsInsideCircle : MonoBehaviour {
		public float size = 1f;
		public float spawnDelaySec = .1f;
		public int objectsToKeep = 1000;
		public GameObject prefab;
		public bool useLazeDestroy = true;

		public void SetUseLazeDestroy(bool val) => useLazeDestroy = val;

		private void OnEnable() => StartCoroutine(LazyAddObjects());

		private void OnDisable() => StopAllCoroutines();

		private IEnumerator LazyAddObjects() {
			var objects = new List<GameObject>();

			while (true) {
				var obj = Instantiate(prefab, transform);
				obj.transform.localPosition = Random.insideUnitCircle.ToVector3() * size;
				obj.transform.localScale = Random.Range(.6f, 1f) * Vector3Extensions.One;

				objects.Add(obj);

				if (objects.Count > objectsToKeep) {
					if (useLazeDestroy) objects[0].LazyDestroy();
					else Destroy(objects[0]);
					objects.RemoveAt(0);
				}

				yield return new WaitForSecondsRealtime(spawnDelaySec);
			}
		}
	}
}