using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using TeoGames.Mesh_Combiner.Scripts.Combine;
using TeoGames.Mesh_Combiner.Scripts.Combine.Interfaces;
using TeoGames.Mesh_Combiner.Scripts.Combine.PreBake;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEditor;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Editor.MenuItems {
	public static class BakingUtils {
		public static async Task Bake(UnityEngine.GameObject obj, string folder) {
			Debug.Log($"-- Bake {obj.name}", obj);
			MeshExtension.ResetCache();
			RemoveBake(obj);

			var combiner = obj.AddComponent<MeshCombiner>();
			combiner.asyncMode = false;

			var combiners = obj.GetComponentsInChildren<AbstractMeshCombiner>();
			combiners.ForEach(c => c.Init());

			var combinablesToClear = new List<AbstractCombinable>();
			var combinablesToDisable = new List<AbstractCombinable>();

			// Bake mesh renderers
			obj.GetComponentsInChildren<MeshRenderer>(false).ForEach(
				r => {
					if (!r.TryGetComponent<AbstractCombinable>(out var comb)) {
						if (!r.enabled) return;

						r.gameObject.AddComponent<BakedMesh>();
						var combinable = r.gameObject.AddComponent<Combinable>();
						combinable.isStatic = true;

						comb = combinable;
						combinablesToClear.Add(comb);
					} else if (comb.IsActive) {
						comb.gameObject.AddComponent<BakedMesh>();
						combinablesToDisable.Add(comb);
					} else return;

					comb.ClearCache(true);
					var c = comb.GetCombiner();
					if (combiners.Contains(c)) comb.Include();
					else Debug.LogError("Can't find container", comb);
				}
			);

			// Bake skinned mesh renderers
			obj.GetComponentsInChildren<SkinnedMeshRenderer>(false).ForEach(
				r => {
					if (!r.TryGetComponent<AbstractCombinable>(out var comb)) {
						if (!r.enabled) return;

						r.gameObject.AddComponent<BakedMesh>();
						var combinable = r.gameObject.AddComponent<Combinable>();
						combinable.isStatic = false;

						comb = combinable;
						combinablesToClear.Add(comb);
					} else if (comb.IsActive) {
						comb.gameObject.AddComponent<BakedMesh>();
						combinablesToDisable.Add(comb);
					} else return;

					comb.ClearCache(true);
					var c = comb.GetCombiner();
					if (combiners.Contains(c)) comb.Include();
					else Debug.LogError("Can't find container", comb);
				}
			);

			try {
				var tasks = combiners.Select(
					c => Task.WhenAll(
						c.IsLodReady ? c.Lod.Combiner.UpdateTask : Task.CompletedTask,
						c is IAsyncCombiner async ? async.UpdateTask : Task.CompletedTask
					)
				);
				await Task.WhenAll(tasks).WaitForUpdate();
			} finally {
				Debug.Log("- Saving Models");
				combinablesToClear.ForEach(Object.DestroyImmediate);
				combinablesToDisable.ForEach(c => c.enabled = false);
				combiners.ForEach(
					c => {
						c.GetRenderers().ForEach(
							r => {
								r.SaveMesh(folder);
								r.gameObject.AddComponent<BakedRenderer>();
							}
						);

						if (c is IPostBakeAction pbc) pbc.PostBakeAction();
					}
				);

				// Remove temporary combiner
				Object.DestroyImmediate(combiner);
				EditorUtility.SetDirty(obj);

				Debug.Log($"- Done!");
			}
		}

		public static void RemoveBake(UnityEngine.GameObject obj) {
			Debug.Log($"-- Clean baking at {obj.name}", obj);

			obj.GetComponentsInChildren<AbstractMeshCombiner>().ForEach(c => c.Clear());

			// Reset source meshes
			obj.GetComponentsInChildren<BakedMesh>(true).ForEach(
				m => {
					m.GetComponent<Renderer>().enabled = true;
					if (m.TryGetComponent<AbstractCombinable>(out var comb)) comb.enabled = true;

					Object.DestroyImmediate(m);
				}
			);

			// Combinables
			obj.GetComponentsInChildren<AbstractCombinable>(true).ForEach(
				c => {
					if (c.enabled && c is IVisibilityToglable vis) vis.OnExclude();
				}
			);

			// Remove renderers of baked mesh
			obj.GetComponentsInChildren<BakedRenderer>(true).ForEach(
				m => {
					m.GetComponent<Renderer>().DeleteMesh();
					Object.DestroyImmediate(m.gameObject);
				}
			);

			Debug.Log("-- Cleaning completed!", obj);
		}

		public static bool IsBaked(Object target) {
			var obj = target as UnityEngine.GameObject;
			if (!obj) return false;

			return obj.GetComponentsInChildren<BakedRenderer>(true).Any() ||
			       obj.GetComponents<AbstractMeshCombiner>().Any(c => c.GetRenderers().Any());
		}
	}
}