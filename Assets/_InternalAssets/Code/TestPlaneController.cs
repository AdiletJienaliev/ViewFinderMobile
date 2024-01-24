using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using BzKovSoft.ObjectSlicer.Samples;
using Sirenix.OdinInspector;
public class TestPlaneController : SerializedMonoBehaviour
{
    public IBzSliceableNoRepeat _sliceableAsync;
    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Vector3 pos0 = transform.position;
        Vector3 pos1 = transform.position + transform.forward * 5;
        Vector3 pos2 = transform.position + transform.right * 3;
        Gizmos.DrawLine(pos0, pos1);
        Gizmos.DrawLine(pos1, pos2);
        Gizmos.DrawLine(pos2, pos0);
        Gizmos.color = Color.blue;
        pos0 = transform.position;
        pos1 = transform.position + transform.forward * 5;
        pos2 = transform.position + (transform.up) * 3;
        Gizmos.DrawLine(pos0, pos1);
        Gizmos.DrawLine(pos1, pos2);
        Gizmos.DrawLine(pos2, pos0);
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.L))
        {
            Vector3 pos0 = transform.position;
            Vector3 pos1 = transform.position + transform.forward * 5;
            Vector3 pos2 = transform.position + transform.right * 3;
            Plane plane = new Plane(pos0, pos1, pos2);
            pos0 = transform.position;
            pos1 = transform.position + transform.forward * 5;
            pos2 = transform.position + (transform.up) * 3;
            Plane plane1 = new Plane(pos0, pos1, pos2);
            StartCoroutine(Slice(_sliceableAsync, plane));
            StartCoroutine(Slice(_sliceableAsync, plane1));
        }
    }
    private IEnumerator Slice(IBzSliceableNoRepeat _sliceableAsync, Plane plane)
    {
        // The call from OnTriggerEnter, so some object positions are wrong.
        // We have to wait for next frame to work with correct values
        yield return null;

        _sliceableAsync.Slice(plane, SliceIdProvider.GetNewSliceId(), null);
    }
}
