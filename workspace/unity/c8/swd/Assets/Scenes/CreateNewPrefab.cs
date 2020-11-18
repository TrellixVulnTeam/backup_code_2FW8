using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CreateNewPrefab : MonoBehaviour
{

    [SerializeField]
    GameObject prefab;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void DoCreateNewPrefab() {
        Instantiate(prefab, Vector3.zero, Quaternion.identity);
    }
}
