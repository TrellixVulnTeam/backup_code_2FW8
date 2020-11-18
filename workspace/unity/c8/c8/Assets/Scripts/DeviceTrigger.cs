using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DeviceTrigger : MonoBehaviour
{
  [SerializeField] private GameObject[] targets;
  // Start is called before the first frame update
  private void OnTriggerEnter(Collider other)
  {
    foreach (GameObject target in targets)
    {
      target.SendMessage("Activate");
    }
  }

  private void OnTriggerExit(Collider other)
  {
    Debug.Log("exit");
    foreach (GameObject target in targets)
    {
      target.SendMessage("Deactivate");
    }
  }
}
