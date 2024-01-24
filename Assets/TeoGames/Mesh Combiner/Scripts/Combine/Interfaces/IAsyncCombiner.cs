using System.Threading.Tasks;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.Interfaces {
	public interface IAsyncCombiner {
		public Task UpdateTask { get; }
	}
}