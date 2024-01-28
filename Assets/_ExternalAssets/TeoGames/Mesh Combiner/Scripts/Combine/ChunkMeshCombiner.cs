using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using TeoGames.Mesh_Combiner.Scripts.Combine.ChunkContainer;
using TeoGames.Mesh_Combiner.Scripts.Combine.Interfaces;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Combine {
	[AddComponentMenu("Mesh Combiner/MC Chunk Combiner")]
	public class ChunkMeshCombiner : AbstractMeshCombiner, IAsyncCombiner, IPostBakeAction, IChunkContainer<AbstractCombinable, UpdateQueueItem> {
		public AbstractChunkContainer[] chunks;

		protected readonly Dictionary<AbstractCombinable, UpdateQueueItem> Instances =
			new Dictionary<AbstractCombinable, UpdateQueueItem>();

		[SerializeField] public UpdateQueue<AbstractCombinable, UpdateQueueItem> updateQueue =
			new UpdateQueue<AbstractCombinable, UpdateQueueItem>();

		public UpdateQueue<AbstractCombinable, UpdateQueueItem> UpdateQueue => updateQueue;

		public Task UpdateTask =>
			Task.CompletedTask
				.WaitUntil(() => updateQueue.Ticks > 0)
				.ContinueWith(
					() => Task.WhenAll(chunks.Select(c => c is IAsyncCombiner async ? async.UpdateTask : null))
				);

		private void Reset() {
			if (chunks != null && chunks.Any()) return;

			chunks = GetComponents<AbstractChunkContainer>();
			if (chunks.Any()) return;

			chunks = new AbstractChunkContainer[] { gameObject.AddComponent<GridChunkContainer>(), };
		}

		private void Awake() => Init();

		public override void Init() {
			if (!chunks.Any()) {
				Debug.LogError(
					"MC Chunk Combiner doesnt have any chunks configured. Please add some or reset component to add default chunk",
					this
				);
				return;
			}

			chunks.ForEach(
				chunk => chunk.Init(
					rendererTypes: rendererTypes,
					maxBuildTime: maxBuildTime
				)
			);

			updateQueue.Start(this);
			Lod.Init(this);
		}

		public override void Clear() {
			chunks.ForEach(chunk => chunk.Clear());
			updateQueue.Clear();
			Instances.Clear();

			if (IsLodReady) Lod.Clear();
		}

		private void OnDestroy() {
			updateQueue.Stop();
		}

		public override Renderer[] GetRenderers() =>
			chunks
				.SelectMany(c => c.GetRenderers())
				.Concat(IsLodReady ? Lod.Combiner.GetRenderers() : Array.Empty<Renderer>())
				.ToArray();

		public UpdateQueueItem IncludeNew(AbstractCombinable combinable) {
			var cell = FindNewCell(combinable);
			var key = string.Empty;

			if (cell) {
				key = cell.GetKey(combinable);
				cell.Include(combinable, key);
			}

			return Instances[combinable] = new UpdateQueueItem { container = cell, containerKey = key };
		}

		public UpdateQueueItem UpdateDynamic(AbstractCombinable combinable, UpdateQueueItem item) {
			var cell = item.container;
			if (cell) {
				if (Math.Abs(cell.Compability(combinable) - 1) < .01f) {
					item.UpdateKey(combinable);
					return null;
				}

				var newCell = FindNewCell(combinable);
				if (newCell == cell) return null;

				cell.Exclude(combinable, item.containerKey);
				cell = newCell;
			} else {
				cell = FindNewCell(combinable);
			}

			if (cell) {
				item.container = cell;
				item.containerKey = cell.GetKey(combinable);
				cell.Include(combinable, item.containerKey);
			}

			return Instances[combinable] = item;
		}

		public override void Include(AbstractCombinable combinable) => updateQueue.Schedule(combinable);

		private AbstractChunkContainer FindNewCell(AbstractCombinable combinable) {
			var bestMatchCompability = float.NegativeInfinity;
			AbstractChunkContainer bestMatch = null;

			foreach (var chunk in chunks) {
				var compability = chunk.Compability(combinable);
				switch (compability) {
					case 1: return chunk;
					case 0: continue;
					default:
						if (bestMatchCompability > compability) continue;

						bestMatchCompability = compability;
						bestMatch = chunk;

						break;
				}
			}

			return bestMatch;
		}

		public override void Exclude(AbstractCombinable combinable) {
			if (Instances.TryGetValue(combinable, out var item)) {
				if (item.container) item.container.Exclude(combinable, item.containerKey);
				Instances.Remove(combinable);
				updateQueue.Remove(combinable);
			}
		}

		public void PostBakeAction() {
			updateQueue.Clear();
			if (IsLodReady) Lod.Clear();

			chunks.ForEach(
				c => {
					if (c is IPostBakeAction pb) pb.PostBakeAction();
				}
			);
		}
	}
}