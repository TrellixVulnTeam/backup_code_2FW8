using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;


public class Block : MonoBehaviour
{
    [SerializeField]
    private TextMeshPro tmp;
    private int _Level = 2;
    public int Level{
        get {
            return _Level;
        }

        set {
            if (value > 0 && value % 2 == 0) {
                _Level = value;
                tmp.text = _Level.ToString();
            }
        }
    }

    private void Start()
    {
         tmp.text = _Level.ToString();
    }

    public void LevelUp() {
        this.Level *= 2;
    }
}
