using System;
using System.Collections.Generic;
using System.Linq;

namespace TeoGames.Mesh_Combiner.Scripts.Extension {
	public static class LinqExtensions {
		public static T First<T>(this IEnumerable<T> source, Func<T, bool> predicate, Func<T> def) {
			try {
				return source.First(predicate);
			} catch (Exception) {
				return def();
			}
		}
		
		public static T First<T>(this IEnumerable<T> source, Func<T> def) {
			try {
				return source.First();
			} catch (Exception) {
				return def();
			}
		}
		
		public static T[][] Chunk<T>(this IEnumerable<T> source, int size)
		{
			return  source
				.Select((x, i) => new { Index = i, Value = x })
				.GroupBy(x => x.Index / size)
				.Select(x => x.Select(v => v.Value).ToArray())
				.ToArray();
		}
	}
}