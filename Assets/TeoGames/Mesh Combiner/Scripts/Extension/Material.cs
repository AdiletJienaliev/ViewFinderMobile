using System;
using System.Linq;
using TeoGames.Mesh_Combiner.Scripts.Profile;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Extension {
	public static class MaterialExtension {
		public static readonly McProfiler GetCombineIDProf = new McProfiler("MaterialExtension => GetCombineID");

		public static long GetCombineID(this Material material, int offset) {
			try {
				return offset + material.GetInstanceID();
			} catch (Exception) {
				return offset;
			}
		}

		public static bool HasTextures(this Material material) {
			return material.GetTexturePropertyNameIDs().Any(id => material.GetTexture(id) != null);
		}
	}
}