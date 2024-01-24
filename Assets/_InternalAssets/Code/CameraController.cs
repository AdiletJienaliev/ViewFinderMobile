using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.UI;
using UnityEngine.Events;
using UnityEditor;
using Sirenix.OdinInspector;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;

public class CameraController : MonoBehaviour
{
    [SerializeField] private CameraPolaroid polaroidCamera;
    [SerializeField] private Volume globalVolume;
    [SerializeField] private Image cameraViewImage;
    [SerializeField] private CameraGizmosController cameraGizmo;
    [SerializeField] private Camera mainCamera;
    [Header("Sounds")]
    [SerializeField] private AudioSource audioSource;
    [SerializeField] private AudioClip takePhotoSount;
    [SerializeField] private AudioClip pastephotoSound;

    [Header("Canvas view anim")]
    [SerializeField] Image top;
    [SerializeField] Image bottom;

    public static UnityEvent PhotoAction = new UnityEvent();

    private bool cameraPoolOutCondition = false;

    private void Awake()
    {
        PhotoAction.AddListener(TakePhoto);
    }

    bool cameraPullOuted = false;
    private void CameraViewActivate(bool condition)
    {
        if (cameraPullOuted) return;
        cameraPullOuted = true;
        ActivateEffects(condition, 0.35f, () => { cameraPullOuted = false;    });

        polaroidCamera.PullOutAnimation(condition);
        cameraPoolOutCondition = condition;
    }

    private void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            PhotoAction.Invoke();
        }
        if (Input.GetKeyDown(KeyCode.E))
        {
            cameraPoolOutCondition = !cameraPoolOutCondition;
            CameraViewActivate(cameraPoolOutCondition);
        }
        if (Input.GetMouseButtonDown(1))
        {
            if (photoItem != null && cameraGizmo.Photo.gameObject.activeSelf)
            {
                cameraGizmo.Photo.gameObject.SetActive(false);
                cameraGizmo.Photo.sharedMaterial.SetTexture("_BaseMap", photoItem.texture);

                audioSource.PlayOneShot(pastephotoSound);
                cameraGizmo.PastePhoto( photoItem.objects);
            }
            else if(photoItem != null && !cameraGizmo.Photo.gameObject.activeSelf)
            {
                cameraGizmo.Photo.gameObject.SetActive(true);
                cameraGizmo.Photo.sharedMaterial.SetTexture("_BaseMap", photoItem.texture);
            }
        }
    }


    bool cameraAlreadyWork = false;
   public  PhotoItem photoItem;
    private void TakePhoto()
    {
        if (cameraAlreadyWork) return;

        if (cameraPoolOutCondition)
        {
            cameraAlreadyWork = true;
            polaroidCamera.TakePhoto((Texture2D texture) => {
                LeanTween.value(gameObject, 0, 1, 0.2f).setOnUpdate((float v) =>
                {
                    top.fillAmount = v;
                    bottom.fillAmount = v;
                }).setOnComplete(() =>
                {

                    LeanTween.value(gameObject, 1, 0, 0.2f).setOnUpdate((float v) =>
                    {
                        top.fillAmount = v;
                        bottom.fillAmount = v;
                    });
                });
                photoItem = new PhotoItem(texture, cameraGizmo.TakePhoto());
                counter++;
               // CreateMyCustomData(new PhotoItem(texture, cameraGizmo.TakePhoto()));
            });
                audioSource.PlayOneShot(takePhotoSount);

            ActivateEffects(false);
            ActivateEffects(true, 4f, () => cameraAlreadyWork = false);
        }
    }

    private IEnumerator AdileyCall(float delay, UnityAction action)
    {
        yield return new WaitForSeconds(delay);
        action?.Invoke();
    }

    private void ActivateEffects(bool condition, float delay = 0.35f, UnityAction end = null)
    {
        if (condition)
        {
            StartCoroutine(AdileyCall(delay, () =>
            {
                cameraViewImage.gameObject.SetActive(true);
                end?.Invoke();
            }));
        }
        else
        {
            end?.Invoke();
            cameraViewImage.gameObject.SetActive(false);
        }
    }

    int counter = 0;
    int meshCounter = 0;
    [Button]
    private PhotoItem SavePhotoToScriptableObject(Texture2D texture, List<CutObjectItem> photoObjects)
    {
        /* PhotoItem asset = ScriptableObject.CreateInstance<PhotoItem>();

         // Создайте путь, по которому будет сохранен новый файл
         string path = AssetDatabase.GenerateUniqueAssetPath($"Assets/PhotoData/Photos/NewPhoto{counter}.asset");

         List<CutObjectItem> newObjects = new List<CutObjectItem>();

         for (int i = 0; i < photoObjects.Count; i++)
         {
             Mesh savedMesh = SaverAsset.SaveMesh(photoObjects[i].mesh, "Mesh_"+ meshCounter);
             List<Material> savedMaterials = new List<Material>();
             for (int m = 0; m < photoObjects[i].materials.Length; m++)
             {
                 Material mat = SaverAsset.SaveMaterial(photoObjects[i].materials[m], "Material_" + meshCounter);
                 savedMaterials.Add(mat);
             }

             newObjects.Add(new CutObjectItem(
                 photoObjects[i].position,
                 photoObjects[i].rotation,
                 photoObjects[i].scale,
                 savedMesh,
                 savedMaterials.ToArray(),
                 photoObjects[i].hasRigidbody));
             meshCounter++;
         }
         Texture2D savedTexture = SaverAsset.SaveTexture(texture, "Texture_" + meshCounter);
         asset = new PhotoItem(savedTexture, newObjects);

         // Создайте актив на диске
         AssetDatabase.CreateAsset(asset, path);
         AssetDatabase.SaveAssets();

         // Откройте окно редактора и выберите новый актив
         EditorUtility.FocusProjectWindow();
         Selection.activeObject = asset;

         return asset;*/
        return null;
    }
}

public class PhotoItem
{
    public Texture2D texture;
    public List<CutObjectItem> objects = new List<CutObjectItem>();

    public PhotoItem(Texture2D texture, List<CutObjectItem> objects)
    {
        this.texture = texture;
        this.objects = new List<CutObjectItem>(objects);
    }
}
[System.Serializable]
public class CutObjectItem
{
    public Vector3 position;
    public Quaternion rotation;
    public Vector3 scale;
    public Mesh mesh;
    public Material material;
    public bool hasRigidbody;

    public CutObjectItem(Vector3 position, Quaternion rotation, Vector3 scale, Mesh mesh, Material material, bool hasRigidbody)
    {
        this.position = position;
        this.rotation = rotation;
        this.scale = scale;
        this.mesh = mesh;
        this.material = material;
        this.hasRigidbody = hasRigidbody;
    }
}

public static class SaverAsset
{
    [System.Serializable]
    private struct SerializableMesh
    {
        public Vector3[] vertices;
        public int[] triangles;
        public Vector3[] normals;
        public Vector2[] uv;
        // ... other mesh data
    }

    public static Mesh SaveMesh(Mesh meshToSave, string filename)
    {
        string folderPath = Path.Combine(Application.streamingAssetsPath, "Meshes");
        string filePath = Path.Combine(folderPath, filename + ".bin");

        // Ensure the directory exists
        if (!Directory.Exists(folderPath))
        {
            Directory.CreateDirectory(folderPath);
        }

        SerializableMesh serializableMesh = new SerializableMesh
        {
            vertices = meshToSave.vertices,
            triangles = meshToSave.triangles,
            normals = meshToSave.normals,
            uv = meshToSave.uv,
            // ... serialize other mesh data
        };

        // Save the serialized mesh to a file
        using (var stream = new FileStream(filePath, FileMode.Create))
        {
            var formatter = new BinaryFormatter();
            formatter.Serialize(stream, serializableMesh);
        }

        Debug.Log("Mesh saved to " + filePath);

        // Reconstruct the mesh from the serialized data
        Mesh newMesh = new Mesh
        {
            vertices = serializableMesh.vertices,
            triangles = serializableMesh.triangles,
            normals = serializableMesh.normals,
            uv = serializableMesh.uv
            // ... apply other mesh data
        };

        return newMesh;
    }

    public static Material SaveMaterial(Material materialToSave, string filename)
    {
        string materialPath = Path.Combine(Application.streamingAssetsPath, filename + ".json");

        // Сериализуем свойства материала
        string materialJson = JsonUtility.ToJson(new SerializableMaterial(materialToSave));
        File.WriteAllText(materialPath, materialJson);

        // Воссоздаем материал из JSON
        Material newMaterial = new Material(materialToSave.shader);
        JsonUtility.FromJsonOverwrite(materialJson, newMaterial);

        return newMaterial;
    }

    // Структура для хранения данных материала
    [System.Serializable]
    private class SerializableMaterial
    {
        public Color color;

        public SerializableMaterial(Material material)
        {
            this.color = material.color; // Сериализуем только цвет. Расширьте для других свойств при необходимости
        }
    }

    public static Texture2D SaveTexture(Texture2D textureToSave, string filename)
    {
        string texturePath = Path.Combine(Application.persistentDataPath, filename);

        // Сохраняем текстуру в PNG
        byte[] textureBytes = textureToSave.EncodeToPNG();
        File.WriteAllBytes(texturePath, textureBytes);

        // Воссоздаем текстуру из сохраненных данных
        Texture2D newTexture = new Texture2D(2, 2); // Создаем текстуру с минимальным размером
        newTexture.LoadImage(textureBytes); // Загружаем изображение обратно в новый экземпляр текстуры, это также изменит размер текстуры

        return newTexture;
    }
}

[System.Serializable]
public class SerializableMeshData
{
    public Vector3[] vertices;
    public int[] triangles;
    // ... другие свойства Mesh
}

[System.Serializable]
public class SerializableMaterialData
{
    public Color color;
    // ... другие свойства Material
}

[System.Serializable]
public class SerializableTextureData
{
    public byte[] textureEncoded; // PNG или JPG данные
}

[System.Serializable]
public class MyScriptableObjectData
{
    public SerializableMeshData meshData;
    public SerializableMaterialData[] materialData;
    public SerializableTextureData textureData;
}

public static class DataSaver
{
    public static void SaveScriptableObjectData(MyScriptableObjectData data, string filename)
    {
        string json = JsonUtility.ToJson(data);
        string path = Path.Combine(Application.persistentDataPath, filename + ".json");
        File.WriteAllText(path, json);
    }
}

public static class DataLoader
{
    public static MyScriptableObjectData LoadScriptableObjectData(string filename)
    {
        string path = Path.Combine(Application.persistentDataPath, filename + ".json");
        if (File.Exists(path))
        {
            string json = File.ReadAllText(path);
            return JsonUtility.FromJson<MyScriptableObjectData>(json);
        }
        return null;
    }
}


