using System.Linq;
using TeoGames.Mesh_Combiner.Scripts.Combine;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using TeoGames.Mesh_Combiner.Scripts.Extension.Editor;
using UnityEditor;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Editor.MenuItems {
	public class Assets : AssetModificationProcessor {
		[MenuItem("Assets/Dynamic Mesh Combiner/Clear Cache", false, 1)]
		public static void ClearCache() {
			Utils.GetPrefabs(Selection.objects).ForEach(
				obj => {
					var isChanged = obj.GetComponentsInChildren<Combinable>(true).Any(Utils.CheckClearCache);
					if (isChanged) PrefabUtility.SavePrefabAsset(obj);
				}
			);
		}

		[MenuItem("Assets/Dynamic Mesh Combiner/Setup Mesh Combiner", false, 100)]
		public static void SetupMeshCombiner() {
			Utils.GetPrefabs(Selection.objects).ForEach(
				obj => {
					Utils.SetupMeshCombiner(obj);

					PrefabUtility.SavePrefabAsset(obj);
				}
			);
		}

		[MenuItem("Assets/Dynamic Mesh Combiner/Setup Chunk Mesh Combiner", false, 101)]
		public static void SetupLodMeshCombiner() {
			Utils.GetPrefabs(Selection.objects).ForEach(
				obj => {
					Utils.SetupChunkMeshCombiner(obj);

					PrefabUtility.SavePrefabAsset(obj);
				}
			);
		}

		[MenuItem("Assets/Dynamic Mesh Combiner/Add Combinables", false, 201)]
		public static void AddCombinables() {
			Utils.GetPrefabs(Selection.objects).ForEach(
				obj => {
					var mr = obj.GetComponentsInChildren<MeshRenderer>(true);
					var smr = obj.GetComponentsInChildren<SkinnedMeshRenderer>(true);

					mr.ForEach(Utils.AddStaticCombiner);
					smr.ForEach(Utils.AddDynamicCombiner);

					if (mr.Any() || smr.Any()) PrefabUtility.SavePrefabAsset(obj);
				}
			);
		}

		[MenuItem("Assets/Dynamic Mesh Combiner/Remove Combinables", false, 202)]
		public static void RemoveCombinables() {
			Utils.GetPrefabs(Selection.objects).ForEach(
				obj => {
					var list = obj.GetComponentsInChildren<Combinable>(true);
					list.ForEach(Utils.RemoveCombiner);

					if (list.Any()) PrefabUtility.SavePrefabAsset(obj);
				}
			);
		}

		[MenuItem("Assets/Dynamic Mesh Combiner/Bake Mesh", false, 301)]
		public static async void BakeMesh(MenuCommand data) {
			await Utils.GetPrefabs(Selection.objects).ForEach(
				async prefab => {
					var (obj, folder) = prefab.OpenPrefab();
					await BakingUtils.Bake(obj, folder);
					obj.SaveAndClosePrefab();
				}
			);

			Debug.Log("Baking Completed!");
		}

		[MenuItem("Assets/Dynamic Mesh Combiner/Remove Baked Mesh", false, 302)]
		public static void RemoveBakeDMesh(MenuCommand data) {
			Utils.GetPrefabs(Selection.objects).ForEach(
				prefab => {
					if (!BakingUtils.IsBaked(prefab)) return;

					var (obj, _) = prefab.OpenPrefab();
					try {
						BakingUtils.RemoveBake(obj);
					} finally {
						obj.SaveAndClosePrefab();
					}
				}
			);
		}

		[MenuItem("Assets/Dynamic Mesh Combiner/Bake Mesh", true)]
		public static bool IsPrefab() => Utils.GetPrefabs(Selection.objects).Any();

		[MenuItem("Assets/Dynamic Mesh Combiner/Remove Baked Mesh", true)]
		public static bool IsBaked() => Utils.GetPrefabs(Selection.objects).Any(BakingUtils.IsBaked);
	}
}