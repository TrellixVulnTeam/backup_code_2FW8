using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Talk : MonoBehaviour
{
  [SerializeField]
  private TextAsset talkAsset;


  public string[] Talks
  {
    get
    {
      return talkAsset.text.Split(new char[] { '\n' });
    }
  }
}
