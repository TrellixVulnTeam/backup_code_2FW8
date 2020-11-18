using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class CardData : MonoBehaviour
{
  [SerializeField] private Transform States;
  [SerializeField] private GameObject m_Field;
  // [SerializeField]private Panel m_state;
  [SerializeField] private Text m_skillText;
  [SerializeField] private TextMeshProUGUI m_levelText;
  [SerializeField] private TextMeshProUGUI m_nameText;
  [SerializeField] private Image m_img;
  private MainApis apis;

  void Awake()
  {
    GameObject gb = GameObject.Find("MainApis");
    if (gb != null)
    {
      apis = gb.GetComponent<MainApis>();
    }
  }
  private Dictionary<string, string> m_fields = new Dictionary<string, string> {
        {"近战", "melee"},
        {"力量", "strength"},
        {"体力", "ps"},
        {"调查", "research"},
        {"远程", "remote"},
        {"敏捷", "speed"},
        {"幸运", "lucky"},
        {"交涉", "talk"},
    };

  public void InitCardData(Card card)
  {
    m_skillText.text = card.skill;
    m_levelText.text = card.rare;
    m_nameText.text = card.name;
    GenerateStates(card);
    Debug.Log(apis);
    apis.GetCardImage(card.path, (Sprite sprite) =>
    {
      m_img.sprite = sprite;
    });
  }

  private void GenerateStates(Card card)
  {
    foreach (KeyValuePair<string, string> item in m_fields)
    {
      string name = item.Key;
      string propertyName = item.Value;
      typeof(Card).GetField(propertyName).GetValue(card);

      //   string propertyValue = (string)(card.GetType().GetProperty(propertyName).GetValue(card, null));
      string propertyValue = "A";
      GameObject field = Instantiate(m_Field, States) as GameObject;
      CardStateField f = field.GetComponent<CardStateField>();
      f.Title = name;
      f.Level = propertyValue;
    }
  }
}
