using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace EvolveGames
{
    public class HandsHolder : MonoBehaviour
    {
        [Header("HandsHolder")]
        [SerializeField] bool Enabled = true;
        [Space, Header("Main")]
        [SerializeField, Range(0.0005f, 0.02f)] float Amount = 0.005f;
        [SerializeField, Range(1.0f, 3.0f)] float SprintAmount = 1.4f;

        [SerializeField, Range(5f, 20f)] float Frequency = 13.0f;
        [SerializeField, Range(50f, 10f)] float Smooth = 24.2f;
        [Header("RotationMovement")]
        [SerializeField] bool EnabledRotationMovement = true;
        [SerializeField, Range(0.1f, 10.0f)] float RotationMultipler = 6f;
        float ToggleSpeed = 1.5f;
        float AmountValue;
        Vector3 StartPos;
        Vector3 StartRot;
        Vector3 FinalPos;
        Vector3 FinalRot;
        CharacterController player;
        private void Awake()
        {
            player = GetComponentInParent<CharacterController>();
            if (player.transform.GetComponent<PlayerController>() != null) ToggleSpeed = player.transform.GetComponent<PlayerController>().CroughSpeed * 1.5f;
            else ToggleSpeed = 1.5f;
            AmountValue = Amount;
            StartPos = transform.localPosition;
            StartRot = transform.localRotation.eulerAngles;
        }

        private void Update()
        {
            if (!Enabled) return;
            float speed = new Vector3(player.velocity.x, 0, player.velocity.z).magnitude;
            Reset();
            if (speed > ToggleSpeed && player.isGrounded)
            {
                FinalPos += HeadBobMotion();
                FinalRot += new Vector3(-HeadBobMotion().z, 0, HeadBobMotion().x) * RotationMultipler * 10;
            }
            else if (speed > ToggleSpeed) FinalPos += HeadBobMotion() / 2f;

            if (Input.GetKeyDown(KeyCode.LeftShift)) AmountValue = Amount * SprintAmount;
            else if (Input.GetKeyUp(KeyCode.LeftShift)) AmountValue = Amount / SprintAmount;
            transform.localPosition = Vector3.Lerp(transform.localPosition, FinalPos, Smooth * Time.deltaTime);
            if (EnabledRotationMovement) transform.localRotation = Quaternion.Lerp(transform.localRotation, Quaternion.Euler(FinalRot), Smooth / 1.5f * Time.deltaTime);

        }

        private Vector3 HeadBobMotion()
        {
            Vector3 pos = Vector3.zero;
            pos.y += Mathf.Lerp(pos.y, Mathf.Sin(Time.time * Frequency) * AmountValue * 2f, Smooth * Time.deltaTime);
            pos.x += Mathf.Lerp(pos.x, Mathf.Cos(Time.time * Frequency / 2f) * AmountValue * 1.3f, Smooth * Time.deltaTime);
            return pos;
        }
        private void Reset()
        {
            if (transform.localPosition == StartPos) return;
            FinalPos = Vector3.Lerp(FinalPos, StartPos, 1 * Time.deltaTime);
            FinalRot = Vector3.Lerp(FinalRot, StartRot, 1 * Time.deltaTime);
        }
    }

}