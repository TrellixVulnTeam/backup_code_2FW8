using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using MiniJSON;

public class WWWTest : MonoBehaviour
{
  void Awake()
  {
    StartCoroutine(GetCards(handleWWWText));
  }

  private void handleWWWText(string text)
  {
    Dictionary<string, object> dict;
    dict = Json.Deserialize(text) as Dictionary<string, object>;
    Dictionary<string, object> data = (Dictionary<string, object>)dict["data"];
    Debug.Log(data["name"]);
  }

  private IEnumerator GetCards(Action<string> callback)
  {
    //传递一个空的postData,该请求就会以post方法进行请求
    WWWForm form = new WWWForm();
    WWW www = new WWW("http://www.localhost:5000/card/get_cards", form);
    yield return www;
    callback(www.text);
  }
}
