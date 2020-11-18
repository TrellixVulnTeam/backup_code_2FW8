using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ButtonEvent : MonoBehaviour
{

    private float angle = 90f;
    private int h = 0;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        transform.Rotate(0, angle * h * Time.deltaTime, 0, Space.Self);
    }

    public void RotateDirection(int direction) {
        h = direction;
    }

    public void GGG() {

    }

    
}
