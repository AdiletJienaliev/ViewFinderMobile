using TeoGames.Mesh_Combiner.Scripts.Combine;
using TeoGames.Mesh_Combiner.Scripts.Editor.MenuItems;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using TeoGames.Mesh_Combiner.Scripts.Util;
using UnityEditor;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Editor {
	[CustomPropertyDrawer(typeof(CombinableCacheProperty))]
	public class CombinableCacheDrawer : PropertyDrawer {
		public override void OnGUI(Rect position, SerializedProperty property, GUIContent label) {
			EditorGUI.PropertyField(position, property, label, true);

			if (property.isExpanded) {
				if (GUILayout.Button("Reset Cache")) {
					Selection.gameObjects.ForEach(o => o
						.GetComponentsInChildren<AbstractCombinable>()
						.ForEach(Utils.LogClearCache));
				}
			}
		}

		public override float GetPropertyHeight(SerializedProperty property, GUIContent label) {
			return EditorGUI.GetPropertyHeight(property, label);
		}
	}
}