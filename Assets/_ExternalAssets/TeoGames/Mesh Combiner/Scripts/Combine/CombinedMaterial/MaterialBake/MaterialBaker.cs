using System;
using System.Collections.Generic;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial.MaterialBake {
	[CreateAssetMenu(menuName = "Mesh Combiner/MC Material Baker/Baker Settings", fileName = "Baker Settings")]
	public class MaterialBaker : ScriptableObject {
		public AbstractShaderBaker[] bakeInstances = Array.Empty<AbstractShaderBaker>();

		private readonly Dictionary<Material, (Material, MeshParser)> _Cache =
			new Dictionary<Material, (Material, MeshParser)>();

		public readonly Dictionary<Shader, List<AbstractShaderBaker>> Bakers =
			new Dictionary<Shader, List<AbstractShaderBaker>>();

		private static MaterialBaker INSTANCE;

		public static MaterialBaker Instance =>
			INSTANCE ? INSTANCE : INSTANCE = Instantiate(Resources.Load<MaterialBaker>("Baker Settings"));

		private void Awake() {
			bakeInstances.ForEach(b => { Instantiate(b).Inject(this); });
		}

		public void RegisterBaker(Shader shader, AbstractShaderBaker baker) {
			if (!Bakers.TryGetValue(shader, out var bakers)) {
				bakers = new List<AbstractShaderBaker>();
				Bakers.Add(shader, bakers);
			}

			bakers.Add(baker);
		}

		public (Material material, MeshParser parser) RegisterMaterial(Material material) {
			if (_Cache.TryGetValue(material, out var res)) return res;

			res = ParseMaterial(material);
			_Cache.Add(material, res);

			return res;
		}

		private (Material, MeshParser) ParseMaterial(Material material) {
			var shader = material.shader;
			if (!Bakers.TryGetValue(shader, out var bakers)) {
				Debug.LogWarning($"Baker is not found for shader {shader.name}");
				return (material, null);
			}

			var cnt = bakers.Count;
			for (var i = 0; i < cnt; i++) {
				var baker = bakers[i];
				if (baker.IsValidMaterial(material)) return baker.Bake(material);
			}

			return (material, null);
		}
	}
}