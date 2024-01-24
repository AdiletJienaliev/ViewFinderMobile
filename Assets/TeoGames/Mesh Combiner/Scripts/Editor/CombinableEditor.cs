using System;
using TeoGames.Mesh_Combiner.Scripts.Combine;
using TeoGames.Mesh_Combiner.Scripts.Editor.MenuItems;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEditor;
using UnityEngine;
using Object = UnityEngine.Object;

namespace TeoGames.Mesh_Combiner.Scripts.Editor {
	[CustomEditor(typeof(AbstractCombinable), true)]
	[CanEditMultipleObjects]
	public class CombinableEditor : UnityEditor.Editor {
		private bool _ShowLiveSync;

		public override void OnInspectorGUI() {
			base.OnInspectorGUI();

			targets.ForEach(RenderInstance);
		}

		private void RenderInstance(Object obj) {
			var comb = (AbstractCombinable)obj;

			try {
				Utils.ClearCache(comb);
			} catch (Exception ex) {
				Debug.LogException(ex, comb);
			}
		}
	}
}