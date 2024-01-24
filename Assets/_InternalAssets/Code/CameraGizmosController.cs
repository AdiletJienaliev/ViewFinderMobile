using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using BzKovSoft.ObjectSlicer.Samples;
using Sirenix.OdinInspector;
using System.Linq;
using BzKovSoft.CharacterSlicer.Samples;
using UnityEngine.Events;

public class CameraGizmosController : SerializedMonoBehaviour
{
    [SerializeField] private Camera cam;
    [SerializeField] private Camera viewCam;
    [SerializeField] private GameObject cutee;
    [SerializeField] private Material defaultMaterial;

    public Transform[] DebugPoints = new Transform[0];

    public IBzSliceableNoRepeat _sliceableAsync;
    public MeshRenderer Photo;
    public Material PhotoMaterial;

    private void Awake()
    {
        CreateMeshCamera();
    }

    private async void Update()
    {

    }
    private void CreateMeshCamera()
    {
        int[] triangles =
        {
    // Нижняя часть (ближний план к дальнему)
    0, 2, 3, // ближний нижний треугольник
    3, 7, 2, // дальний нижний треугольник
    // Верхняя часть (ближний план к дальнему)
    0, 4, 5, // ближний верхний треугольник
    0, 5, 1, // дальний верхний треугольник
    // Левая сторона
    0, 3, 7, // ближняя левая часть
    0, 7, 4, // дальняя левая часть
    // Правая сторона
    1, 5, 6, // ближняя правая часть
    1, 6, 2, // дальняя правая часть
    // Передняя часть
    0, 1, 2, // ближний передний треугольник
    0, 3, 2, // дальний передний треугольник
    // Задняя часть
    4, 7, 6, // ближний задний треугольник
    4, 6, 5, // дальний задний треугольник
};
        Vector3[] vertices = Tools.GetCameraFrustumCorners(viewCam);
        for (int i = 0; i < vertices.Length; i++)
        {
            vertices[i] -= viewCam.transform.position;
        }
        Mesh mesh = new Mesh();
        mesh.vertices = vertices;
        mesh.triangles = triangles;
        mesh.RecalculateNormals(); // Добавим пересчет нормалей для корректного отображения освещения

        MeshFilter mf = viewCam.gameObject.AddComponent<MeshFilter>();
        mf.mesh = mesh;

        MeshCollider collider = viewCam.gameObject.AddComponent<MeshCollider>();
        collider.sharedMesh = mesh; // Используем sharedMesh вместо mesh для коллайдера
        collider.convex = true;
        collider.isTrigger = true;


        GameObject photo = new GameObject();
        photo.transform.SetParent(cam.transform);
        photo.transform.localPosition = Vector3.zero;

        vertices = Tools.GetCameraFrustumCorners(viewCam);
        //Find Slice of camera frustum
        Vector3[] top = { vertices[0], vertices[1], vertices[2], vertices[3] };
        Vector3[] bottom = { vertices[4], vertices[5], vertices[6], vertices[7] };

        Vector3[] sliced = Tools.GetSliceOfPyramid(top, bottom, 0.5f);
        for (int i = 0; i < sliced.Length; i++)
        {
            sliced[i] -= viewCam.transform.position;
        }

        MeshFilter meshFilter = photo.AddComponent<MeshFilter>();
        MeshRenderer meshRenderer = photo.AddComponent<MeshRenderer>();

        Mesh photoMesh = new Mesh();
        int[] triangles1 = { 0, 1, 2, 2,3,0, };
        photoMesh.vertices = sliced;
        for (int i = 0; i < sliced.Length; i++)
        {
            DebugPoints[i].transform.position = sliced[i];
        }
        photoMesh.triangles = triangles1;
        meshFilter.mesh = photoMesh;
        photoMesh.uv = new Vector2[] {
    new Vector2(0, 1),  // Левый верхний угол
    new Vector2(1, 1), // Правый верхний угол
    new Vector2(1, 0), // Правый нижний угол
    new Vector2(0, 0), // Левый нижний угол
};
        photoMesh.RecalculateNormals();
        photoMesh.RecalculateBounds();
        photoMesh.RecalculateTangents();
        meshRenderer.material = new Material(PhotoMaterial);

        photo.SetActive(false);
        
        Photo = meshRenderer;
    }


    public float distanceZ;
   

    int photocounter;
    private (List<GameObject> cutObject, List<GameObject> resultObjects) CutObjects(Vector3[] vertices)
    {
        photocounter++;
        int[] triangles = Tools.GetSliceTriangles();

        List<GameObject> sliceNegResult = new List<GameObject>();
        List<GameObject> slicePosResult = new List<GameObject>();
        for (int s = 0; s < bzSliceableNoRepeats.Count; s++)
        {
            GameObject sliceObject = bzSliceableNoRepeats[s];
            if (sliceObject == null)
            {
                bzSliceableNoRepeats.RemoveAt(s);
                s--;
                continue;
            }
            bool isIntersecting = false;
            for (int i = 0; i < triangles.Length; i += 3)
            {
                Vector3 pos0 = vertices[triangles[i]];
                Vector3 pos1 = vertices[triangles[i + 1]];
                Vector3 pos2 = vertices[triangles[i + 2]];

                Plane plane = new Plane(pos0, pos1, pos2);
                isIntersecting = IsIntersecting(plane, sliceObject);
                if (isIntersecting)
                {
                    IBzSliceableNoRepeat sliceble = sliceObject.GetComponent<IBzSliceableNoRepeat>();
                    sliceble.Slice(plane, SliceIdProvider.GetNewSliceId(), (bzSliceTryResult) =>
                    {
                        if (bzSliceTryResult != null && bzSliceTryResult.outObjectPos != null)
                        {
                            sliceNegResult.Add(bzSliceTryResult.outObjectPos);
                        }
                        if (bzSliceTryResult != null && bzSliceTryResult.outObjectNeg != null)
                        {
                            slicePosResult.Add(bzSliceTryResult.outObjectNeg);
                        }
                    });
                }
            }
            if (!isIntersecting)
            {
                if (sliceObject != null)
                {
                    slicePosResult.Add(sliceObject);
                }
            }
        }
/*        CombineMesh(sliceNegResult);
        SlicesedObject(slicePosResult);*/
        return (sliceNegResult, slicePosResult);
    }


    public List<CutObjectItem> TakePhoto()
    {
        Vector3[] vertices = Tools.GetCameraFrustumCorners(viewCam);

        (List<GameObject> slicedObjects, List<GameObject> resultObjects) = CutObjects(vertices);

        List<CutObjectItem> resultCutObjects = new List<CutObjectItem>();
        for (int i = 0; i < resultObjects.Count; i++)
        {
            //Переменные
            GameObject cutObject = resultObjects[i];
            bool hasRigidbody;

            if (!cutObject.TryGetComponent<MeshRenderer>(out MeshRenderer meshRenderer) ||
                !cutObject.TryGetComponent<MeshFilter>(out MeshFilter meshFilter))
                continue;



            cutObject.transform.SetParent(viewCam.transform);
            hasRigidbody = cutObject.TryGetComponent<Rigidbody>(out Rigidbody rigidbody);

            if (hasRigidbody)
            {
                resultObjects.RemoveAt(i);
                i--;
            }

            Material material = Instantiate(meshRenderer.material); //Возможно стоит указывать индекс материала из глобального пула

            resultCutObjects.Add(new CutObjectItem(cutObject.transform.localPosition,
                cutObject.transform.localRotation,
                cutObject.transform.localScale,
                Instantiate(meshFilter.mesh),
                material,
                hasRigidbody));

            cutObject.transform.SetParent(null);
        }

        // Создаем новый список и добавляем в него элементы из обоих списков
        List<GameObject> combinedList = new List<GameObject>(slicedObjects);
        combinedList.AddRange(resultObjects);
        CombineMesh(combinedList);

        return resultCutObjects;
    }
    public void PastePhoto( List<CutObjectItem> photoObjects)
    {
        Vector3 startPos = viewCam.transform.localPosition;
        Quaternion startRot = viewCam.transform.rotation;
        Transform startparent = viewCam.transform.parent;

        viewCam.transform.position = this.cam.transform.position;
        viewCam.transform.rotation = this.cam.transform.rotation;
        viewCam.transform.SetParent(null);

        Vector3[] vertices = Tools.GetCameraFrustumCorners(viewCam);

        (List<GameObject> slicedObjects, List<GameObject> resultObjects) = CutObjects(vertices);

        DestroySlicedObjects(resultObjects);

        List<GameObject> createdMeshes = new List<GameObject>();
        for (int i = 0; i < photoObjects.Count; i++)
        {
            // Создаем новый объект GameObject
            GameObject spawnedObject = new GameObject("SpawnedObject");
            CutObjectItem item = photoObjects[i];

            spawnedObject.transform.SetParent(viewCam.transform);

            // Применяем мировые трансформации
            spawnedObject.transform.localPosition = item.position;
            spawnedObject.transform.localRotation = item.rotation; // Возможно, потребуется преобразование в мировое вращение
            spawnedObject.transform.localScale = item.scale;

            // Добавляем компоненты MeshFilter и MeshRenderer и настраиваем их
            MeshFilter filter = spawnedObject.AddComponent<MeshFilter>();
            filter.mesh = item.mesh; // Создаем копию сетки
            MeshRenderer renderer = spawnedObject.AddComponent<MeshRenderer>();
            renderer.material = item.material; // Создаем копии материаловЦ
            spawnedObject.AddComponent<MeshCollider>();
            spawnedObject.transform.SetParent(null);

            if (!item.hasRigidbody)
                createdMeshes.Add(spawnedObject);

            // Добавляем Rigidbody, если он был в оригинале
            if (item.hasRigidbody)
            {
                spawnedObject.AddComponent<Rigidbody>();
                CubeControllerSliceTest slicer = spawnedObject.AddComponent<CubeControllerSliceTest>();
            }
        }
        List<GameObject> combinedList = new List<GameObject>(slicedObjects);
        combinedList.AddRange(createdMeshes);
        CombineMesh(combinedList);

        viewCam.transform.SetParent(startparent);
        viewCam.transform.localPosition = startPos;
        viewCam.transform.rotation = startRot;
    }


    private void CombineMesh(List<GameObject> meshes)
    {
        //Обьеденить меш
        GameObject joinedMeshes = new GameObject("JoinMesh_" + photocounter);
        MeshCombiner meshCombiner = joinedMeshes.AddComponent<MeshCombiner>();
        MeshFilter comninerMeshFilter = joinedMeshes.AddComponent<MeshFilter>();
        MeshRenderer comninerMeshRenderer = joinedMeshes.AddComponent<MeshRenderer>();

        for (int i = 0; i < meshes.Count; i++)
            if (meshes[i] != null)
            {
                meshes[i].transform.SetParent(joinedMeshes.transform);
            }

        meshCombiner.CombineMeshesWithMutliMaterial(false);

        CubeControllerSliceTest cube = joinedMeshes.AddComponent<CubeControllerSliceTest>();
        MeshCollider meshCollider = joinedMeshes.AddComponent<MeshCollider>();

        cube.defaultSliceMaterial = defaultMaterial;
        for (int i = 0; i < meshes.Count; i++)
            if (meshes[i] != null)
                Destroy(meshes[i]);
    }
    private void DestroySlicedObjects(List<GameObject> slicedObjects)
    {
        //Результат резки
        for (int i = 0; i < slicedObjects.Count; i++)
        {
            if (slicedObjects[i] != null)
                Destroy(slicedObjects[i]);
        }
    }
    public bool IsIntersecting(Plane plane, GameObject obj)
    {
        Collider collider = obj.GetComponent<Collider>();
        if (collider == null)
        {
            Debug.LogError("Object does not have a collider");
            return false;
        }

        Bounds bounds = collider.bounds;
        return IsIntersecting(plane, bounds);
    }
    public bool IsIntersecting(Plane plane, Bounds bounds)
    {
        // Получаем все восемь углов Bounds
        Vector3[] corners = new Vector3[8];

        corners[0] = bounds.min;
        corners[1] = bounds.max;
        corners[2] = new Vector3(corners[0].x, corners[0].y, corners[1].z);
        corners[3] = new Vector3(corners[0].x, corners[1].y, corners[0].z);
        corners[4] = new Vector3(corners[1].x, corners[0].y, corners[0].z);
        corners[5] = new Vector3(corners[0].x, corners[1].y, corners[1].z);
        corners[6] = new Vector3(corners[1].x, corners[0].y, corners[1].z);
        corners[7] = new Vector3(corners[1].x, corners[1].y, corners[0].z);

        // Проверяем, находится ли хотя бы один угол за пределами плоскости
        foreach (var corner in corners)
        {
            if (plane.GetSide(corner))
                return true;
        }

        // Если ни один из углов не за пределами плоскости, объект полностью на одной стороне плоскости
        return false;
    }

    #region enter exit
    public List<GameObject> bzSliceableNoRepeats = new List<GameObject>();
    private void OnTriggerEnter(Collider other)
    {
        IBzSliceableNoRepeat mesh;
        if (other.TryGetComponent<IBzSliceableNoRepeat>(out mesh))
        {
            bzSliceableNoRepeats.Add(other.gameObject);
        }
    }
    private void OnTriggerExit(Collider other)
    {
        IBzSliceableNoRepeat mesh;
        if (other.TryGetComponent<IBzSliceableNoRepeat>(out mesh))
        {
            bzSliceableNoRepeats.Remove(other.gameObject);
        }
    }
    #endregion


    #region DrawGizmos

#if UNITY_EDITOR
    void OnDrawGizmosSelected()
    {
        if (cam == null)
            return;
        Gizmos.color = Color.red;
        Vector3[] vertices = Tools.GetCameraFrustumCorners(viewCam);
        int[] triangles = Tools.GetSliceTriangles();
        for (int i = 0; i < triangles.Length; i += 3)
        {
            Vector3 pos1 = vertices[triangles[i]];
            Vector3 pos2 = vertices[triangles[i + 1]];
            Vector3 pos3 = vertices[triangles[i + 2]];

            Gizmos.DrawLine(pos1, pos2);
            Gizmos.DrawLine(pos2, pos3);
            Gizmos.DrawLine(pos3, pos1);
        }
    }
#endif
    Coroutine coroutine;

    #endregion

}
