using System.Collections;
using System.Collections.Generic;
using UnityEngine;
public class SphereCreator : PlotController
{
    public GameObject sphere;
    public float timer;
    public Transform startPoint;
    public Transform endPoint;
    public List<Transform> createdSphere;

    public AudioSource source;

    [SerializeField] float clampV;
    protected override void Start()
    {
        LeanTween.delayedCall(timer, () =>
        {
            source.Play();
        });
    }

    public override void updatePlot(List<SpectralFluxInfo> pointInfo, int curIndex = -1)
    {
        Debug.Log(curIndex);
        if (pointInfo[curIndex].isPeak)
        {
            GameObject a = Instantiate<GameObject>(sphere, startPoint);
            a.transform.localPosition = Vector3.zero;

            if (Random.Range(0, 2) == 0)
                a.GetComponentInChildren<MeshRenderer>().sharedMaterial.SetColor("_EmissionColor", Color.red);
            else
                a.GetComponentInChildren<MeshRenderer>().sharedMaterial.SetColor("_EmissionColor", Color.cyan);

            LeanTween.move(a, endPoint.position, timer).setOnComplete(() => { Destroy(a); });

            a.transform.Rotate(0, 0, Random.Range(0, 360));
            createdSphere.Add(a.transform);
        }
    }

    private void Update()
    {
        
    }

}
