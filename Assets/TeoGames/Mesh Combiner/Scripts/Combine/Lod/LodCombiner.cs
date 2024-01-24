using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using TeoGames.Mesh_Combiner.Scripts.Combine.ChunkContainer;
using TeoGames.Mesh_Combiner.Scripts.Combine.Interfaces;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.Lod {
	[AddComponentMenu("")]
	public class LodCombiner : MonoBehaviour, IChunkContainer<LodCombinable, LodUpdateQueueItem>, IAsyncCombiner {
		public GridChunkContainer chunk;
		public float transitionThreshold = 0.05f;

		public UpdateQueue<LodCombinable, LodUpdateQueueItem> updateQueue =
			new UpdateQueue<LodCombinable, LodUpdateQueueItem>();

		public UpdateQueue<LodCombinable, LodUpdateQueueItem> UpdateQueue => updateQueue;

		protected readonly Dictionary<LodCombinable, LodUpdateQueueItem> Instances =
			new Dictionary<LodCombinable, LodUpdateQueueItem>();

		protected readonly Dictionary<string, List<ChunkLod>> ChunkLods =
			new Dictionary<string, List<ChunkLod>>();

		public Task UpdateTask =>
			Task.CompletedTask
				.WaitUntil(() => updateQueue.Ticks > 0)
				.ContinueWith(() => chunk.UpdateTask);

		public void Init() {
			chunk = gameObject.AddComponent<GridChunkContainer>();

			updateQueue = new UpdateQueue<LodCombinable, LodUpdateQueueItem>();
			updateQueue.Start(this);
		}

		public void Include(LodCombinable combinable) {
			updateQueue.Schedule(combinable);
		}

		public void Exclude(LodCombinable combinable) {
			if (Instances.TryGetValue(combinable, out var item)) {
				if (item.container) item.container.Exclude(combinable, item.lodKey);
				Instances.Remove(combinable);
				updateQueue.Remove(combinable);
			}
		}

		public LodUpdateQueueItem IncludeNew(LodCombinable combinable) {
			var key = chunk.GetKey(combinable);
			var lod = GetLOD(combinable, key);
			var lodKey = $"{key}-{lod.Uid}-{combinable.Level}";

			chunk.Include(combinable, lodKey);

			return Instances[combinable] = new LodUpdateQueueItem() {
				container = chunk, containerKey = key, lodKey = lodKey
			};
		}

		public LodUpdateQueueItem UpdateDynamic(LodCombinable combinable, LodUpdateQueueItem item) {
			if (item.container) {
				var newKey = chunk.GetKey(combinable);
				if (item.containerKey == newKey) return item;

				item.container.Exclude(combinable, item.lodKey);
			}

			item.containerKey = chunk.GetKey(combinable);
			item.container = chunk;
			var lod = GetLOD(combinable, item.containerKey);
			item.lodKey = $"{item.containerKey}-{lod.Uid}-{combinable.Level}";

			chunk.Include(combinable, item.lodKey);

			return Instances[combinable] = item;
		}

		protected List<ChunkLod> GetCellLods(string containerKey) {
			if (ChunkLods.TryGetValue(containerKey, out var lods)) return lods;

			return ChunkLods[containerKey] = new List<ChunkLod>();
		}

		protected ChunkLod GetLOD(LodCombinable combinable, string containerKey) {
			var lods = GetCellLods(containerKey);

			// Get current LOD
			foreach (var lod in lods) {
				if (lod.IsEqual(combinable, transitionThreshold)) return lod;
			}

			var newGroup = new ChunkLod(transform, combinable, chunk, containerKey);
			lods.Add(newGroup);

			return newGroup;
		}

		// TODO cleanup lod when there is no objects in it
		protected LODGroup RemoveFromLOD(LodCombinable combinable, LODGroup lod) {
			throw new NotImplementedException();
		}

		public Renderer[] GetRenderers() => chunk.GetRenderers();
	}
}