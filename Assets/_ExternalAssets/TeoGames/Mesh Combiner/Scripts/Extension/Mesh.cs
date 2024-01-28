using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif

namespace TeoGames.Mesh_Combiner.Scripts.Extension {
#if UNITY_EDITOR
	[InitializeOnLoad]
#endif
	public static class MeshExtension {
		private static readonly Dictionary<Mesh, Mesh> ToStaticCache = new Dictionary<Mesh, Mesh>();
		private static readonly Dictionary<Mesh, Mesh> ToAnimatedCache = new Dictionary<Mesh, Mesh>();

#if UNITY_EDITOR
		static MeshExtension() => EditorApplication.playModeStateChanged += _ => ResetCache();

		[InitializeOnEnterPlayMode]
		public static void ResetCache() {
			ToStaticCache.Clear();
			ToAnimatedCache.Clear();
		}
#endif

		public static void Save(this Mesh mesh, string path, bool overrideFile) {
#if UNITY_EDITOR
			if (!overrideFile) {
				var i = 0;
				var fixedPath = path;
				while (File.Exists($"{fixedPath}.asset")) {
					fixedPath = $"{path} ({++i})";
				}

				path = fixedPath;
			}

			Debug.Log($"Save mesh {path}.asset");
			AssetDatabase.CreateAsset(mesh, $"{path}.asset");
			AssetDatabase.SaveAssets();
#endif
		}

		public static void Delete(this Mesh mesh) {
#if UNITY_EDITOR
			var path = AssetDatabase.GetAssetPath(mesh);
			if (string.IsNullOrEmpty(path)) return;

			Debug.Log($"Delete mesh {path}");
			var dir = Path.GetDirectoryName(path);

			AssetDatabase.DeleteAsset(path);

			while (dir != null && !Directory.EnumerateFileSystemEntries(dir).Any()) {
				Debug.Log($"Delete folder {dir}");
				AssetDatabase.DeleteAsset(dir);
				dir = Path.GetRelativePath(Path.GetFullPath("."), Directory.GetParent(dir)?.FullName);
			}

			AssetDatabase.SaveAssets();
#endif
		}

		public static Mesh ToAnimated(this Mesh mesh) {
			if (ToAnimatedCache.TryGetValue(mesh, out var existing)) return existing;

			return ToAnimatedCache[mesh] = mesh.bindposes.Length > 0 ? mesh : mesh.CopyMesh();
		}

		public static Mesh ToStatic(this Mesh mesh) {
			if (ToStaticCache.TryGetValue(mesh, out var existing)) return existing;

			// Parse if there is more than one bind poses
			return ToStaticCache[mesh] = mesh.bindposes.Length == 1 ? mesh : mesh.CopyMesh();
		}

		private static Mesh CopyMesh(this Mesh mesh) {
			var bones = Enumerable.Repeat((byte)1, mesh.vertexCount).ToNativeArray();
			var weight = new BoneWeight1 { boneIndex = 0, weight = 1 };
			var weights = Enumerable.Repeat(weight, mesh.vertexCount).ToNativeArray();

			var res = Object.Instantiate(mesh);
			res.bindposes = new[] { Matrix4x4.identity };
			res.SetBoneWeights(bones, weights);

			bones.Dispose();
			weights.Dispose();

			return res;
		}

		public static void MarkAsReadable(this Mesh mesh) {
#if UNITY_EDITOR
			if (!mesh || mesh.isReadable) return;

			var importer = (ModelImporter)AssetImporter.GetAtPath(AssetDatabase.GetAssetPath(mesh));
			importer.isReadable = true;
			EditorUtility.SetDirty(importer);
			importer.SaveAndReimport();
#endif
		}

		public static bool IsAnimated(this Mesh mesh) {
			return mesh.bindposes.Length > 0;
		}
	}
}