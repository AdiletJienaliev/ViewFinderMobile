using System;
using System.Linq;
using TeoGames.Mesh_Combiner.Scripts.Combine;
using TeoGames.Mesh_Combiner.Scripts.Combine.SceneCombiner;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace TeoGames.Mesh_Combiner.Scripts.Editor.MenuItems {
	public class MainMenu : AssetModificationProcessor {
		[MenuItem("Tools/Dynamic Mesh Combiner/Add Scene Combiner", false, 1000)]
		public static void AddSceneCombiner() {
			var obj = new UnityEngine.GameObject("Scene Combiner Registry");
			obj.transform.SetSiblingIndex(0);

			var registry = obj.AddComponent<SceneCombinerRegistry>();
			registry.combiners = new AbstractMeshCombiner[] { obj.AddComponent<MeshCombiner>() };
		}

		[MenuItem("Tools/Dynamic Mesh Combiner/Prefabs/Clear Cache", false, 1100)]
		public static void FixPrefabsCache() {
			Utils.GetPrefabs("Assets").ForEach(
				obj => {
					var isChanged = obj.GetComponentsInChildren<Combinable>(true).Any(Utils.CheckClearCache);

					if (isChanged) PrefabUtility.SavePrefabAsset(obj);
				}
			);
		}

		[MenuItem("Tools/Dynamic Mesh Combiner/Scenes/Clear Cache", false, 1101)]
		public static void FixScenesCache() {
			var originalScene = SceneManager.GetActiveScene().path;

			foreach (var sceneGuid in AssetDatabase.FindAssets("t:Scene", new string[] { "Assets" })) {
				try {
					var scenePath = AssetDatabase.GUIDToAssetPath(sceneGuid);

					Debug.Log($"-- {scenePath}");

					EditorSceneManager.OpenScene(scenePath, OpenSceneMode.Additive);
					var scene = SceneManager.GetActiveScene();
					var isChanged = false;

					scene.GetRootGameObjects().ForEach(
						obj => {
							isChanged |= obj.GetComponentsInChildren<Combinable>(true).Any(Utils.CheckClearCache);
						}
					);

					if (isChanged) EditorSceneManager.SaveScene(scene);
					if (scenePath != originalScene) EditorSceneManager.CloseScene(scene, true);
				} catch (Exception e) {
					Debug.LogException(e);
				}
			}

			if (originalScene != "") EditorSceneManager.OpenScene(originalScene);
		}
	}
}