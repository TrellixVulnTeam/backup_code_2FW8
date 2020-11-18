using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(PlayerManager))]
[RequireComponent(typeof(InventoryManager))]
public class Managers : MonoBehaviour
{
  public static PlayerManager Player { get; private set; }
  public static InventoryManager Inventory { get; private set; }

  private static List<IGameManager> managers;

  void Awake()
  {
    managers = new List<IGameManager>();
    Player = new PlayerManager();
    Inventory = new InventoryManager();
    managers.Add(Player);
    managers.Add(Inventory);
    StartCoroutine(StartupManagers());
  }

  private IEnumerator StartupManagers()
  {
    foreach (IGameManager manager in managers)
    {
      manager.Startup();
    }

    //暂停一帧
    yield return null;

    int numModules = managers.Count;
    int readyModules = 0;

    while (numModules > readyModules)
    {
      readyModules = 0;
      foreach (IGameManager manager in managers)
      {
        if (manager.status == ManagerStatus.Started)
        {
          readyModules += 1;
        }
      }

      Debug.Log("加载 Managers...");
      if (numModules == readyModules)
      {
          Debug.Log("加载 Managers 完成!");
          yield return null;
      }
      

    }
  }
}
