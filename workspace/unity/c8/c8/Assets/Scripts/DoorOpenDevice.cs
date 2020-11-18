using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;
public class DoorOpenDevice : MonoBehaviour
{
    [SerializeField] private Vector3 pos;
    private bool _isOpen = false;

    public void Operate() {
        if (_isOpen) {
            transform.DOMove(transform.position + pos, 1.5f);
        } else {
            transform.DOMove(transform.position - pos, 1.5f);
        } 
        _isOpen = !_isOpen;
    }

    public void Activate() {
        transform.DOMove(transform.position - pos, 1.5f);
    }

    public void Deactivate() {
        transform.DOMove(transform.position + pos, 1.5f);
    }
}
