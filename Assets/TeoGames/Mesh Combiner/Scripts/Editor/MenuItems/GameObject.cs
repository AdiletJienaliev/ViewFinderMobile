using TeoGames.Mesh_Combiner.Scripts.Combine;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEditor;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace TeoGames.Mesh_Combiner.Scripts.Editor.MenuItems {
	public class GameObject : AssetModificationProcessor {
		private static readonly int AssetExtensionLength = ".asset".Length;

		[MenuItem("GameObject/Dynamic Mesh Combiner/Clear Cache", false, 1)]
		public static void FixCache() {
			Selection.gameObjects.ForEach(
				o => o.GetComponentsInChildren<AbstractCombinable>().ForEach(Utils.LogClearCache)
			);
		}

		[MenuItem("GameObject/Dynamic Mesh Combiner/Setup Mesh Combiner", false, 100)]
		public static void SetupMeshCombiner() {
			Selection.gameObjects.ForEach(Utils.SetupMeshCombiner);
		}

		[MenuItem("GameObject/Dynamic Mesh Combiner/Setup Chunk Mesh Combiner", false, 101)]
		public static void SetupLodMeshCombiner() {
			Selection.gameObjects.ForEach(Utils.SetupChunkMeshCombiner);
		}

		[MenuItem("GameObject/Dynamic Mesh Combiner/Add Combinables", false, 200)]
		public static void AddCombinables(MenuCommand data) {
			var obj = data.context as UnityEngine.GameObject;
			if (!obj) return;

			obj.GetComponentsInChildren<MeshRenderer>(true).ForEach(Utils.AddStaticCombiner);
			obj.GetComponentsInChildren<SkinnedMeshRenderer>(true).ForEach(Utils.AddDynamicCombiner);
		}

		[MenuItem("GameObject/Dynamic Mesh Combiner/Remove Combinables", false, 201)]
		public static void RemoveCombinables(MenuCommand data) {
			var obj = data.context as UnityEngine.GameObject;
			if (!obj) return;

			obj.GetComponentsInChildren<Combinable>(true).ForEach(Utils.RemoveCombiner);
		}

		[MenuItem("GameObject/Dynamic Mesh Combiner/Bake Mesh", false, 301)]
		public static void BakeMesh() =>
			BakingUtils.Bake(
				Selection.activeGameObject,
				SceneManager.GetActiveScene().path.RemoveLast(AssetExtensionLength) + "/"
			).Forget();

		[MenuItem("GameObject/Dynamic Mesh Combiner/Remove Baked Mesh", false, 302)]
		public static void RemoveBakedMesh() => BakingUtils.RemoveBake(Selection.activeGameObject);

		[MenuItem("GameObject/Dynamic Mesh Combiner/Add Combinables", true)]
		[MenuItem("GameObject/Dynamic Mesh Combiner/Remove Combinables", true)]
		[MenuItem("GameObject/Dynamic Mesh Combiner/Bake Mesh", true)]
		private static bool OnlyOneItem() => Selection.gameObjects.Length == 1;

		[MenuItem("GameObject/Dynamic Mesh Combiner/Remove Baked Mesh", true)]
		public static bool IsBaked(MenuCommand data) {
			return Selection.gameObjects.Length == 1 && BakingUtils.IsBaked(Selection.activeGameObject);
		}
	}
}