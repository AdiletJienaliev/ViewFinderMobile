using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace EvolveGames
{
    public class Viewpoint : MonoBehaviour
    {
        [Header("Viewpoint")]
        [SerializeField] string PointText = "Press E";
        [Space, SerializeField] Camera cam;
        [SerializeField] GameObject PlayerController;
        [SerializeField] Image ImagePrefab;
        [Space ,SerializeField, Range(0.1f, 20)] float MaxViewRange = 8;
        [SerializeField, Range(0.1f, 20)] float MaxTextViewRange = 3;
        float Distance;
        Text ImageText;
        Image ImageUI;
        void Start()
        {
            ImageUI = Instantiate(ImagePrefab, FindObjectOfType<Canvas>().transform).GetComponent<Image>();
            ImageText = ImageUI.GetComponentInChildren<Text>();
            ImageText.text = PointText;
        }
        void Update()
        {
            ImageUI.transform.position = cam.WorldToScreenPoint(calculateWorldPosition(transform.position, cam));
            Distance = Vector3.Distance(PlayerController.transform.position, transform.position);

            if(Distance < MaxTextViewRange)
            {
                Color OpacityColor = ImageText.color;
                OpacityColor.a = Mathf.Lerp(OpacityColor.a, 1, 10 * Time.deltaTime);
                ImageText.color = OpacityColor;
            }
            else
            {
                Color OpacityColor = ImageText.color;
                OpacityColor.a = Mathf.Lerp(OpacityColor.a, 0, 10 * Time.deltaTime);
                ImageText.color = OpacityColor;
            }

            if (Distance < MaxViewRange)
            {
                Color OpacityColor = ImageUI.color;
                OpacityColor.a = Mathf.Lerp(OpacityColor.a, 1, 10 * Time.deltaTime);
                ImageUI.color = OpacityColor;
            }
            else
            {
                Color OpacityColor = ImageUI.color;
                OpacityColor.a = Mathf.Lerp(OpacityColor.a, 0, 10 * Time.deltaTime);
                ImageUI.color = OpacityColor;
            }

        }
        private Vector3 calculateWorldPosition(Vector3 position, Camera camera)
        {
            Vector3 camNormal = camera.transform.forward;
            Vector3 vectorFromCam = position - camera.transform.position;
            float camNormDot = Vector3.Dot(camNormal, vectorFromCam.normalized);
            if (camNormDot <= 0f)
            {
                float camDot = Vector3.Dot(camNormal, vectorFromCam);
                Vector3 proj = (camNormal * camDot * 1.01f);
                position = camera.transform.position + (vectorFromCam - proj);
            }
            return position;
        }

    }
}
