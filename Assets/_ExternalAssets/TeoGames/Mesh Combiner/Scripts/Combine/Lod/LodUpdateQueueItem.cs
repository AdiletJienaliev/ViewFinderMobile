using System;
using TeoGames.Mesh_Combiner.Scripts.Combine.ChunkContainer;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.Lod {
	[Serializable]
	public class LodUpdateQueueItem : UpdateQueueItem {
		public string lodKey;
	}
}