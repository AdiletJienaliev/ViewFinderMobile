using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using TeoGames.Mesh_Combiner.Scripts.Combine.Interfaces;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.ChunkContainer {
	[AddComponentMenu("Mesh Combiner/Chunk/MC Grid Chunk Container")]
	public class GridChunkContainer : AbstractChunkContainer {
		[Tooltip("Automatic chunk size in units")] [Min(1)] [SerializeField]
		public int size = 50;

		[Tooltip("Element where chunks combinables will be created, uses itself by default")] [SerializeField]
		public Transform container;

		protected Transform Container => container ? container : transform;

		private readonly Dictionary<string, MeshCombiner> _Cells = new Dictionary<string, MeshCombiner>();

		public override float Distance(Vector3 position) => 0;

		public override float Compability(AbstractCombinable obj) => 1f;

		public override void Clear() {
			_Cells.ForEach(cell => cell.Value.Clear());
			_Cells.Clear();
		}

		public override Renderer[] GetRenderers() =>
			_Cells
				.SelectMany(c => c.Value.GetRenderers())
				.ToArray();

		public MeshCombiner GetCell(string key) {
			if (!_Cells.TryGetValue(key, out var cell)) {
				_Cells[key] = cell = CreateMeshCombiner(key, Container);
			}

			return cell;
		}

		public override void Include(AbstractCombinable combinable, string key) {
			GetCell(key).Include(combinable);
		}

		public override void Exclude(AbstractCombinable combinable, string key) {
			if (_Cells.TryGetValue(key, out var cell)) cell.Exclude(combinable);
		}

		public override void PostBakeAction() {
			_Cells.ForEach(
				cell => {
					DestroyImmediate(cell.Value);
				}
			);

			_Cells.Clear();
		}

		public override Task UpdateTask =>
			Task.WhenAll(_Cells.Select(c => c.Value is IAsyncCombiner async ? async.UpdateTask : null));

		public override string GetKey(AbstractCombinable combinable) {
			return (GetPosition(combinable).ToVector2() / size).Round().ToString();
		}
	}
}