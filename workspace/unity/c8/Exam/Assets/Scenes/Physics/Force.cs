using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Force : MonoBehaviour
{
  [SerializeField]
  private float trust;
  private Rigidbody rig;
  private bool onDown = false;
  // Start is called before the first frame update
  void Start()
  {
    rig = GetComponent<Rigidbody>();
  }

  private void FixedUpdate()
  {
    if (onDown)
    {
      rig.AddForce(transform.right * trust);
      onDown = false;
    }
  }

  private void OnMouseDown()
  {
    onDown = true;
  }

}
