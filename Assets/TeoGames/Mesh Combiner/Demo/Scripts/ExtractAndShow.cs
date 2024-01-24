using System.Threading.Tasks;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using TeoGames.Mesh_Combiner.Scripts.Extractor;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Demo.Scripts {
    [AddComponentMenu("Mesh Combiner/Demo/MC Extract and show")]
    [RequireComponent(typeof(MeshExtractor))]
    public class ExtractAndShow : MonoBehaviour {
        public Vector3 offset = Vector3.zero;
        public Vector3 rotation = Vector3.zero;
        public float scale;
        public bool buildOnStartup;

        [Range(0, 1)] public float progress = 1f;
        public Transform source;

        public MeshExtractor Extractor => GetComponent<MeshExtractor>();

        private void OnEnable() {
            if (buildOnStartup) Build();
        }

        public void SetProgress(float val) {
            progress = val;
            UpdateProgress();
        }

        public void Build() {
            Task.CompletedTask.WaitForUpdate()
                .ContinueWith(() => Extractor.Build(source, offset, rotation, scale))
                .ContinueWith(UpdateProgress)
                .Forget();
        }

        private void OnValidate() => UpdateProgress();

        public void UpdateProgress() {
            var showTo = Mathf.CeilToInt(Extractor.Count * progress);
            for (var i = 0; i < Extractor.Count; i++) {
                if (i < showTo) Extractor.Show(i);
                else Extractor.Hide(i);
            }
        }
    }
}