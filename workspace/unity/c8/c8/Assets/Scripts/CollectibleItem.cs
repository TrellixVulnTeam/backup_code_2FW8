using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollectibleItem : MonoBehaviour
{
  [SerializeField] private string name;
  // Start is called before the first frame update
  private void OnTriggerEnter(Collider other) {
    Managers.Inventory.AddItem(name);
    Destroy(this.gameObject);
  }
}
