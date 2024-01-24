using System;
using System.Diagnostics;
using System.Threading.Tasks;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Profile {
	public class Timer {
		public long Diff => NanoTime() - _Start;
		public long DiffMs => (Diff + _Tracked) / 1000000;
		protected long DiffTimer => (Diff + _Tracked) / 100000;

		private float _MaxExecTime = 50;

		public float MaxExecTime {
			get => _MaxExecTime / 10;
			set => _MaxExecTime = value * 10;
		}

		private long _Tracked;
		private int _Frame;

		public bool AsyncMode;

		public bool IsTimeoutRequired => AsyncMode && DiffTimer > _MaxExecTime;

		private long _Start;

		public async Task Wait() {
			Stop();
			await Task.CompletedTask.WaitForUpdate();
			Start();
		}

		public void Start(float maxExecTime, bool asyncMode) {
			MaxExecTime = maxExecTime;
			AsyncMode = asyncMode;

			Start();
		}

		public void Start() {
			if (_Frame != Time.frameCount) {
				_Tracked = 0;
				_Frame = Time.frameCount;
			}

			_Start = NanoTime();
		}

		public void Stop() {
			_Frame = Time.frameCount;
			TrackTime();
		}

		protected void TrackTime() {
			var diff = Diff;

			ProfilerModule.BakeTime.Value += diff;
			_Tracked += diff;
			_Start += diff;
		}

		public static int MS() => (int)(NanoTime() / 1000000);

		private static long NanoTime() {
			var nano = 10000L * Stopwatch.GetTimestamp();
			nano /= TimeSpan.TicksPerMillisecond;
			nano *= 100L;
			return nano;
		}
	}
}