using System;
using TeoGames.Mesh_Combiner.Scripts.Combine.ChunkContainer;
using UnityEngine;
using Object = UnityEngine.Object;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.Lod {
	[Serializable]
	public class LodConfiguration {
		[Tooltip("Max size of the LODs")] public int chunkSize = 25;

		[Tooltip("LODs will be merged if their transition difference will be less than provided value")]
		public float transitionThreshold = 0.05f;

		private LodCombiner _Combiner;

		public LodCombiner Combiner => _Combiner;

		public void Init(AbstractMeshCombiner original) {
			if (_Combiner) return;

			_Combiner = original.gameObject.AddComponent<LodCombiner>();
			_Combiner.Init();
			_Combiner.transitionThreshold = transitionThreshold;
			_Combiner.chunk.size = chunkSize;
			_Combiner.chunk.Init(
				rendererTypes: original.rendererTypes,
				maxBuildTime: original.maxBuildTime
			);

			if (original is IChunkContainer<AbstractCombinable, UpdateQueueItem> chunkContainer) {
				_Combiner.updateQueue.updateDistance = chunkContainer.UpdateQueue.updateDistance;
				_Combiner.updateQueue.maxInitTimePerFrame = chunkContainer.UpdateQueue.maxInitTimePerFrame;
				_Combiner.updateQueue.maxUpdateTimePerFrame = chunkContainer.UpdateQueue.maxUpdateTimePerFrame;
				_Combiner.updateQueue.forceUpdateAfter = chunkContainer.UpdateQueue.forceUpdateAfter;
			}
		}

		public void Clear() {
			if (!_Combiner) return;

			_Combiner.updateQueue.Stop();
			_Combiner.chunk.PostBakeAction();

			Object.DestroyImmediate(_Combiner.chunk);
			Object.DestroyImmediate(_Combiner);
		}
	}
}