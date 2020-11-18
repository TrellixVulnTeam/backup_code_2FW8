using System.Collections;
using System.Collections.Generic;
using UnityEngine;

struct Grid
{
  public int x;
  public int y;
}

public class Logic : MonoBehaviour
{

  public GameObject[,] maps;

  [SerializeField]
  private GameObject blockPrefab;

  [SerializeField]
  private float gridSize;

  private void Start()
  {
    maps = new GameObject[4, 4];
    for (int i = 0; i < 2; i++)
    {
      AddRandomBlock();
    }


  }

  private void Update()
  {
    bool isControl = true;
    if (Input.GetKeyDown(KeyCode.A))
    {
      ControlLeft();
    }
    else if (Input.GetKeyDown(KeyCode.D))
    {
      ControlRight();
    }
    else if (Input.GetKeyDown(KeyCode.W))
    {
      ControlUp();
    }
    else if (Input.GetKeyDown(KeyCode.S))
    {
      ControlDown();
    }
    else
    {
      isControl = false;
    }

    if (isControl)
    {
      AddRandomBlock();
    }
  }

  private void AddRandomBlock()
  {
    if (EmptyGrids.Count > 0)
    {
      Grid g = EmptyGrids[Random.Range(0, EmptyGrids.Count)];
      AddBlock(g.x, g.y);
    }

  }

  private List<Grid> EmptyGrids
  {
    get
    {
      List<Grid> gs = new List<Grid>();
      for (int y = 0; y < maps.GetLength(0); y++)
      {
        for (int x = 0; x < maps.GetLength(1); x++)
        {
          if (maps[y, x] == null)
          {
            Grid g;
            g.x = x;
            g.y = y;
            gs.Add(g);
          }
        }
      }

      return gs;
    }
  }

  private void AddBlock(int xIndex, int yIndex)
  {
    if (maps[yIndex, xIndex] == null)
    {
      GameObject block = Instantiate(blockPrefab);
      SetBlockPosition(block, xIndex, yIndex);
      maps[yIndex, xIndex] = block;
    }
  }

  private void SetBlockPosition(GameObject gb, int x, int y)
  {
    gb.transform.position = transform.position + new Vector3(
              x * gridSize,
                -y * gridSize,
                -1);
  }

  public void ControlLeft()
  {
    for (int y = 0; y < maps.GetLength(0); y++)
    {
      for (int x = 0; x < maps.GetLength(1); x++)
      {
        int nextX = FindNextLeftBlock(y, x + 1);

        if (nextX != -1)
        {
          HandleTwoBlock(y, x, y, nextX);
        }
      }
    }
  }

  private int FindNextLeftBlock(int y, int start)
  {
    for (int j = start; j < maps.GetLength(1); j++)
    {
      if (maps[y, j] != null)
      {
        return j;
        break;
      }
    }

    return -1;
  }

  public void ControlRight()
  {
    for (int y = 0; y < maps.GetLength(0); y++)
    {
      for (int x = maps.GetLength(1) - 1; x > 0; x--)
      {
        int nextX = FindNextRightBlock(y, x - 1);

        if (nextX != -1)
        {
          HandleTwoBlock(y, x, y, nextX);
        }
      }
    }
  }

  private int FindNextRightBlock(int y, int start)
  {
    for (int j = start; j >= 0; j--)
    {
      if (maps[y, j] != null)
      {
        return j;
        break;
      }
    }

    return -1;
  }

  public void ControlUp()
  {

    for (int x = 0; x < maps.GetLength(1); x++)
    {
      for (int y = 0; y < maps.GetLength(0); y++)
      {
        int nextY = FindNextUpBlock(x, y + 1);
        if (nextY != -1)
        {
          HandleTwoBlock(y, x, nextY, x);
        }
      }
    }
  }

  private int FindNextUpBlock(int x, int start)
  {
    for (int j = start; j < maps.GetLength(0); j++)
    {
      if (maps[j, x] != null)
      {
        return j;
        break;
      }
    }

    return -1;
  }

  public void ControlDown()
  {

    for (int x = 0; x < maps.GetLength(1); x++)
    {
      for (int y = maps.GetLength(0) - 1; y > 0; y--)
      {
        int nextY = FindNextDownBlock(x, y - 1);
        if (nextY != -1)
        {
          HandleTwoBlock(y, x, nextY, x);
        }
      }
    }
  }

  private int FindNextDownBlock(int x, int start)
  {
    for (int j = start; j >= 0; j--)
    {
      if (maps[j, x] != null)
      {
        return j;
        break;
      }
    }

    return -1;
  }


  //位置问题
  private void HandleTwoBlock(int y, int x, int nextY, int nextX)
  {
    GameObject cObj = maps[y, x];
    GameObject nObj = maps[nextY, nextX];

    if (cObj == null)
    {
      maps[y, x] = maps[nextY, nextX];
      maps[nextY, nextX] = null;
      SetBlockPosition(maps[y, x], x, y);
    }
    else
    {
      Block cB = cObj.GetComponent<Block>();
      Block nB = nObj.GetComponent<Block>();

      if (cB.Level == nB.Level)
      {
        cB.LevelUp();
        Destroy(nObj);
        maps[nextY, nextX] = null;
      }
    }
  }
}
