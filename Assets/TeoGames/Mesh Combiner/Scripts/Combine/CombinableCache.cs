using System;
using System.Linq;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Combine {
	public enum MeshCorrection {
		None,
		Stat,
		Anim,
	}

	[Serializable]
	public class CombinableCache {
		[SerializeField] public Transform transform;

		[SerializeField] public Material[] materials;
		[SerializeField] public Renderer renderer;
		[SerializeField] public Mesh mesh;
		[NonSerialized] public Transform[] Bones;

		[SerializeField] public bool isSkinnedMesh;
		[SerializeField] public MeshRenderer meshRenderer;
		[SerializeField] public MeshFilter meshFilter;
		[SerializeField] public SkinnedMeshRenderer skinnedMeshRenderer;

		[SerializeField] public bool isCached = false;
		[SerializeField] public MeshCorrection isCorrectionRequired = MeshCorrection.None;
		[NonSerialized] public bool IsOptimized = false;

		public bool IsDifferent(CombinableCache other) =>
			isSkinnedMesh != other.isSkinnedMesh ||
			renderer != other.renderer ||
			mesh != other.mesh ||
			!materials.SequenceEqual(other.materials);
	}
}