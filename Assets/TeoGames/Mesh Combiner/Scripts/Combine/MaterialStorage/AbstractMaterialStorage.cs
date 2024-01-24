using System;
using System.Collections.Generic;
using TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial;
using TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial.MaterialBake;
using UnityEngine;
using UnityEngine.Rendering;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.MaterialStorage {
	using MaterialType = ValueTuple<MeshParser, BasicMaterial>;

	public abstract class AbstractMaterialStorage {
		public abstract IEnumerable<BasicMaterial> List { get; }
		public abstract MaterialType Get(long mID, Material mat, int offset, ShadowCastingMode shadow, bool isStatic);
		public abstract bool TryFind(long matID, out BasicMaterial mat);

		protected BasicMaterial GetMaterialInstance(ShadowCastingMode shadow, bool isStatic, Material mat) {
			return isStatic ? new BasicMaterial(mat, shadow) : new DynamicMaterial(mat, shadow);
		}
	}
}