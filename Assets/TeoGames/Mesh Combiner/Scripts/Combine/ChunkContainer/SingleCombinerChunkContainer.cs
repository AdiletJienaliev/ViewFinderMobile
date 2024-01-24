using System;
using System.Threading.Tasks;
using TeoGames.Mesh_Combiner.Scripts.Combine.MeshRendererManager;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.ChunkContainer {
	public abstract class SingleCombinerChunkContainer : AbstractChunkContainer {
		protected MeshCombiner Combiner;

		public override Task UpdateTask => Combiner.UpdateTask;

		public override Renderer[] GetRenderers() => Combiner ? Combiner.GetRenderers() : Array.Empty<Renderer>();

		public override void Init(
			TargetRendererType rendererTypes,
			int maxBuildTime
		) {
			base.Init(rendererTypes, maxBuildTime);

			Combiner = CreateMeshCombiner("Combiner", transform);
		}

		public override string GetKey(AbstractCombinable combinable) => String.Empty;

		public override void Include(AbstractCombinable combinable, string key) => Combiner.Include(combinable);

		public override void Exclude(AbstractCombinable combinable, string key) => Combiner.Exclude(combinable);

		public override void Clear() {
			if (Combiner) Combiner.Clear();
		}

		public override void PostBakeAction() {
			GetRenderers().ForEach(r => { r.transform.parent = transform; });
			DestroyImmediate(Combiner);
		}
	}
}