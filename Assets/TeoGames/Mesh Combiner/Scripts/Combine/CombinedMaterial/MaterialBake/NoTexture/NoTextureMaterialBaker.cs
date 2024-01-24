using System;
using System.Collections.Generic;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEngine;
using UnityEngine.Rendering;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial.MaterialBake.NoTexture {
	[CreateAssetMenu(menuName = "Mesh Combiner/MC Material Baker/No Texture Baker", fileName = "No Texture Baker")]
	public class NoTextureMaterialBaker : AbstractShaderBaker {
		[Tooltip("Amount of colors that can be baked")]
		public int textureSize = 128;

		[Tooltip(
			"Width of each cell on texture. May help reduce artifacts on small objects. Will increase actual texture size")]
		public int cellSize = 3;

		public SurfaceType surface = SurfaceType.Opaque | SurfaceType.Transparent;

		public Shader targetShader;

		public TextureInfo[] textures;
		public ShaderConfig[] shaders;

		private Dictionary<Shader, ShaderConfig> _Shaders;

		private Material _Material;
		private int _FreeIndex = 0;

		public override void Inject(MaterialBaker instance) {
			shaders.ForEach(m => instance.RegisterBaker(m.shader, this));
		}

		protected SurfaceType GetSurface(Material mat) {
			return mat.renderQueue >= 3000 ? SurfaceType.Transparent : SurfaceType.Opaque;
		}

		public override bool IsValidMaterial(Material material) {
			return (surface & GetSurface(material)) != 0 && !material.HasTextures();
		}

		protected override void Initialize(Material material) {
			_Material = new Material(targetShader) {
				name = $"[{material.renderQueue}] {material.shader.name}",
				renderQueue = material.renderQueue
			};

			foreach (var texture in textures) {
				_Material.SetTexture(texture.textureName, texture.texture = new Texture2D(
					textureSize * cellSize,
					1,
					texture.format,
					false,
					texture.linear
				) {
					filterMode = FilterMode.Point,
					name = texture.textureName,
				});
			}

			_Shaders = new Dictionary<Shader, ShaderConfig>(shaders.Length);
			foreach (var shader in shaders) _Shaders.Add(shader.shader, shader);
		}

		protected override (Material bakedMaterial, MeshParser meshParser) BakeMaterial(
			Material material
		) {
			var conf = _Shaders[material.shader];

			var values = new Dictionary<string, Color>();
			foreach (var property in conf.properties) {
				values.Add(property.textureName, property.propertyType switch {
					ShaderPropertyType.Color => material.GetColor(property.propertyName),
					ShaderPropertyType.Float => new Color(material.GetFloat(property.propertyName), 0, 0),
					_ => throw new Exception($"Invalid property type: {property.propertyType.ToString()}")
				});
			}

			var start = _FreeIndex * cellSize;
			var end = start + cellSize;
			foreach (var textureInfo in textures) {
				if (!values.TryGetValue(textureInfo.textureName, out var color)) color = textureInfo.defaultColor;
				for (var i = start; i < end; i++) {
					textureInfo.texture.SetPixel(i, 0, color);
				}

				textureInfo.texture.Apply();
			}

			var id = _FreeIndex++;
			var scale = 1f / textureSize;
			var cellScale = scale * .008f;
			var offset = (id + .499f) * scale * Vector2Extensions.One;

			return (_Material, new MeshParser(cellScale, offset));
		}
	}
}