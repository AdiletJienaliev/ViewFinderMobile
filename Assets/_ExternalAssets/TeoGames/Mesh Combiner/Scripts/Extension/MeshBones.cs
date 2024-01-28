using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using TeoGames.Mesh_Combiner.Scripts.Profile;
using Unity.Collections;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;
#endif

namespace TeoGames.Mesh_Combiner.Scripts.Extension {
#if UNITY_EDITOR
	[InitializeOnLoad]
#endif
	public static class MeshBonesExtension {
		private static readonly Dictionary<Transform, (int index, Matrix4x4 pose)> Bones =
			new Dictionary<Transform, (int index, Matrix4x4 pose)>();

		private static readonly Dictionary<int, int> MapIndexes = new Dictionary<int, int>();

		private static readonly Dictionary<Mesh, (Mesh mesh, int[] bones)> OptimizedMeshes =
			new Dictionary<Mesh, (Mesh, int[])>();

#if UNITY_EDITOR
		static MeshBonesExtension() => EditorApplication.playModeStateChanged += _ => ResetCache();

		[InitializeOnEnterPlayMode]
		private static void ResetCache() {
			Bones.Clear();
			MapIndexes.Clear();
			OptimizedMeshes.Clear();
		}
#endif

		public static (Mesh, Transform[]) Optimize(this Mesh mesh, Transform[] bones) {
			if (OptimizedMeshes.TryGetValue(mesh, out var res) && res.mesh) {
				return (res.mesh, bones.FilterKeys(res.bones));
			}

			var newMesh = Object.Instantiate(mesh);
			newMesh.name = $"[O] {mesh.name}";

			var (newBones, keys) = newMesh.RemoveUnusedBones(bones);

			res = (newMesh, keys);
			OptimizedMeshes[mesh] = res;

			return (res.mesh, newBones);
		}

		public static void ResetBindPoses(this Mesh mesh) {
			// Get the original bind poses of the mesh
			var bindPoses = mesh.bindposes;

			// Get the vertices and bone weights of the mesh
			var vertices = mesh.vertices;
			var normals = mesh.normals;
			var boneWeights = mesh.boneWeights;
			var vm = new Matrix4x4();

			// Iterate through the vertices
			for (var i = 0; i < vertices.Length; i++) {
				var weight = boneWeights[i];
				var bm0 = bindPoses[weight.boneIndex0];
				var bm1 = bindPoses[weight.boneIndex1];
				var bm2 = bindPoses[weight.boneIndex2];
				var bm3 = bindPoses[weight.boneIndex3];

				var w0 = weight.weight0;
				var w1 = weight.weight1;
				var w2 = weight.weight2;
				var w3 = weight.weight3;

				// Calculate the transformed vertex position using the bone weights and bind poses
				vm.m00 = bm0.m00 * w0 + bm1.m00 * w1 + bm2.m00 * w2 + bm3.m00 * w3;
				vm.m01 = bm0.m01 * w0 + bm1.m01 * w1 + bm2.m01 * w2 + bm3.m01 * w3;
				vm.m02 = bm0.m02 * w0 + bm1.m02 * w1 + bm2.m02 * w2 + bm3.m02 * w3;
				vm.m03 = bm0.m03 * w0 + bm1.m03 * w1 + bm2.m03 * w2 + bm3.m03 * w3;

				vm.m10 = bm0.m10 * w0 + bm1.m10 * w1 + bm2.m10 * w2 + bm3.m10 * w3;
				vm.m11 = bm0.m11 * w0 + bm1.m11 * w1 + bm2.m11 * w2 + bm3.m11 * w3;
				vm.m12 = bm0.m12 * w0 + bm1.m12 * w1 + bm2.m12 * w2 + bm3.m12 * w3;
				vm.m13 = bm0.m13 * w0 + bm1.m13 * w1 + bm2.m13 * w2 + bm3.m13 * w3;

				vm.m20 = bm0.m20 * w0 + bm1.m20 * w1 + bm2.m20 * w2 + bm3.m20 * w3;
				vm.m21 = bm0.m21 * w0 + bm1.m21 * w1 + bm2.m21 * w2 + bm3.m21 * w3;
				vm.m22 = bm0.m22 * w0 + bm1.m22 * w1 + bm2.m22 * w2 + bm3.m22 * w3;
				vm.m23 = bm0.m23 * w0 + bm1.m23 * w1 + bm2.m23 * w2 + bm3.m23 * w3;

				vertices[i] = vm.MultiplyPoint3x4(vertices[i]);
				normals[i] = vm.MultiplyVector(normals[i]).normalized;
			}

			// Update the mesh with the modified vertices
			mesh.vertices = vertices;
			mesh.normals = normals;
			mesh.RecalculateBounds();
			mesh.Optimize();
			mesh.RecalculateNormals();
			mesh.RecalculateTangents();
			mesh.bindposes = Enumerable.Repeat(Matrix4x4.identity, mesh.bindposes.Length).ToArray();
		}

		private static (Transform[], int[]) RemoveUnusedBones(this Mesh mesh, Transform[] bones) {
			var origBindPoses = mesh.bindposes;
			var bonesLength = bones.Length;
			if (origBindPoses.Length == 0 || bonesLength == 0) return (bones, Enumerable.Range(0, bones.Length).ToArray());

			var weights = mesh.boneWeights;
			var weightsCount = weights.Length;
			var counts = Enumerable.Repeat(0, bonesLength).ToArray();
			for (var i = 0; i < weightsCount; i++) {
				var weight = weights[i];
				if (weight.weight0 >= 0) counts[weight.boneIndex0]++;
				if (weight.weight1 >= 0) counts[weight.boneIndex1]++;
				if (weight.weight2 >= 0) counts[weight.boneIndex2]++;
				if (weight.weight3 >= 0) counts[weight.boneIndex3]++;
			}

			var newBones = new List<Transform>();
			MapIndexes.Clear();
			Bones.Clear();
			var id = 0;
			var bindposes = new List<Matrix4x4>();

			for (var i = 0; i < counts.Length; i++) {
				if (counts[i] == 0) continue;

				MapIndexes[i] = id++;
				newBones.Add(bones[i]);
				bindposes.Add(origBindPoses[i]);
			}

			for (var i = 0; i < weightsCount; i++) {
				var orig = weights[i];

				if (orig.weight0 > 0 && MapIndexes.TryGetValue(orig.boneIndex0, out var index)) orig.boneIndex0 = index;
				if (orig.weight1 > 0 && MapIndexes.TryGetValue(orig.boneIndex1, out index)) orig.boneIndex1 = index;
				if (orig.weight2 > 0 && MapIndexes.TryGetValue(orig.boneIndex2, out index)) orig.boneIndex2 = index;
				if (orig.weight3 > 0 && MapIndexes.TryGetValue(orig.boneIndex3, out index)) orig.boneIndex3 = index;

				weights[i] = orig;
			}

			mesh.bindposes = bindposes.ToArray();
			mesh.boneWeights = weights;

			return (newBones.ToArray(), MapIndexes.Keys.ToArray());
		}

		public static async Task<Transform[]> MergeBones(this Mesh mesh, Transform[] allBones, int maxExecTime) {
			Bones.Clear();
			MapIndexes.Clear();
			var allBonesCount = allBones.Length;
			var origBindPoses = mesh.bindposes;
			var id = 0;
			var changedAt = int.MaxValue;

			await Task.CompletedTask;

			for (var i = 0; i < allBonesCount; i++) {
				var bone = allBones[i];

				if (Bones.TryGetValue(bone, out var pair)) {
					if (i != pair.index) {
						if (changedAt > i) changedAt = i;
						MapIndexes.Add(i, pair.index);
					}
				} else {
					if (i != id) MapIndexes.Add(i, id);
					Bones.Add(bone, (id, origBindPoses[i]));
					id++;
				}
			}

			if (Bones.Count == allBonesCount) return allBones;

			var timer = new Timer {
				MaxExecTime = maxExecTime,
				AsyncMode = maxExecTime <= 0
			};

			timer.Start();
			var weights = new NativeArray<BoneWeight1>(mesh.GetAllBoneWeights(), Allocator.TempJob);
			var weightsCount = weights.Length;

			if (timer.IsTimeoutRequired) await timer.Wait();

			for (var c = 0; c < weightsCount; c += 10000) {
				var stop = Mathf.Min(c + 10000, weightsCount);

				for (var i = c; i < stop; i++) {
					var orig = weights[i];
					var boneIndex = orig.boneIndex;
					if (changedAt > boneIndex) continue;

					orig.boneIndex = MapIndexes[boneIndex];
					weights[i] = orig;
				}

				if (timer.IsTimeoutRequired) await timer.Wait();
			}

			var poses = new Matrix4x4[id];
			var j = 0;
			foreach (var (_, pose) in Bones.Values) poses[j++] = pose;

			mesh.bindposes = poses;
			mesh.SetBoneWeights(mesh.GetBonesPerVertex(), weights);
			weights.Dispose();

			return Bones.Keys.ToArray();
		}
	}
}