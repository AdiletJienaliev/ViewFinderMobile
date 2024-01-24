using System;

namespace TeoGames.Mesh_Combiner.Scripts.Extension {
	public static class DateTimeExtension {
		public static long GetMS(this DateTime date) => date.Ticks / TimeSpan.TicksPerMillisecond;
		public static long GetDif(this DateTime date, long oldMs) => date.GetMS() - oldMs;
	}
}