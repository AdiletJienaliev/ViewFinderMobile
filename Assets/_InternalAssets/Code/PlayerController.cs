using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    [SerializeField] private CharacterController characterController;
    [SerializeField] private Transform cameraHolder;
    [Header("Settings")]
    [SerializeField] private float lookSpeedX = 1;
    [SerializeField] private float lookSpeedY = 1;
    [SerializeField] private float moveSpeedX = 1;
    [SerializeField] private float moveSpeedY = 1;

    private void OnValidate()
    {
        if (characterController == null)
            characterController = GetComponent<CharacterController>();
    }

    private void Update()
    {
        
    }
    private void Movement()
    {
        float inputX = Input.GetAxis("Horizontal");
        float inputY = Input.GetAxis("Vertical");

        characterController.Move(new Vector3(inputX, 0, inputY));
    }
    private void Look()
    {

    }
}
