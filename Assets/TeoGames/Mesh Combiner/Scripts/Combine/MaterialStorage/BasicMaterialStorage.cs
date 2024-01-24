using System;
using System.Collections.Generic;
using TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial;
using TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial.MaterialBake;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using TeoGames.Mesh_Combiner.Scripts.Profile;
using UnityEngine;
using UnityEngine.Rendering;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.MaterialStorage {
	using MaterialType = ValueTuple<MeshParser, BasicMaterial>;

	public class BasicMaterialStorage : AbstractMaterialStorage {
		private readonly Dictionary<long, BasicMaterial> _Materials = new Dictionary<long, BasicMaterial>();

		public override IEnumerable<BasicMaterial> List => _Materials.Values;

		public override bool TryFind(long matID, out BasicMaterial mat) {
			return _Materials.TryGetValue(matID, out mat);
		}

		public override MaterialType Get(long mID, Material mat, int offset, ShadowCastingMode shadow, bool isStatic) {
			if (!_Materials.TryGetValue(mID, out var material)) {
				material = shadow.GetMaterialInstance(isStatic, mat);
				_Materials.Add(mID, material);
				ProfilerModule.TotalMaterials.Value++;
			}

			return (null, material);
		}
	}
}