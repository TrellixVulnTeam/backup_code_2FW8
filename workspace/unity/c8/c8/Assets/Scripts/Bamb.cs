using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bamb : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        transform.Rotate(0, 360.0f * Time.deltaTime, 0);
    }
}
