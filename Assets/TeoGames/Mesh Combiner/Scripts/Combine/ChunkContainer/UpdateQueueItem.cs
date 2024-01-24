using System;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.ChunkContainer {
	[Serializable]
	public class UpdateQueueItem {
		public int ticks;
		public Vector3 position;
		public Transform transform;
		public AbstractChunkContainer container;
		public string containerKey;

		public void UpdateKey(AbstractCombinable combinable) {
			var currentKey = container.GetKey(combinable);
			if (containerKey != currentKey) {
				container.Exclude(combinable, containerKey);
				container.Include(combinable, currentKey);
				containerKey = currentKey;
			}
		}
	}
}