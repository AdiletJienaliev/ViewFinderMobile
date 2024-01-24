using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Extension {
	public static class Vector3Extensions {
		public static readonly Vector3 Zero = Vector3.zero;
		public static readonly Vector3 One = Vector3.one;
		
		public static Vector3 Round(this Vector3 v) {
			return new Vector3(
				Mathf.Round(v.x),
				Mathf.Round(v.y),
				Mathf.Round(v.z)
			);
		}
		
		public static Vector2 ToVector2(this Vector3 v) {
			return new Vector2(v.x, v.z);
		}
		
		public static Vector3 ToVector3(this Vector2 v) {
			return new Vector3(v.x, 0, v.y);
		}
		
		public static Vector3 Divide(this Vector3 a, Vector3 b) {
			return new Vector3(a.x / b.x, a.y / b.y, a.z / b.z);
		}
		
		public static Vector3 Flat(this Vector3 v) {
			return new Vector3(v.x, 0, v.z);
		}

		public static Vector3 AlignPosition(this Vector3 v, Transform target, Vector3 mask) {
			var local = target.InverseTransformPoint(v);
			local.Scale(mask);

			return target.TransformPoint(local);
		}
		
		public static Vector3 Lerp(this Vector3 v, Vector3 b, float max, float t) {
			return Vector3.Distance(v, b) > max ? b : Vector3.Lerp(v, b, t);
        }
	}
}