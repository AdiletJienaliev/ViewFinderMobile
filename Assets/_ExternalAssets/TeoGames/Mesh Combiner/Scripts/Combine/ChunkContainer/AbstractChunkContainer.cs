using System.Threading.Tasks;
using TeoGames.Mesh_Combiner.Scripts.Combine.Interfaces;
using TeoGames.Mesh_Combiner.Scripts.Combine.MeshRendererManager;
using TeoGames.Mesh_Combiner.Scripts.Profile;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.ChunkContainer {
	public abstract class AbstractChunkContainer : MonoBehaviour, IAsyncCombiner, IPostBakeAction {

		public int MaxBuildTime { get; protected set; }

		public TargetRendererType RendererTypes { get; protected set; }

		public abstract float Compability(AbstractCombinable obj);
		public abstract float Distance(Vector3 position);
		public abstract void Clear();

		public abstract Renderer[] GetRenderers();

		public abstract string GetKey(AbstractCombinable combinable);

		public abstract void Include(AbstractCombinable combinable, string key);

		public abstract void Exclude(AbstractCombinable combinable, string key);

		public abstract void PostBakeAction();

		public abstract Task UpdateTask { get; }

		public virtual void Init(
			TargetRendererType rendererTypes,
			int maxBuildTime
		) {
			RendererTypes = rendererTypes;
			MaxBuildTime = maxBuildTime;
		}

		private static readonly McProfiler _CREATE = new McProfiler("AbstractChunkContainer > CreateMeshCombiner");

		protected MeshCombiner CreateMeshCombiner(string combinerName, Transform parent = null) {
			using (_CREATE.Auto()) {
				var obj = (parent ? parent : transform).gameObject;
				obj.name = $"__SKIP__{obj.name}";
				var combiner = obj.AddComponent<MeshCombiner>();
				combiner.keys = new[] { $"Chunk {combinerName}" };
				combiner.asyncMode = true;
				combiner.rendererTypes = RendererTypes;
				combiner.maxBuildTime = MaxBuildTime;
				combiner.Init();
				obj.name = obj.name.Substring(8);

				return combiner;
			}
		}

		protected Vector3 GetPosition(AbstractCombinable combinable) {
			return combinable.GetCache().renderer.bounds.center;
		}
	}
}