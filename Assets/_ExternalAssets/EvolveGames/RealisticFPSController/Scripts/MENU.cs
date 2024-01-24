using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace EvolveGames
{
    public class MENU : MonoBehaviour
    {
        [Header("MENU")]
        [SerializeField] GameObject MenuPanel;
        [SerializeField] Animator ani;
        [SerializeField] PlayerController Player;
        [Header("Input")]
        [SerializeField] KeyCode BackKey = KeyCode.Escape;
        private void Update()
        {
            if (Input.GetKeyDown(BackKey))
            {
                if (MenuPanel.activeInHierarchy)
                {
                    MenuPanel.SetActive(false);
                    Player.canMove = true;
                    Cursor.visible = false;
                    Cursor.lockState = CursorLockMode.Locked;
                    Time.timeScale = 1.0f;
                    ani.SetBool("START", false);
                }
                else
                {
                    MenuPanel.SetActive(true);
                    Player.canMove = false;
                    Cursor.visible = true;
                    Cursor.lockState = CursorLockMode.None;
                    Time.timeScale = 0.0f;
                    ani.SetBool("START", true);
                }
            }
        }
    }
}

   
