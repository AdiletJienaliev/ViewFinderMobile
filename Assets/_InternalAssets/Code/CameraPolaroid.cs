using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using Sirenix.OdinInspector;

public class CameraPolaroid : MonoBehaviour
{
    public RenderTexture renderTexture;
    public Animator animator;
    public MeshRenderer planephotoRenderer;
    public Camera pictureCamera;

    public void PullOutAnimation(bool condition)
    {
        animator.SetBool("PullOut", condition);
    }

    [PreviewField(100, ObjectFieldAlignment.Center)]
    public Texture2D texture;
    private void SetTextureToPhoto(Texture2D texture)
    {
        planephotoRenderer.sharedMaterial.SetTexture("_BaseMap", texture);
        this.texture = texture;
    }
    private IEnumerator TakePhotoCoroutine(UnityAction<Texture2D> onPhotoTaken)
    {
        // Wait for the end of the frame to ensure all camera rendering has finished
        yield return new WaitForEndOfFrame();

        // Set the active RenderTexture to the one you want to read from
        RenderTexture.active = renderTexture;

        // Create a new Texture2D with the same size as the RenderTexture
        Texture2D tex = new Texture2D(renderTexture.width, renderTexture.height, TextureFormat.ARGB32, false);

        // Read the pixels from the RenderTexture and apply them to the Texture2D
        tex.ReadPixels(new Rect(0, 0, renderTexture.width, renderTexture.height), 0, 0);
        tex.Apply();

        // Clean up
        RenderTexture.active = null;

        // Invoke the callback with the resulting Texture2D
        onPhotoTaken?.Invoke(tex);
    }

    public void TakePhoto(UnityAction<Texture2D> onPhotoTaken)
    {
        animator.SetTrigger("TakePhoto");
        pictureCamera.gameObject.SetActive(true);
        StartCoroutine(TakePhotoCoroutine((Texture2D tex) => { 
        
        SetTextureToPhoto(tex);
            onPhotoTaken?.Invoke(tex);
        }));
    }
}
