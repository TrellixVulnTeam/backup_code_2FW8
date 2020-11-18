using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class VisitControl : MonoBehaviour
{
    public GameObject panel;

    public void ClickShow() {
        panel.SetActive(!panel.gameObject.active);
    }
}
