using System;
using UnityEngine;
using UnityEngine.Rendering;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial.MaterialBake.NoTexture {
	[Serializable]
	public class MaterialTextureInfo {
		[Tooltip("Property name of texture in output material")]
		public string textureName;

		[Tooltip("Property name in source material")]
		public string propertyName;

		[Tooltip("Property type in source material")]
		public ShaderPropertyType propertyType;
	}
}