using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SMZQ : MonoBehaviour
{

    void Awake() {
        Debug.Log(gameObject.name +  " Awake");
    }


    private void OnEnable() {
        Debug.Log(gameObject.name +  " OnEnable");
        
    }

    private void FixedUpdate()
    {
        Debug.Log(gameObject.name +  " FixedUpdate");
        
    }

    private void LateUpdate()
    {
        Debug.Log(gameObject.name +  " LateUpdate");
        
    }

    private void OnDisable()
    {
        Debug.Log(gameObject.name +  " OnDisable");
    }

    private void OnDestroy()
    {
        
    }
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
