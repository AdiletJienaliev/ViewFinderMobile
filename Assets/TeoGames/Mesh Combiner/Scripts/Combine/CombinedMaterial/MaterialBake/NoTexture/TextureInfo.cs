using System;
using UnityEngine;
using UnityEngine.Serialization;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial.MaterialBake.NoTexture {
	[Serializable]
	public class TextureInfo {
		[FormerlySerializedAs("propertyName")] [Tooltip("Property name of texture in output material")]
		public string textureName;

		[Tooltip("Texture format to use in output material")]
		public TextureFormat format;
		
		[Tooltip("Texture sRGB")]
		public bool linear = true;

		[Tooltip("Will use that color if there is not specified keyword in source material")]
		public Color defaultColor;

		[HideInInspector] public Texture2D texture;
	}
}