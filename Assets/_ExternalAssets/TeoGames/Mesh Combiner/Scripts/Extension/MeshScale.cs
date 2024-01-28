using System.Collections.Generic;
using System.Linq;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif

namespace TeoGames.Mesh_Combiner.Scripts.Extension {
    #if UNITY_EDITOR
		[InitializeOnLoad]
    #endif
		public static class MeshScaleExtension {
		private static readonly Dictionary<long, Mesh> Cache = new Dictionary<long, Mesh>();

#if UNITY_EDITOR
		static MeshScaleExtension() => EditorApplication.playModeStateChanged += _ => ResetCache();

		[InitializeOnEnterPlayMode]
		private static void ResetCache() {
			Cache.Clear();
		}
#endif

		private static void SetNormal(Dictionary<Vector3, List<Vector3>> data, Vector3 vertex, Vector3 normal) {
			if (data.TryGetValue(vertex, out var n1)) {
				if (!n1.Contains(normal)) n1.Add(normal);
				return;
			}
			
			data.Add(vertex, new List<Vector3>() { normal });
		}

		// Algorithm was provided by chat GPT
		public static Mesh Scale(this Mesh mesh, Vector3 scale, float factor) {
			if (factor == 0) return mesh;
			var hash = (long)mesh.GetInstanceID() + scale.GetHashCode();
			if (Cache.TryGetValue(hash, out var res)) return res;

			res = Object.Instantiate(mesh);
			res.name = $"{mesh.name} x{factor} {scale}";

			// Calculate the average normal for each vertex
			var vertices = res.vertices;
			var vertexNormals = new Dictionary<Vector3, List<Vector3>>();
			var triangleIndices = res.triangles;
			for (var i = 0; i < triangleIndices.Length; i += 3) {
				var v1 = vertices[triangleIndices[i]];
				var v2 = vertices[triangleIndices[i + 1]];
				var v3 = vertices[triangleIndices[i + 2]];

				var normal = Vector3.Cross(v2 - v1, v3 - v1).normalized;

				SetNormal(vertexNormals, v1, normal);
				SetNormal(vertexNormals, v2, normal);
				SetNormal(vertexNormals, v3, normal);
			}

			var finalNormals = new Dictionary<Vector3, Vector3>();
			foreach (var pair in vertexNormals) {
				var normals = pair.Value.Aggregate(Vector3Extensions.Zero, (r, n) => r + n).normalized;

				finalNormals.Add(pair.Key, (normals * factor).Divide(scale));
			}

			// Move each vertex along its average normal
			for (var i = 0; i < vertices.Length; i++) {
				if (finalNormals.TryGetValue(vertices[i], out var normal)) {
					vertices[i] += normal;
				}
			}

			res.vertices = vertices;

			// Recalculate the normals and bounds of the mesh
			res.RecalculateNormals();
			res.RecalculateBounds();

			Cache[hash] = res;

			return res;
		}
		}
}