using UnityEngine;

public class Property {
  public static object GetValue(object obj, string propertyName) {
    Debug.Log(obj);
    return obj.GetType().GetProperty(propertyName).GetValue(obj, null);
  }
}