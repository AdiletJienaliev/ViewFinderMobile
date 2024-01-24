using System.Collections.Generic;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif

namespace TeoGames.Mesh_Combiner.Scripts.Extension {
    #if UNITY_EDITOR
		[InitializeOnLoad]
    #endif
		public static class MeshMirrorExtension {
		private static readonly Dictionary<long, Mesh> Cache = new Dictionary<long, Mesh>();

#if UNITY_EDITOR
		static MeshMirrorExtension() => EditorApplication.playModeStateChanged += _ => ResetCache();

		[InitializeOnEnterPlayMode]
		private static void ResetCache() {
			Cache.Clear();
		}
#endif

		// Algorithm was provided by chat GPT
		public static Mesh Mirror(this Mesh mesh, Vector3 axis) {
			var scale = new Vector3(axis.x != 0 ? -1 : 1, axis.y != 0 ? -1 : 1, axis.z != 0 ? -1 : 1);
			var scaleHash = (int)(scale.x + scale.y * 10 + scale.z * 100);
			var hash = (long)mesh.GetInstanceID() + scaleHash;
			if (Cache.TryGetValue(hash, out var res)) return res;

			res = Object.Instantiate(mesh);
			res.name = $"{mesh.name} {scale}";

			// Iterate over each vertex and mirror its coordinates along the specified axis
			var vertices = res.vertices;
			for (var i = 0; i < vertices.Length; i++) {
				vertices[i] = Vector3.Scale(vertices[i], scale);
			}

			// Flip triangles only if we are mirroring 1 or 3 angles
			if (scale.x + scale.y + scale.z != -1) {
				var subMeshCount = res.subMeshCount;
				for (var i = 0; i < subMeshCount; i++) {
					var triangles = res.GetTriangles(i);
					for (var j = 0; j < triangles.Length; j += 3) {
						(triangles[j], triangles[j + 2]) = (triangles[j + 2], triangles[j]);
					}

					res.SetTriangles(triangles, i);
				}
			}

			// Update the mesh with the mirrored vertices and reversed triangles
			res.SetVertices(vertices);

			// Recalculate the normals and bounds of the mesh
			res.RecalculateNormals();
			res.RecalculateBounds();

			Cache[hash] = res;

			return res;
		}
		}
}