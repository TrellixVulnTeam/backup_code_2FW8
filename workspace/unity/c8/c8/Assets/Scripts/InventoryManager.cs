using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InventoryManager : MonoBehaviour, IGameManager
{
  public ManagerStatus status { get; private set; }
  private Dictionary<string, int> _items;

  public Dictionary<string, int> Items  {
    get {
      return _items;
    }
  }

  public void Startup()
  {
    Debug.Log("初始化InventoryManager");
    _items = new Dictionary<string, int>();
    status = ManagerStatus.Started;
  }

  public void AddItem(string name)
  {
    if (_items.ContainsKey(name))
    {
      _items[name] += 1;
    }
    else
    {
      _items[name] = 1;
    }

    DisplayItems();
  }

  public void DisplayItems()
  {
    string itemDisplay = "Items: ";
    foreach (KeyValuePair<string, int> item in _items)
    {
      itemDisplay += item.Key + "(" + item.Value + ")";
    }

    Debug.Log(itemDisplay);
  }
}
