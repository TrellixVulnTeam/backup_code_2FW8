using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;

public class CardEvents : MonoBehaviour, IPointerEnterHandler, IPointerExitHandler
{

  Animator animator;
  private void Awake()
  {
    animator = GetComponent<Animator>();
  }
  public void OnPointerEnter(PointerEventData eventData)
  {
    animator.SetBool("OnMouseOver", true);
  }

  public void OnPointerExit(PointerEventData eventData)
  {
    animator.SetBool("OnMouseOver", false);
  }
}
