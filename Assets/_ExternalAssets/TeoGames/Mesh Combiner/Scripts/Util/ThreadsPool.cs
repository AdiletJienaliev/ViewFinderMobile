using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using TeoGames.Mesh_Combiner.Scripts.Extension;

namespace TeoGames.Mesh_Combiner.Scripts.Util {
	public class ThreadsPool {
		private readonly List<Func<Task>> _Queue = new List<Func<Task>>();

		public bool HasTasks => _Queue.Count > 0;

		public async Task<bool> Schedule(Func<Task> action) {
			var promise = new TaskCompletionSource<bool>();
			var hadTasks = HasTasks;

			_Queue.Add(
				async () => {
					await action();
					promise.SetResult(true);
				}
			);

			if (!hadTasks) {
				await Task.Yield();
				RunNext().Forget();
			}

			return await promise.Task;
		}

		private async Task RunNext() {
			while (true) {
				var next = _Queue.FirstOrDefault();
				_Queue.RemoveAt(0);
				if (next == null) return;

				await next();
			}
		}
	}
}