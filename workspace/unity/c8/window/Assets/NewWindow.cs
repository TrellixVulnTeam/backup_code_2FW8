using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class NewWindow : EditorWindow
{
    string myString = "";
    bool myBool = false;
    float myFloat = 0.0f;
    
    [MenuItem("New Window/New")]
    public static void ShowWindow() {
        EditorWindow.GetWindow(typeof(NewWindow));
    }

    private void OnGUI()
    {
        EditorGUILayout.TextField ("Text Field", myString);
        EditorGUILayout.Toggle ("Toggle", myBool);
        EditorGUILayout.Slider ("Slider", myFloat, -3, 3);
    }
}
