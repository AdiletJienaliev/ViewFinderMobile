#if MC_DEBUG
using Unity.Profiling;

#else
using System;
using Unity.Profiling;

#endif

namespace TeoGames.Mesh_Combiner.Scripts.Profile {
#if MC_DEBUG
	public class McProfiler {
		private ProfilerMarker _Marker;

		public McProfiler(string name) {
			_Marker = new ProfilerMarker(ProfilerModule.Category, name);
		}

		public void Begin() => _Marker.Begin();

		public void End() => _Marker.End();

		public ProfilerMarker.AutoScope Auto() => _Marker.Auto();
	}
#else
	public struct McProfilerAuto : IDisposable {
		public void Dispose() { }
	}

	public class McProfiler {
		public McProfiler(string name) { }

		public void Begin() { }

		public void End() { }

		public McProfilerAuto Auto() => new McProfilerAuto();
	}
#endif
}