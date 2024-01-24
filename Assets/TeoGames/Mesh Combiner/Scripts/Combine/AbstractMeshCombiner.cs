using System;
using TeoGames.Mesh_Combiner.Scripts.Combine.Lod;
using TeoGames.Mesh_Combiner.Scripts.Combine.MeshRendererManager;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Combine {
	public abstract class AbstractMeshCombiner : MonoBehaviour {
		public abstract void Include(AbstractCombinable combinable);
		public abstract void Exclude(AbstractCombinable combinable);

		public abstract void Init();

		public abstract void Clear();

		public abstract Renderer[] GetRenderers();

		[Tooltip("List of key to accept combinable. Allow any if empty")]
		public string[] keys = Array.Empty<string>();

		[Tooltip(
			"Define max time in ms per frame that combiner can work. Note that in case of huge meshes it still can take more time"
		)]
		[Min(1)]
		public int maxBuildTime = 5;

		[Tooltip("Define which renderers can be used")]
		public TargetRendererType rendererTypes =
			TargetRendererType.MeshRenderer | TargetRendererType.SkinnerMeshRenderer;

		[Tooltip("Configuration for LOD baking")] [SerializeField]
		private LodConfiguration lod = new LodConfiguration();

		public bool IsLodReady => lod.Combiner;

		public LodConfiguration Lod {
			get {
				if (!IsLodReady) lod.Init(this);

				return lod;
			}
		}
	}
}