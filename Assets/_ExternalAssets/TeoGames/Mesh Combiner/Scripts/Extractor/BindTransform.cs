using System;
using System.Collections.Generic;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEngine;

namespace TeoGames.Mesh_Combiner.Scripts.Extractor {
	[Serializable]
	public class BindOptions {
		public Transform source;
		public Transform target;
	}

	[AddComponentMenu("Mesh Combiner/Utils/MC Bind Transform")]
	public class BindTransform : MonoBehaviour {
		public List<BindOptions> list = new List<BindOptions>();
		public Transform alignParent;
		private Transform _Anchor;

		private void Awake() => _Anchor = new GameObject() {
			name = "Anchor",
			transform = { parent = transform }
		}.transform;

		public void FixedUpdate() => list.ForEach(UpdateTransform);

		public void Sync(bool isStatic, Transform target, Transform source) {
			var obj = new BindOptions() { source = source, target = target };
			if (!isStatic) list.Add(obj);
			UpdateTransform(obj);
		}

		protected void UpdateTransform(BindOptions obj) {
			if (!obj.source) return;

			if (alignParent.gameObject.scene.name == null) {
				obj.target.SyncTransform(obj.source, alignParent);
			} else {
				_Anchor.parent = obj.source;
				_Anchor.localPosition = Vector3Extensions.Zero;
				_Anchor.localEulerAngles = Vector3Extensions.Zero;
				_Anchor.localScale = Vector3Extensions.One;

				_Anchor.parent = alignParent;
				obj.target.localPosition = Vector3.Scale(_Anchor.localPosition, alignParent.localScale);
				obj.target.localEulerAngles = _Anchor.localEulerAngles;
				obj.target.localScale = _Anchor.lossyScale;

				_Anchor.parent = transform;
			}
		}
	}
}