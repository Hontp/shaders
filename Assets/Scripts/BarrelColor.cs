using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class BarrelColor : MonoBehaviour
{
    public Color firstColor = Color.green;
    public Color secondColor = Color.yellow;

    [Range(0, 1)]
    public float Smoothness = 0.5f;

    [Range(0, 1)]
    public float Metallic = 0;

    // Use this for initialization
    private void Start()
    {
    }

    // Update is called once per frame
    private void Update()
    {
        gameObject.GetComponent<Renderer>().sharedMaterial.SetColor("_firstColor", firstColor);
        gameObject.GetComponent<Renderer>().sharedMaterial.SetColor("_secondColor", secondColor);
        gameObject.GetComponent<Renderer>().sharedMaterial.SetFloat("_Glossiness", Smoothness);
        gameObject.GetComponent<Renderer>().sharedMaterial.SetFloat("_Metallic", Metallic);
    }

    #region comment

    //     float r, g, b;

    //r = Random.Range(0, 255);
    //  g = Random.Range(0, 255);
    // b = Random.Range(0, 255);

    //        var color = new Color(r, g, b, 255);

    #endregion comment
}