using System.Collections.Generic;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif

namespace TeoGames.Mesh_Combiner.Scripts.Util {
	public abstract class ErrorPool {
		private static readonly List<string> History = new List<string>();

#if UNITY_EDITOR
		[InitializeOnEnterPlayMode, InitializeOnLoadMethod]
		private static void OnEnterPlaymodeInEditor() {
			History.Clear();
		}
#endif

		public static void Error(string message) {
			if (!History.Contains(message)) {
				History.Add(message);
				Debug.LogError(message);
			}
		}
	}
}