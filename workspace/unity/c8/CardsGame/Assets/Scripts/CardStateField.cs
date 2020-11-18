using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class CardStateField : MonoBehaviour
{
    [SerializeField]private TextMeshProUGUI m_levelText;
    [SerializeField]private TextMeshProUGUI m_titleText;

    public string Level {
        get {
            return m_levelText.text;
        }

        set {
            m_levelText.text = value;
        }
    }

    public string Title {
        get {
            return m_titleText.text;
        }

        set {
            m_titleText.text = value + "/";
        }
    }
}
