using System;
using System.Linq;
using TeoGames.Mesh_Combiner.Scripts.Combine.ChunkContainer;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.Lod {
	public class ChunkLod {
		public int Uid { get; private set; }

		private readonly float[] _Heights;
		private readonly float[] _Widths;
		private readonly float _Size;
		private readonly LOD[] _Lods;
		private readonly LODGroup _Group;
		private readonly GameObject _Obj;

		public ChunkLod(Transform parent, LodCombinable combinable, GridChunkContainer chunk, string containerKey) {
			_Obj = new GameObject($"LOD {containerKey}");
			var trans = _Obj.transform;
			trans.parent = parent;
			trans.localPosition = Vector3Extensions.Zero;

			_Group = _Obj.AddComponent<LODGroup>();

			_Group.fadeMode = combinable.Group.fadeMode;
			_Group.animateCrossFading = combinable.Group.animateCrossFading;
			Uid = _Obj.GetInstanceID();
			_Lods = new LOD[combinable.Group.lodCount];
			_Heights = combinable.Lods.Select(l => l.screenRelativeTransitionHeight).MinMax();
			_Widths = combinable.Lods.Select(l => l.fadeTransitionWidth).MinMax();
			_Size = combinable.Group.size;

			for (var i = 0; i < combinable.Lods.Length; i++) {
				var level = i;
				var cur = combinable.Lods[level];
				var newLod = new LOD {
					fadeTransitionWidth = cur.fadeTransitionWidth,
					screenRelativeTransitionHeight = _Heights[i],
					renderers = null
				};
				_Lods[level] = newLod;

				chunk.container = trans;
				var combiner = chunk.GetCell($"{containerKey}-{Uid}-{level}");
				combiner.OnRenderersUpdated += renderers => { UpdateLod(level, renderers); };
			}
		}

		private void UpdateLod(int level, Renderer[] renderers) {
			// Initial setup
			var lod = _Lods[level];
			lod.renderers = renderers;
			_Lods[level] = lod;
			_Group.SetLODs(_Lods);
			_Group.RecalculateBounds();

			UpdateSize();
		}

		private void UpdateSize() {
			try {
				var dif = _Group.size / _Size;
				var max = _Heights.Max() * dif;
				if (max > 1) dif /= max;

				_Lods.ForEach(
					(l, i) => {
						l.screenRelativeTransitionHeight = (i == _Group.lodCount - 1 && dif > 1)
							? _Heights[i] / dif
							: _Heights[i] * dif;
						_Lods[i] = l;
					}
				);

				_Group.SetLODs(_Lods);
			} catch (Exception ex) {
				Debug.LogException(ex);

				if (_Obj) throw;
			}
		}

		public bool IsEqual(LodCombinable b, float threshold = 0.05f) {
			if (_Group.lodCount != b.Group.lodCount) return false;
			if (_Group.fadeMode != b.Group.fadeMode) return false;
			if (_Group.animateCrossFading != b.Group.animateCrossFading) return false;

			for (var i = 0; i < _Group.lodCount; i++) {
				var bLod = b.Lods[i];

				var screenDiff = Mathf.Abs(_Heights[i] - bLod.screenRelativeTransitionHeight);
				if (screenDiff > threshold) return false;

				var fadeDiff = Mathf.Abs(_Widths[i] - bLod.fadeTransitionWidth);
				if (fadeDiff > threshold) return false;
			}

			return true;
		}
	}
}