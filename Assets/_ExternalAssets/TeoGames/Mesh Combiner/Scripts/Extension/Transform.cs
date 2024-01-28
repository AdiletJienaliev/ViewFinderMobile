using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Extension {
	public static class TransformExtension {
		public static void RemoveAll(this Transform transform) {
			foreach (Transform child in transform) {
				Object.Destroy(child.gameObject);
			}
		}

		public static void SyncTransform(this Transform transform, Transform target, Transform alignParent) {
			transform.localPosition = target.position - alignParent.position;
			transform.localScale = target.lossyScale;
			transform.localEulerAngles = target.eulerAngles;
		}
	}
}