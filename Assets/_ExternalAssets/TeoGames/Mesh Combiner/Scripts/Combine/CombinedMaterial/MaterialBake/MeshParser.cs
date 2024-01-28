using System.Collections.Generic;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.CombinedMaterial.MaterialBake {
	public class MeshParser {
		private readonly float _Scale;
		private readonly Vector2 _Offset;

		protected readonly Dictionary<Mesh, Mesh> BakeCache = new Dictionary<Mesh, Mesh>();

		public MeshParser(float scale, Vector2 offset) {
			_Scale = scale;
			_Offset = offset;
		}

		protected void FixUV(Mesh mesh) {
			FixUVChannel(mesh, mesh.uv, 0);
			// FixUVChannel(mesh, mesh.uv2, 1);
			// FixUVChannel(mesh, mesh.uv3, 2);
		}

		protected void FixUVChannel(Mesh mesh, Vector2[] uv, int channel) {
			var length = uv.Length;
			if (length == 0) return;

			for (var i = 0; i < length; i++) {
				uv[i] = uv[i] * _Scale + _Offset;
			}
			
			mesh.SetUVs(channel, uv);
		}

		public Mesh GetParsedMesh(Mesh mesh) {
			if (!BakeCache.TryGetValue(mesh, out var newMesh)) {
				newMesh = Object.Instantiate(mesh);
				FixUV(newMesh);

				BakeCache.Add(mesh, newMesh);
			}

			return newMesh;
		}
	}
}