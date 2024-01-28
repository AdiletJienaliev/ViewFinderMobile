#if UNITY_EDITOR
using UnityEditor;
#endif

namespace TeoGames.Mesh_Combiner.Scripts.Profile {
#if MC_DEBUG
	using Unity.Profiling;

#else
	using System;

	public class ProfilerCategory {
		public ProfilerCategory(string name) { }
	}

	public class ProfilerCounterValue<T> {
		public T Value;

		public ProfilerCounterValue(ProfilerCategory category, string name, ProfilerMarkerDataUnit unit,
			ProfilerCounterOptions options = default) { }
	}

	public enum ProfilerMarkerDataUnit {
		Count,
		TimeNanoseconds
	}

	[Flags]
	public enum ProfilerCounterOptions {
		FlushOnEndOfFrame,
		ResetToZeroOnFlush
	}

#endif

	public static class ProfilerModule {
		public static readonly ProfilerCategory Category = new ProfilerCategory("Mesh Combiner");

		public static readonly ProfilerCounterValue<long> TotalBones = new ProfilerCounterValue<long>(
			Category, "Total Bones", ProfilerMarkerDataUnit.Count
		);

		public static readonly ProfilerCounterValue<long> TotalMaterials = new ProfilerCounterValue<long>(
			Category, "Total Materials", ProfilerMarkerDataUnit.Count
		);

		public static readonly ProfilerCounterValue<long> MeshRenderers = new ProfilerCounterValue<long>(
			Category, "Mesh Renderers", ProfilerMarkerDataUnit.Count
		);

		public static readonly ProfilerCounterValue<int> Meshes = new ProfilerCounterValue<int>(
			Category, "Baked Meshes", ProfilerMarkerDataUnit.Count
		);

		public static readonly ProfilerCounterValue<int> Vertices = new ProfilerCounterValue<int>(
			Category, "Baked Vertices", ProfilerMarkerDataUnit.Count
		);

		public static readonly ProfilerCounterValue<long> BakeTime = new ProfilerCounterValue<long>(
			Category,
			"Mesh Bake Time",
			ProfilerMarkerDataUnit.TimeNanoseconds,
			ProfilerCounterOptions.FlushOnEndOfFrame | ProfilerCounterOptions.ResetToZeroOnFlush
		);

#if UNITY_EDITOR
		[InitializeOnEnterPlayMode, InitializeOnLoadMethod]
		private static void OnEnterPlaymodeInEditor() {
			Meshes.Value = 0;
			Vertices.Value = 0;
			TotalBones.Value = 0;
			TotalMaterials.Value = 0;
			MeshRenderers.Value = 0;
			BakeTime.Value = 0;
		}
#endif
	}
}