using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VisibilityTracker : MonoBehaviour
{
    private void OnBecameVisible()
    {
        Debug.Log("���� ����");
    }
    private void OnBecameInvisible()
    {
        Debug.Log("� ����� �� �����");
        
    }
}
