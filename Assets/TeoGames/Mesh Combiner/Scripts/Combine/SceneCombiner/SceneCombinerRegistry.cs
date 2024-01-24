using System;
using System.Collections.Generic;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Combine.SceneCombiner {
	[AddComponentMenu("Mesh Combiner/MC Scene Combiner Registry")]
	public class SceneCombinerRegistry : MonoBehaviour {
		[Tooltip("Add combiners that you want to make global for entire scene")]
		public AbstractMeshCombiner[] combiners;

		private static SceneCombinerRegistry INSTANCE;
		private static SceneCombinerState STATE;
		private static readonly AbstractMeshCombiner[] _EMPTY = Array.Empty<AbstractMeshCombiner>();

		public void Awake() {
			if (STATE != SceneCombinerState.NotLoaded) return;

			Load();
		}

		private static void Load() {
			INSTANCE = FindObjectOfType<SceneCombinerRegistry>();
			STATE = INSTANCE ? SceneCombinerState.Ready : SceneCombinerState.NotFound;
		}

		public static IEnumerable<AbstractMeshCombiner> Combiners {
			get {
				switch (STATE) {
					case SceneCombinerState.NotFound: return _EMPTY;
					case SceneCombinerState.NotLoaded:
						Load();
						return Combiners;
					case SceneCombinerState.Ready: return INSTANCE.combiners;
					default: throw new ArgumentOutOfRangeException();
				}
			}
		}
	}
}