using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Networking;
using UnityEngine.SceneManagement;
using System.Text;
using System.IO;

public class Routes : MonoBehaviour
{
  public GameObject CardPrefab;
  public string baseUrl = "";
  public string token = "";

  private string getUrl(string url)
  {
    return baseUrl + url;
  }

  public static Routes Ins
  {
    get;
    private set;
  }

  void Awake()
  {
    DontDestroyOnLoad(this.gameObject);
    Ins = this;

    string configFile = Application.dataPath + "/config.ini";
    if (File.Exists(configFile))
    {
      ConfigIni ini = new ConfigIni(configFile);
      //host = ini.ReadIniContent("DeepStreamServer", "host");
      //port = ini.ReadIniContent("DeepStreamServer", "port");
      baseUrl = ini.keyVal["server_ip"];
      //MessageBox(IntPtr.Zero, configFile+","+host+","+port, "从配置文件读取DeepStream的IP:Port", 0);
    }
  }

  public void Login(string username, string password)
  {
    Debug.Log(username + "&" + password);
    string url = getUrl("login");
    User userData = new User();
    userData.username = username;
    userData.password = password;

    StartCoroutine(Request<LoginResult>(url, method: "POST", jsonData: userData, callback: (json) =>
     {
       token = json.access_token;
       SceneManager.LoadScene(1);
       Debug.Log("加载场景");
     }));
  }

  public void ExtractCard(int count, Transform show)
  {
    for (int i = show.childCount - 1; i >= 0; --i)
    {
      var child = show.transform.GetChild(i).gameObject;
      Destroy(child);
    }

    string url = getUrl("card/get_cards");
    ExtractCardUploadData data = new ExtractCardUploadData();
    data.count = count;
    StartCoroutine(
      Request<Wrapper<Card[]>>(
        url,
        method: "POST",
        jsonData: data,
        callback: (json) =>
    {
      foreach (Card card in json.data)
      {
        GameObject gb = Instantiate(CardPrefab);
        gb.transform.parent = show;
        CardData cd = gb.GetComponent<CardData>();
        cd.InitCardData(card);
      }
    }));
  }
  public IEnumerator GetImageCoroutine(string url, Action<Sprite> callback)
  {

    UnityWebRequest www = UnityWebRequestTexture.GetTexture(url);
    yield return www.SendWebRequest();
    if (www.isNetworkError || www.isHttpError)
    {
      Debug.Log(www.error);
    }
    else
    {
      Texture2D texture = ((DownloadHandlerTexture)www.downloadHandler).texture as Texture2D;
      Sprite sprite = Sprite.Create(texture, new Rect(0, 0, texture.width, texture.height), Vector2.zero);
      callback(sprite);
    }
  }

  public void GetImage(string imgName, Action<Sprite> callback)
  {
    string url = getUrl("files/" + imgName);
    StartCoroutine(GetImageCoroutine(url, callback));
  }

  public void GetUserStore(Transform bad)
  {
    for (int i = bad.childCount - 1; i >= 0; --i)
    {
      var child = bad.transform.GetChild(i).gameObject;
      Destroy(child);
    }

    string url = getUrl("card/get_user_store");
    StartCoroutine(Request<Wrapper<Card[]>>(url, callback: (json) =>
     {
       foreach (Card card in json.data)
       {
         GameObject gb = Instantiate(CardPrefab);
         gb.transform.parent = bad;
         CardData cd = gb.GetComponent<CardData>();
         cd.InitCardData(card);
       }

     }));
  }

  private IEnumerator Request<T>(string url, string method = "GET", Dictionary<string, string> headers = null, object jsonData = null, Action<T> callback = null)
  {

    UnityWebRequest www = new UnityWebRequest(url, method);

    if (jsonData != null)
    {
      string jsonString = JsonUtility.ToJson(jsonData);
      byte[] bodyRaw = Encoding.UTF8.GetBytes(jsonString);
      www.uploadHandler = (UploadHandlerRaw)new UploadHandlerRaw(bodyRaw);
    }

    www.SetRequestHeader("Content-Type", "application/json");
    if (!string.IsNullOrEmpty(token))
    {
      www.SetRequestHeader("Authorization", "Bearer " + token);
    }
    if (headers != null)
    {
      foreach (KeyValuePair<string, string> header in headers)
      {
        www.SetRequestHeader(header.Key, header.Value);
      }
    }

    www.downloadHandler = (DownloadHandler)new DownloadHandlerBuffer();
    yield return www.SendWebRequest();

    byte[] results = www.downloadHandler.data;

    if (callback != null)
    {
      string targetJson = Encoding.UTF8.GetString(results, 0, results.Length);
      Debug.Log(targetJson);

      T jsonDict = JsonUtility.FromJson<T>(targetJson);
      callback(jsonDict);
    }
  }
}
