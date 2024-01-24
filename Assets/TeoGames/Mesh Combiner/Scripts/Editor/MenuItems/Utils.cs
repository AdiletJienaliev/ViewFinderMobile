using System;
using System.Collections.Generic;
using System.IO;
using TeoGames.Mesh_Combiner.Scripts.Combine;
using TeoGames.Mesh_Combiner.Scripts.Combine.Lod;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEditor;
using UnityEngine;
using Object = UnityEngine.Object;

namespace TeoGames.Mesh_Combiner.Scripts.Editor.MenuItems {
	public static class Utils {
		public static IEnumerable<UnityEngine.GameObject> GetPrefabs(IEnumerable<Object> objs) {
			foreach (var obj in objs) {
				if (obj is UnityEngine.GameObject res) yield return res;

				var path = obj == null ? "Assets" : AssetDatabase.GetAssetPath(obj.GetInstanceID());

				if (path.Length > 0 && Directory.Exists(path)) {
					foreach (var resObj in GetPrefabs(path)) yield return resObj;
				}
			}
		}

		public static IEnumerable<UnityEngine.GameObject> GetPrefabs(string path) {
			var prefabs = AssetDatabase.FindAssets("t:prefab", new string[] { path });

			foreach (var prefabId in prefabs) {
				var prefabPath = AssetDatabase.GUIDToAssetPath(prefabId);
				var pref = AssetDatabase.LoadAssetAtPath<UnityEngine.GameObject>(prefabPath);

				if (pref) yield return pref;
			}
		}

		public static void SetupMeshCombiner(UnityEngine.GameObject obj) {
			if (!obj.GetComponent<MeshCombiner>()) {
				obj.AddComponent<MeshCombiner>();

				Debug.Log($"Added Mesh Combiner to {obj.name}", obj);
			}

			obj.GetComponentsInChildren<MeshRenderer>(true).ForEach(AddStaticCombiner);
			obj.GetComponentsInChildren<SkinnedMeshRenderer>(true).ForEach(AddDynamicCombiner);
		}

		public static void SetupChunkMeshCombiner(UnityEngine.GameObject obj) {
			if (!obj.GetComponent<ChunkMeshCombiner>()) {
				obj.AddComponent<ChunkMeshCombiner>();

				Debug.Log($"Added Chunk Mesh Combiner to {obj.name}", obj);
			}

			obj.GetComponentsInChildren<MeshRenderer>(true).ForEach(AddStaticCombiner);
			obj.GetComponentsInChildren<SkinnedMeshRenderer>(true).ForEach(AddDynamicCombiner);
		}

		public static void AddStaticCombiner(MeshRenderer ren) {
			if (ren.TryGetComponent<Combinable>(out var comb)) {
				comb.UpdateStatus();
				return;
			}

			try {
				if (ren.GetComponentInParent<LODGroup>()) {
					comb = ren.gameObject.AddComponent<LodCombinable>();
					comb.isStatic = true;
					comb.ClearCache(true);

					Debug.Log($"Added static LOD Combinable to {ren.name}", ren);
				} else {
					comb = ren.gameObject.AddComponent<Combinable>();
					comb.isStatic = true;
					comb.ClearCache(true);

					Debug.Log($"Added static Combinable to {ren.name}", ren);
				}

				EditorUtility.SetDirty(comb);
			} catch (Exception e) {
				Debug.LogError($"Unable to add combinable for {ren.name}", ren);
				Debug.LogException(e, ren);
			}
		}

		public static void RemoveCombiner(AbstractCombinable comb) {
			Debug.Log($"Removed Combinable at {comb.name}", comb.gameObject);
			Object.DestroyImmediate(comb, true);
		}

		public static bool CheckClearCache(AbstractCombinable comb) {
			Debug.Log($"Clear cache at {comb.name}", comb.gameObject);

			return ClearCache(comb);
		}

		public static void LogClearCache(AbstractCombinable comb) {
			Debug.Log($"Clear cache at {comb.name}", comb.gameObject);

			ClearCache(comb);
		}

		public static bool ClearCache(AbstractCombinable comb) {
			var oldCache = comb.GetCache();
			comb.ClearCache(true);

			if (comb.GetCache().IsDifferent(oldCache)) {
				EditorUtility.SetDirty(comb);

				return true;
			}

			return false;
		}

		public static void AddDynamicCombiner(SkinnedMeshRenderer ren) {
			if (ren.TryGetComponent<Combinable>(out var comb)) {
				comb.UpdateStatus();
				return;
			}

			if (ren.GetComponentInParent<LODGroup>()) {
				var combinable = ren.gameObject.AddComponent<LodCombinable>();
				combinable.isStatic = false;
				combinable.ClearCache(true);

				Debug.Log($"Added dynamic LOD Combinable to {ren.name}", ren);
			} else {
				var combinable = ren.gameObject.AddComponent<Combinable>();
				combinable.isStatic = false;
				combinable.ClearCache(true);

				Debug.Log($"Added dynamic Combinable to {ren.name}", ren);
			}
		}
	}
}