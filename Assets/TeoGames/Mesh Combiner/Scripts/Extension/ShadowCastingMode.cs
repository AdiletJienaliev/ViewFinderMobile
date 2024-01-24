using TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial;
using UnityEngine;
using UnityEngine.Rendering;

namespace TeoGames.Mesh_Combiner.Scripts.Extension {
	public static class ShadowCastingModeExtensions {
		public static BasicMaterial GetMaterialInstance(this ShadowCastingMode shadow, bool isStatic, Material mat) {
			return isStatic ? new BasicMaterial(mat, shadow) : new DynamicMaterial(mat, shadow);
		}
	}
}