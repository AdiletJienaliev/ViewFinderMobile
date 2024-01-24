using System;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Extension.Editor {
	public static class PrefabExtension {
		private static readonly int PrefabExtensionLength = ".prefab".Length;

		public static (GameObject root, string folder) OpenPrefab(this GameObject obj) {
			if (!AssetDatabase.OpenAsset(obj)) throw new Exception("Object is not prefab");

			var stage = PrefabStageUtility.GetCurrentPrefabStage();
			if (!stage) throw new Exception("Unable to open prefab editor");

			return (stage.prefabContentsRoot, stage.assetPath.RemoveLast(PrefabExtensionLength) + "/");
		}

		public static void SaveAndClosePrefab(this GameObject obj) {
			EditorUtility.SetDirty(obj);
			PrefabUtility.RecordPrefabInstancePropertyModifications(obj);
			AssetDatabase.SaveAssets();
			AssetDatabase.Refresh();
			StageUtility.GoBackToPreviousStage();
		}
	}
}