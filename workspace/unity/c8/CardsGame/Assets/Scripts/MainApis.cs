using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MainApis : MonoBehaviour
{
    [SerializeField] private Transform Bad;
    [SerializeField] private Transform Show;
    // Start is called before the first frame update
    public void GetUserStore()
    {
        Routes.Ins.GetUserStore(Bad);
    }

    public void ExtractCard(int count = 1) {
        Routes.Ins.ExtractCard(count, Show);
    }

    public void GetCardImage(string imgSrc, Action<Sprite> callback) {
        Routes.Ins.GetImage(imgSrc, callback);
    }
}
