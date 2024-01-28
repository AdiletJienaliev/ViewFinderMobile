using TeoGames.Mesh_Combiner.Scripts.Combine;
using UnityEditor;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Editor.MenuItems {
	public class Context : AssetModificationProcessor {
		[MenuItem("CONTEXT/Combinable/Dynamic Mesh Combiner/Clear Cache", false, 1000)]
		public static void FixCache(MenuCommand data) {
			var obj = data.context as Combinable;
			if (obj) Utils.LogClearCache(obj);
		}

		[MenuItem("CONTEXT/Renderer/Dynamic Mesh Combiner/Add Combinable", false, 1000)]
		public static void AddStaticCombinable(MenuCommand data) {
			var ren = data.context as MeshRenderer;
			if (ren) Utils.AddStaticCombiner(ren);
		}

		[MenuItem("CONTEXT/SkinnedMeshRenderer/Dynamic Mesh Combiner/Add Combinable", false, 1001)]
		public static void AddDynamicCombinable(MenuCommand data) {
			var ren = data.context as SkinnedMeshRenderer;
			if (ren) Utils.AddDynamicCombiner(ren);
		}

		[MenuItem("CONTEXT/Renderer/Dynamic Mesh Combiner/Add Combinable", true, 1000)]
		[MenuItem("CONTEXT/SkinnedMeshRenderer/Dynamic Mesh Combiner/Add Combinable", true, 1001)]
		private static bool DontHaveCombinable(MenuCommand data) {
			var comp = data.context as Component;
			if (!comp) return false;

			return !comp.GetComponent<AbstractCombinable>();
		}
	}
}