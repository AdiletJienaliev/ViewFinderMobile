using System.IO;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Extension {
	public static class RendererExtension {
		public static void Enable(this Renderer ren) {
			if (ren) ren.enabled = true;
		}

		public static void Disable(this Renderer ren) {
			if (ren) ren.enabled = false;
		}

		public static void DeleteMesh(this Renderer ren) {
			if (ren is SkinnedMeshRenderer smr) smr.sharedMesh.Delete();
			else ren.GetComponent<MeshFilter>().sharedMesh.Delete();
		}

		public static void SaveMesh(this Renderer ren, string path) {
			if (!Directory.Exists(path)) {
				Debug.Log($"Create directory {path}");
				Directory.CreateDirectory(path);
			}

			if (ren is SkinnedMeshRenderer smr) smr.sharedMesh.Save(path + ren.name, false);
			else ren.GetComponent<MeshFilter>().sharedMesh.Save(path + ren.name, false);
		}
	}
}