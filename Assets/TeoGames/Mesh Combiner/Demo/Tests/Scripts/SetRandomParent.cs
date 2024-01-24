using System.Collections;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Demo.Tests.Scripts {
	[AddComponentMenu("Mesh Combiner/Demo/Tests/MC Set Random Parent")]
	public class SetRandomParent : MonoBehaviour {
		public Transform[] parents;
		public float delaySec;

		private void OnEnable() {
			StopAllCoroutines();
			StartCoroutine(ChangeParent());
		}

		private IEnumerator ChangeParent() {
			while (true) {
				transform.parent = parents.GetRandomElements(1)[0];
				yield return new WaitForSeconds(delaySec);
			}
		}
	}
}