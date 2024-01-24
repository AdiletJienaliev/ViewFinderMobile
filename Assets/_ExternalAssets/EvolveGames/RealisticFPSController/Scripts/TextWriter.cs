using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace EvolveGames
{
    public class TextWriter : MonoBehaviour
    {
        #region DATA
        [Header("Text Writer")]
        [SerializeField] public Text TextElement;
        [SerializeField] string TextToWrite;
        [SerializeField] float TimeToWrite;
        float timer;
        int Index;
        [HideInInspector] public bool Writing;
        #endregion

        public void AddWriter(string TextToWrite, Text TextElement, float TimeToWrite)
        {
            this.TextToWrite = TextToWrite;
            this.TimeToWrite = TimeToWrite;
            this.TextElement = TextElement;
            Index = 0;
        }

        void Update()
        {
            if (TextElement != null)
            {
                timer -= Time.deltaTime;
                while (timer < 0f)
                {
                    timer += TimeToWrite;
                    Index++;
                    TextElement.text = TextToWrite.Substring(0, Index);

                    if (Index >= TextToWrite.Length)
                    {
                        TextElement = null;
                        Debug.Log("DialogEnd");
                        return;
                    }
                }
            }
        }
    }
}