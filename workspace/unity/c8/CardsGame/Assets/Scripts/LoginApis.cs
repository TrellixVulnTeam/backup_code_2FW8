using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class LoginApis : MonoBehaviour
{
  [SerializeField] private InputField UsernameInput;
  [SerializeField] private InputField PasswordInput;

  public void Login()
  {
    Routes.Ins.Login(UsernameInput.text, PasswordInput.text);
  }
}
