using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GridShows : MonoBehaviour
{
  public GameObject gridPrefab;
  public float gridSize;
  // Start is called before the first frame update
  void Start()
  {
    for (int y = 0; y < 4; y++)
    {
      for (int x = 0; x < 4; x++)
      {
        AddGrid(y, x);
      }
    }
  }

  private void AddGrid(int rowIndex, int colIndex)
  {
    GameObject block = Instantiate(gridPrefab);
    block.transform.position = transform.position + new Vector3(
        rowIndex * gridSize,
          -colIndex * gridSize,
          0);
  }
}
