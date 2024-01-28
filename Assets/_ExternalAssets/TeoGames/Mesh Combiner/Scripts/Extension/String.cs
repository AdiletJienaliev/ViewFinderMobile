
namespace TeoGames.Mesh_Combiner.Scripts.Extension {
	public static class StringExtension {
		public static string RemoveLast(this string str, int cnt) => str.Remove(str.Length - cnt);
	}
}