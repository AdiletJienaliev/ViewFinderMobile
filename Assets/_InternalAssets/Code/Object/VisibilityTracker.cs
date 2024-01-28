using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VisibilityTracker : MonoBehaviour
{
    private void OnBecameVisible()
    {
        Debug.Log("”зри мен€");
    }
    private void OnBecameInvisible()
    {
        Debug.Log("я вышел из кадра");
        
    }
}
