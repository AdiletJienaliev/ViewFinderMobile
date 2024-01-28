using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Extension {
	public static class Vector2Extensions {
		public static Vector2 Round(this Vector2 v) {
			return new Vector2(
				Mathf.Round(v.x),
				Mathf.Round(v.y)
			);
		}

		public static readonly Vector2 One = Vector2.one;
	}
}