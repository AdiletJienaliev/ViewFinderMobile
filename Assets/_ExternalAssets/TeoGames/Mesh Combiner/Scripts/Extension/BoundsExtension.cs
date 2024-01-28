using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Extension {
	public static class BoundsExtension {
		private static readonly Color _DEFAULT_COLOR = Color.green;

		public static void DrawGizmo(this Bounds b, Vector3 offset = default, float delay = 0, Color color = default) {
			color = color == default ? _DEFAULT_COLOR : color;

			// bottom
			var p1 = new Vector3(b.min.x, b.min.y, b.min.z) + offset;
			var p2 = new Vector3(b.max.x, b.min.y, b.min.z) + offset;
			var p3 = new Vector3(b.max.x, b.min.y, b.max.z) + offset;
			var p4 = new Vector3(b.min.x, b.min.y, b.max.z) + offset;

			Debug.DrawLine(p1, p2, color, delay);
			Debug.DrawLine(p2, p3, color, delay);
			Debug.DrawLine(p3, p4, color, delay);
			Debug.DrawLine(p4, p1, color, delay);

			// top
			var p5 = new Vector3(b.min.x, b.max.y, b.min.z) + offset;
			var p6 = new Vector3(b.max.x, b.max.y, b.min.z) + offset;
			var p7 = new Vector3(b.max.x, b.max.y, b.max.z) + offset;
			var p8 = new Vector3(b.min.x, b.max.y, b.max.z) + offset;

			Debug.DrawLine(p5, p6, color, delay);
			Debug.DrawLine(p6, p7, color, delay);
			Debug.DrawLine(p7, p8, color, delay);
			Debug.DrawLine(p8, p5, color, delay);

			// sides
			Debug.DrawLine(p1, p5, color, delay);
			Debug.DrawLine(p2, p6, color, delay);
			Debug.DrawLine(p3, p7, color, delay);
			Debug.DrawLine(p4, p8, color, delay);
		}
	}
}