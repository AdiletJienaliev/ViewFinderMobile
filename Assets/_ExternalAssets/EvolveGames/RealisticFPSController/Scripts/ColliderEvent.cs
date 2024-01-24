using UnityEngine;
using UnityEngine.Events;

[RequireComponent(typeof(BoxCollider))] 
public class ColliderEvent : MonoBehaviour
{
    #region DATA
    [Header("Collider Event")]
    [Space(20)]
    public string GameObjectTag = "GameController";
    [Space(10)]
    public UnityEvent Event;
    #endregion

    private void OnTriggerEnter(Collider other)
    {
        if(other.tag == GameObjectTag)
        {
            Event.Invoke();
        }
    }
}