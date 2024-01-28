using System.Collections.Generic;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial.MaterialBake {
	public abstract class AbstractShaderBaker : ScriptableObject {
		public abstract void Inject(MaterialBaker instance);
		protected abstract void Initialize(Material material);

		protected abstract (Material bakedMaterial, MeshParser meshParser) BakeMaterial(Material material);

		public virtual bool IsValidMaterial(Material material) => true;

		private readonly Dictionary<int, AbstractShaderBaker> _RenderQueueCache =
			new Dictionary<int, AbstractShaderBaker>();

		public (Material bakedMaterial, MeshParser meshParser) Bake(Material material) {
			if (_RenderQueueCache.TryGetValue(material.renderQueue, out var instance)) {
				return instance.BakeMaterial(material);
			}

			instance = Instantiate(this);
			instance.Initialize(material);
			_RenderQueueCache.Add(material.renderQueue, instance);

			return instance.BakeMaterial(material);
		}
	}
}