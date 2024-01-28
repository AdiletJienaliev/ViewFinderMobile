using System;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial.MaterialBake.NoTexture {
	[Serializable]
	public class ShaderConfig {
		[Tooltip("Shader that will be accepted")]
		public Shader shader;

		[Tooltip("Property name of texture in output material")]
		public MaterialTextureInfo[] properties;
	}
}