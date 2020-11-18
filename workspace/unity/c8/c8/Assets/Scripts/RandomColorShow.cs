using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RandomColorShow : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        Color c = new Color(
            Random.Range(0f, 1f),
            Random.Range(0f, 1f),
            Random.Range(0f, 1f)
        );

        GetComponent<Renderer>().material.color = c;
    }
}
