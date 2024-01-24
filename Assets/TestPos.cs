using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;

public class TestPos : MonoBehaviour
{
    [ShowInInspector]
    public Vector3 localPosition
    {
        get
        {
            return transform.localPosition;
        }
    }
    [ShowInInspector]
    public Vector3 worlPosition
    {
        get
        {
            return transform.position;
        }
    }
}
