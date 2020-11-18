using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ItemsUIShow : MonoBehaviour
{
  [SerializeField] private GameObject ItemPrefab;
  public Dictionary<string, ItemUIShow> Status;

  void Awake()
  {
    Status = new Dictionary<string, ItemUIShow>();
  }
  void FixedUpdate()
  {
    foreach (KeyValuePair<string, int> item in Managers.Inventory.Items)
    {
      ItemUIShow elem = null;
      if (!Status.ContainsKey(item.Key))
      {
        elem = AddNewItemUI(item.Key);
      }
      else
      {
        elem = Status[item.Key];
      }

      elem.UpdateCount(item.Value);
    }
  }

  ItemUIShow AddNewItemUI(string name)
  {
    GameObject ins = Instantiate(ItemPrefab);
    ItemUIShow itemUIShow = ins.GetComponent<ItemUIShow>();
    itemUIShow.SetImage(name);
    ins.transform.SetParent(this.transform, false);
    Status.Add(name, itemUIShow);
    return itemUIShow;
  }
}
