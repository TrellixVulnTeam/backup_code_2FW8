using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ItemUIShow : MonoBehaviour
{
  [SerializeField]private Text text;
  [SerializeField]private Image image;
    
  public void SetImage(string name) {
      Sprite currImage = Resources.Load<Sprite>("Icons/" + name);
      image.sprite = currImage;
  }

  public void UpdateCount(int count) {
      text.text = "" + count;
  }
}
