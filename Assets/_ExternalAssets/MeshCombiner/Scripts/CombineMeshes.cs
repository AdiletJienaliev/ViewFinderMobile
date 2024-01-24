﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Linq;

namespace LylekGames {

	public class CombineMeshes : MonoBehaviour {
    
		private Matrix4x4 myMatrix;
        [HideInInspector]
        public MeshFilter myMeshFilter;
        [HideInInspector]
        public MeshRenderer myMeshRenderer;
        [HideInInspector]
        public List<MeshFilter> meshFilters = new List<MeshFilter>();
        [HideInInspector]
        public List<MeshRenderer> meshRenderers = new List<MeshRenderer>();

        public void Start()
        {
            /*myMeshFilter = GetComponent<MeshFilter>();
            myMeshRenderer = GetComponent<MeshRenderer>();*/
        }
        public void EnableMeshNewCollider() {
            if (myMeshFilter)
            {
                if (myMeshFilter.sharedMesh != null)
                {
                    Debug.LogError("This object already contains mesh data. (This may occur when adding the Combine script to an existing mesh. Please take a quick look at the Readme to find out how to use the combine script as intended).");
                    Debug.Log("Combine script removed.");
                    DestroyImmediate(this);
                    return;
                }
            }
            if (transform.childCount > 0)
            {
                myMatrix = transform.worldToLocalMatrix;
                CombineInstance[] combine;
                meshFilters = GetComponentsInChildren<MeshFilter>().ToList();
                combine = new CombineInstance[meshFilters.Count];
                for (int i = 0; i < meshFilters.Count; i++)
                {
                    if (meshFilters[i].sharedMesh != null)
                    {
                        combine[i].mesh = meshFilters[i].sharedMesh;
                        combine[i].transform = myMatrix * meshFilters[i].transform.localToWorldMatrix;
                        meshFilters[i].gameObject.SetActive(false);
                    }
                }
                myMeshFilter.mesh = new Mesh();
                myMeshFilter.sharedMesh.CombineMeshes(combine);
                myMeshRenderer.material = meshFilters[1].GetComponent<Renderer>().sharedMaterial;
                gameObject.AddComponent<MeshCollider>();
                gameObject.isStatic = true;
            }
            else
                Debug.Log("There are no child meshes to combine.");
        }

		public void DisableMesh() {
            if (meshFilters != null && meshFilters.Count > 0)
            {
                for (int i = 0; i < meshFilters.Count; i++)
                {
                    meshFilters[i].gameObject.SetActive(true);
                }
                if (meshRenderers != null)
                    if (meshRenderers.Count > 0)
                        foreach (MeshRenderer meshRenderer in meshRenderers)
                            meshRenderer.enabled = true;
                myMeshFilter.mesh = null;
                myMeshRenderer.material = null;
                if (GetComponent<Collider>())
                    DestroyImmediate(gameObject.GetComponent<Collider>());
            }
            else
            {
                Debug.LogError("There is no mesh data to disable. (This may occur when adding the Combine script to an existing mesh. Please take a quick look at the Readme to find out how to use the combine script as intended.)");
                Debug.Log("Combine script removed.");
                DestroyImmediate(this);
                return;
            }
        }
	}
}
