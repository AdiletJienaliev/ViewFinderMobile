using TeoGames.Mesh_Combiner.Scripts.Combine;
using TeoGames.Mesh_Combiner.Scripts.Editor.MenuItems;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using TeoGames.Mesh_Combiner.Scripts.Extension.Editor;
using UnityEditor;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Editor {
	[CustomEditor(typeof(AbstractMeshCombiner), true)]
	[CanEditMultipleObjects]
	public class AbstractMeshCombinerEditor : UnityEditor.Editor {
		private static readonly int _ASSET_EXTENSION_LENGTH = ".asset".Length;

		public override void OnInspectorGUI() {
			base.OnInspectorGUI();

			var textStyle = EditorStyles.label;
			textStyle.wordWrap = true;

			targets.ForEach(
				t => {
					if (!(t is ChunkMeshCombiner cmc)) return;

					var status = cmc.updateQueue.IsStarted ? "active" : "inactive";
					GUILayout.Label($"Update queue is {status}, with {cmc.updateQueue.Count} items", textStyle);
				});

			GUILayout.Space(20);

			if (targets.Length != 1) {
				GUILayout.Label("Mesh baking can work only with single selected combiner", textStyle);
			} else {
				var c = ((AbstractMeshCombiner)target).gameObject;

				GUILayout.Label(
					"Mesh baking will generate all renderers as it works in runtime and save meshes to the file, after baking all original meshes will be disabled.",
					textStyle
				);

				if (GUILayout.Button("Bake mesh")) {
					var isPrefab = c.scene.name == null;
					var (obj, folder) = isPrefab
						? c.OpenPrefab()
						: (c, c.scene.path.RemoveLast(_ASSET_EXTENSION_LENGTH) + "/");

					BakingUtils.Bake(obj, folder).ContinueWith(
						() => {
							if (isPrefab) obj.SaveAndClosePrefab();
						}
					);
				}

				if (BakingUtils.IsBaked(c) && GUILayout.Button("Remove baked mesh")) {
					var obj = c.scene.name != null ? c : c.OpenPrefab().root;
					BakingUtils.RemoveBake(obj);
					obj.SaveAndClosePrefab();
				}
			}
		}
	}
}