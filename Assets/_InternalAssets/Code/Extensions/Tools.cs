using System;
using System.Collections.Generic;
using System.IO;
using TeoGames.Mesh_Combiner.Scripts.Combine;
using TeoGames.Mesh_Combiner.Scripts.Combine.Lod;
using TeoGames.Mesh_Combiner.Scripts.Extension;
using UnityEditor;
using UnityEngine;
using Object = UnityEngine.Object;
namespace AJ
{
    public static class Tools
    {
        #region Geometry tools
        public static Vector3[] GetCameraFrustumCorners(Camera camera)
        {
            Transform camTransform = camera.transform;
            float fov = camera.fieldOfView;
            float aspect = camera.aspect;
            float near = camera.nearClipPlane;
            float far = camera.farClipPlane;

            float nearHeight = 2.0f * Mathf.Tan(fov * 0.5f * Mathf.Deg2Rad) * near;
            float nearWidth = nearHeight * aspect;
            float farHeight = 2.0f * Mathf.Tan(fov * 0.5f * Mathf.Deg2Rad) * far;
            float farWidth = farHeight * aspect;

            Vector3[] frustumCorners = new Vector3[8];

            Vector3 nearCenter = camTransform.position + camTransform.forward * near;
            Vector3 farCenter = camTransform.position + camTransform.forward * far;

            Vector3 toNearRight = camTransform.right * nearWidth * 0.5f;
            Vector3 toNearTop = camTransform.up * nearHeight * 0.5f;
            Vector3 toFarRight = camTransform.right * farWidth * 0.5f;
            Vector3 toFarTop = camTransform.up * farHeight * 0.5f;

            frustumCorners[0] = nearCenter + toNearTop - toNearRight; // Near Top Left
            frustumCorners[1] = nearCenter + toNearTop + toNearRight; // Near Top Right
            frustumCorners[2] = nearCenter - toNearTop + toNearRight; // Near Bottom Right
            frustumCorners[3] = nearCenter - toNearTop - toNearRight; // Near Bottom Left

            frustumCorners[4] = farCenter + toFarTop - toFarRight; // Far Top Left
            frustumCorners[5] = farCenter + toFarTop + toFarRight; // Far Top Right
            frustumCorners[6] = farCenter - toFarTop + toFarRight; // Far Bottom Right
            frustumCorners[7] = farCenter - toFarTop - toFarRight; // Far Bottom Left
            return frustumCorners;
        }
        public static Vector3[] GetObstructedFrustumCorners(Camera camera, Transform[] cornerTransforms)
        {
            if (camera == null)
            {
                Debug.LogError("Camera is null");
                return null;
            }

            if (cornerTransforms == null || cornerTransforms.Length != 4)
            {
                Debug.LogError("There must be exactly 4 corner Transforms");
                return null;
            }

            Vector3[] obstructedFrustumCorners = new Vector3[8];

            // Вычисляем пересечения с near и far плоскостями для каждого угла объекта
            for (int i = 0; i < cornerTransforms.Length; i++)
            {
                if (cornerTransforms[i] == null)
                {
                    Debug.LogError("One of the corner transforms is null");
                    return null;
                }

                // Луч от камеры к углу объекта
                Ray ray = new Ray(camera.transform.position, cornerTransforms[i].position - camera.transform.position);

                // Пересечение с near плоскостью
                if (camera.nearClipPlane > 0 && new Plane(camera.transform.forward, camera.transform.position + camera.transform.forward * camera.nearClipPlane).Raycast(ray, out float nearDistance))
                {
                    obstructedFrustumCorners[i] = ray.GetPoint(nearDistance);
                }
                else
                {
                    obstructedFrustumCorners[i] = camera.transform.position;
                }

                // Пересечение с far плоскостью
                if (camera.farClipPlane > 0 && new Plane(camera.transform.forward, camera.transform.position + camera.transform.forward * camera.farClipPlane).Raycast(ray, out float farDistance))
                {
                    obstructedFrustumCorners[i + 4] = ray.GetPoint(farDistance);
                }
                else
                {
                    obstructedFrustumCorners[i + 4] = camera.transform.position;
                }
            }

            return obstructedFrustumCorners;
        }

        public static Plane[] CreateCameraFrustumPlanes(Vector3[] frustumCorners)
        {
            Plane topPlane = new Plane(frustumCorners[4], frustumCorners[5], frustumCorners[1]);
            Plane bottomPlane = new Plane(frustumCorners[3], frustumCorners[2], frustumCorners[6]);
            Plane leftPlane = new Plane(frustumCorners[0], frustumCorners[3], frustumCorners[7]);
            Plane rightPlane = new Plane(frustumCorners[5], frustumCorners[1], frustumCorners[6]);
            Plane nearPlane = new Plane(frustumCorners[0], frustumCorners[1], frustumCorners[2]);
            Plane farPlane = new Plane(frustumCorners[7], frustumCorners[6], frustumCorners[5]);

            return new Plane[] { topPlane, bottomPlane, leftPlane, rightPlane/*, nearPlane, farPlane*/ };
        }
        public static Plane[] CreateCameraFrustumSlicePlanes(Camera camera)
        {
            Vector3[] frustumCorners = GetCameraFrustumCorners(camera);

            // Создаем плоскости на основе углов фрустума
            Plane topPlane = new Plane(frustumCorners[4], frustumCorners[5], frustumCorners[1]);
            Plane bottomPlane = new Plane(frustumCorners[3], frustumCorners[2], frustumCorners[6]);
            Plane leftPlane = new Plane(frustumCorners[3], frustumCorners[7], frustumCorners[4]);
            Plane rightPlane = new Plane(frustumCorners[6], frustumCorners[2], frustumCorners[1]);
            Plane nearPlane = new Plane(frustumCorners[0], frustumCorners[1], frustumCorners[2]);
            Plane farPlane = new Plane(frustumCorners[7], frustumCorners[6], frustumCorners[5]);

            return new Plane[] { topPlane, bottomPlane, leftPlane, rightPlane/*, nearPlane, farPlane*/ };
        }

        public static int[] GetSliceTriangles()
        {
            int[] triangles =
            {
            //Правая часть 
            1,5,6,//Main
           // 1,2,6,//Second
            //Низ
            3,6,7,//Main
            //3,2,6,//Second
            //Лево 
            0,7,4, //Main
           // 3,0,7,//Second
            //Веерх
            0,4,5, // Main
            //0,1,5 //Second
};
            return triangles;
        }
        public static Vector3[] GetSliceOfPyramid(Vector3[] topPoints, Vector3[] bottomPoints, float distanceFromTop)
        {
            if (topPoints.Length != 4 || bottomPoints.Length != 4)
            {
                Debug.LogError("There must be exactly 4 top and 4 bottom points.");
                return null;
            }

            Vector3[] slicePoints = new Vector3[4];
            Vector3 centroidTop = CalculateCentroid(topPoints);
            Vector3 centroidBottom = CalculateCentroid(bottomPoints);
            float totalHeight = Vector3.Distance(centroidTop, centroidBottom);

            // Находим коэффициент для линейной интерполяции
            float lambda = distanceFromTop / totalHeight;

            // Применяем линейную интерполяцию между соответствующими верхними и нижними точками
            for (int i = 0; i < 4; i++)
            {
                slicePoints[i] = topPoints[i] + (bottomPoints[i] - topPoints[i]) * lambda;
            }

            return slicePoints;
        }
        public static List<Vector3> GetObstructingObjectFrustum(Camera camera, Transform[] points)
        {
            // Ensure that points array has exactly 4 points representing the corners of the object.
            if (points.Length != 4)
            {
                Debug.LogError("Points array must contain exactly 4 points.");
                return null;
            }

            List<Vector3> frustumCorners = new List<Vector3>();

            // Calculate frustum corners for the obstructing object.
            // We assume the points are in the order: bottom-left, top-left, top-right, bottom-right.
            for (int i = 0; i < points.Length; i++)
            {
                // Convert each point to the camera's local space to get the relative positions.
                Vector3 pointInCameraLocalSpace = camera.transform.InverseTransformPoint(points[i].position);

                // Project the point onto the near plane.
                float nearPlaneDistance = -pointInCameraLocalSpace.z / camera.nearClipPlane;
                Vector3 nearPlaneCorner = new Vector3(
                    pointInCameraLocalSpace.x / nearPlaneDistance,
                    pointInCameraLocalSpace.y / nearPlaneDistance,
                    -camera.nearClipPlane
                );

                // Project the point onto the far plane.
                float farPlaneDistance = -pointInCameraLocalSpace.z / camera.farClipPlane;
                Vector3 farPlaneCorner = new Vector3(
                    pointInCameraLocalSpace.x / farPlaneDistance,
                    pointInCameraLocalSpace.y / farPlaneDistance,
                    -camera.farClipPlane
                );

                // Transform the points back to world space and add them to the list.
                // Transform the near and far plane points back to world space
                Vector3 worldSpaceNearCorner = camera.transform.TransformPoint(nearPlaneCorner);
                Vector3 worldSpaceFarCorner = camera.transform.TransformPoint(farPlaneCorner);

                // Add the corners to the frustum corners list
                frustumCorners.Add(worldSpaceNearCorner);
                frustumCorners.Add(worldSpaceFarCorner);
            }

            // Return the list of frustum corners for the obstructing object
            return frustumCorners;
        }
        public static Vector3[] GetScaledPositionedVertices(Vector3[] outerSq1, Vector3[] outerBsq2, Vector3[] innerSq1)
        {
            float scaleWidth = (Vector3.Distance(outerBsq2[0], outerBsq2[1]) / Vector3.Distance(outerSq1[0], outerSq1[1]));
            float scaleHeight = (Vector3.Distance(outerBsq2[1], outerBsq2[2]) / Vector3.Distance(outerSq1[1], outerSq1[2]));

            Vector3 centerA1B1C1D1 = CalculateCentroid(innerSq1);

            Vector3[] E1F1G1H1 = new Vector3[4];
            E1F1G1H1[0] = centerA1B1C1D1 + (innerSq1[0] - centerA1B1C1D1) * scaleWidth;
            E1F1G1H1[1] = centerA1B1C1D1 + (innerSq1[1] - centerA1B1C1D1) * scaleWidth;
            E1F1G1H1[2] = centerA1B1C1D1 + (innerSq1[2] - centerA1B1C1D1) * scaleHeight;
            E1F1G1H1[3] = centerA1B1C1D1 + (innerSq1[3] - centerA1B1C1D1) * scaleHeight;
            return E1F1G1H1;
        }

        public static Vector3 CalculateCentroid(Transform[] points)
        {
            if (points.Length != 4)
            {
                Debug.LogError("The method expects an array of exactly 4 points.");
                return Vector3.zero;
            }

            Vector3 centroid = Vector3.zero;
            foreach (Transform point in points)
            {
                centroid += point.position;
            }
            centroid /= points.Length; // Divide by the number of points to get the average

            return centroid;
        }
        public static Vector3 CalculateCentroid(Vector3[] points)
        {
            if (points.Length != 4)
            {
                Debug.LogError("The method expects an array of exactly 4 points.");
                return Vector3.zero;
            }

            Vector3 centroid = Vector3.zero;
            foreach (Vector3 point in points)
            {
                centroid += point;
            }
            centroid /= points.Length; // Divide by the number of points to get the average

            return centroid;
        }
        public static Vector3 FindDirection(Vector3 A, Vector3 B)
        {
            Vector3 direction = B - A;

            return direction.normalized;
        }
        public static Vector3[] GetPhotoFrustum(Camera cam, Transform[] photonAnglePoint, float distanceSliceTop)
        {
            //Find camera frustum
            Vector3[] vertices = GetCameraFrustumCorners(cam);

            //Find Slice of camera frustum
            Vector3[] top = { vertices[0], vertices[1], vertices[2], vertices[3] };
            Vector3[] bottom = { vertices[4], vertices[5], vertices[6], vertices[7] };

            Vector3[] frustumSq = GetSliceOfPyramid(top, bottom, distanceSliceTop);

            //Find photo frustum
            Vector3[] innerSq1 = new Vector3[4];
            for (int i = 0; i < photonAnglePoint.Length; i++)
                innerSq1[i] = photonAnglePoint[i].position;
            Vector3[] outerBsq2 = bottom;
            Vector3[] outerSq1 = frustumSq;

            Vector3 centerOuter = CalculateCentroid(outerSq1);
            Vector3 centerTarget = CalculateCentroid(outerBsq2);
            Vector3 displacement = centerTarget - centerOuter;
            Vector3[] innerBsq2 = GetScaledPositionedVertices(outerSq1, outerBsq2, innerSq1);

            Vector3[] frustumPhotoTop = innerSq1;
            Vector3[] frustumPhotoBottom = innerBsq2;
            Vector3[] frustumPhoto = new Vector3[8];

            for (int i = 0; i < 4; i++)
            {
                frustumPhoto[i] = frustumPhotoTop[i];
                frustumPhoto[i + 4] = frustumPhotoBottom[i] + displacement;
            }
            return frustumPhoto;
        }
        #endregion

        #region Mesh Combiner setup
        public static void SetupMeshCombiner(UnityEngine.GameObject obj)
        {
            if (!obj.GetComponent<MeshCombiner>())
            {
                obj.AddComponent<MeshCombiner>();

                Debug.Log($"Added Mesh Combiner to {obj.name}", obj);
            }

            obj.GetComponentsInChildren<MeshRenderer>(true).ForEach(AddStaticCombiner);
            obj.GetComponentsInChildren<SkinnedMeshRenderer>(true).ForEach(AddDynamicCombiner);
        }

        public static void SetupChunkMeshCombiner(UnityEngine.GameObject obj)
        {
            if (!obj.GetComponent<ChunkMeshCombiner>())
            {
                obj.AddComponent<ChunkMeshCombiner>();

                Debug.Log($"Added Chunk Mesh Combiner to {obj.name}", obj);
            }

            obj.GetComponentsInChildren<MeshRenderer>(true).ForEach(AddStaticCombiner);
            obj.GetComponentsInChildren<SkinnedMeshRenderer>(true).ForEach(AddDynamicCombiner);
        }

        public static void AddStaticCombiner(MeshRenderer ren)
        {
            if (ren.TryGetComponent<Combinable>(out var comb))
            {
                comb.UpdateStatus();
                return;
            }

            try
            {
                if (ren.GetComponentInParent<LODGroup>())
                {
                    comb = ren.gameObject.AddComponent<LodCombinable>();
                    comb.isStatic = true;
                    comb.ClearCache(true);

                    Debug.Log($"Added static LOD Combinable to {ren.name}", ren);
                }
                else
                {
                    comb = ren.gameObject.AddComponent<Combinable>();
                    comb.isStatic = true;
                    comb.ClearCache(true);

                    Debug.Log($"Added static Combinable to {ren.name}", ren);
                }

                EditorUtility.SetDirty(comb);
            }
            catch (Exception e)
            {
                Debug.LogError($"Unable to add combinable for {ren.name}", ren);
                Debug.LogException(e, ren);
            }
        }

        public static void RemoveCombiner(AbstractCombinable comb)
        {
            Debug.Log($"Removed Combinable at {comb.name}", comb.gameObject);
            Object.DestroyImmediate(comb, true);
        }

        public static bool CheckClearCache(AbstractCombinable comb)
        {
            Debug.Log($"Clear cache at {comb.name}", comb.gameObject);

            return ClearCache(comb);
        }

        public static void LogClearCache(AbstractCombinable comb)
        {
            Debug.Log($"Clear cache at {comb.name}", comb.gameObject);

            ClearCache(comb);
        }

        public static bool ClearCache(AbstractCombinable comb)
        {
            var oldCache = comb.GetCache();
            comb.ClearCache(true);

            if (comb.GetCache().IsDifferent(oldCache))
            {
                EditorUtility.SetDirty(comb);

                return true;
            }

            return false;
        }

        public static void AddDynamicCombiner(SkinnedMeshRenderer ren)
        {
            if (ren.TryGetComponent<Combinable>(out var comb))
            {
                comb.UpdateStatus();
                return;
            }

            if (ren.GetComponentInParent<LODGroup>())
            {
                var combinable = ren.gameObject.AddComponent<LodCombinable>();
                combinable.isStatic = false;
                combinable.ClearCache(true);

                Debug.Log($"Added dynamic LOD Combinable to {ren.name}", ren);
            }
            else
            {
                var combinable = ren.gameObject.AddComponent<Combinable>();
                combinable.isStatic = false;
                combinable.ClearCache(true);

                Debug.Log($"Added dynamic Combinable to {ren.name}", ren);
            }
        }
        #endregion
    }
}
