namespace TeoGames.Mesh_Combiner.Scripts.Combine.ChunkContainer {
	public interface IChunkContainer<T, I> where T : AbstractCombinable where I : UpdateQueueItem {
		public UpdateQueue<T, I> UpdateQueue { get;  }

		public I IncludeNew(T combinable);
		public I UpdateDynamic(T combinable, I item);
	}
}