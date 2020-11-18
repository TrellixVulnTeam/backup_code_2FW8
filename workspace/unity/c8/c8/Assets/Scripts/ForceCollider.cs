using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ForceCollider : MonoBehaviour
{
    public float pushForce = 150.0f;

    void OnCollisionEnter(Collision collision) {
        Rigidbody body = collision.collider.attachedRigidbody;
        if (body != null && !body.isKinematic) {
            body.velocity = transform.forward * pushForce;
        }
    }

}
