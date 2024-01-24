using BzKovSoft.ObjectSlicer;
using BzKovSoft.ObjectSlicer.Polygon;
using BzKovSoft.ObjectSlicer.Samples;
using System;
using System.Collections;
using System.Diagnostics;
using UnityEngine;
using UnityEngine.Profiling;
using BzKovSoft.ObjectSlicer.EventHandlers;

namespace BzKovSoft.CharacterSlicer.Samples
{
	public class CubeControllerSliceTest : BzSliceableObjectBase, IBzSliceableNoRepeat, IBzObjectSlicedEvent
	{
		[HideInInspector]
		[SerializeField]
		int _sliceId;
		[HideInInspector]
		[SerializeField]
		float _lastSliceTime = float.MinValue;
		public float delayBetweenSlices = 1f;
		public void Slice(Plane plane, int sliceId, Action<BzSliceTryResult> callBack)
		{
			if (gameObject == null) return;
			float currentSliceTime = Time.time;

			// we should prevent slicing same object:
			// - if _delayBetweenSlices was not exceeded
			// - with the same sliceId
			if ((sliceId == 0 & _lastSliceTime + delayBetweenSlices > currentSliceTime) |
				(sliceId != 0 & _sliceId == sliceId))
			{
				return;
			}

			_lastSliceTime = currentSliceTime;
			_sliceId = sliceId;

			Slice(plane, callBack);
		}

        public void ObjectSliced(GameObject original, GameObject resutlNeg, GameObject resultPos)
        {
			/*if(resultPos != null)
			Destroy(resultPos);*/
			//original.AddComponent<Rigidbody>();
			/*if (resutlNeg != null)
				resutlNeg.SetActive(false);*/

			
        }
    }
}
