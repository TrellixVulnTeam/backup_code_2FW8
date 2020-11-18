using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
  Animator animator;
  Rigidbody2D rigidbody;
  Vector2 currDirs = Vector2.zero;
  void Start()
  {
    animator = GetComponent<Animator>();
    rigidbody = GetComponent<Rigidbody2D>();
  }

  void Update()
  {
    if (Input.GetMouseButton(0))
    {
      float angle = HandleMouse();
      currDirs = HandleAngle(angle);
      Debug.Log(currDirs.x.ToString() + ", " + currDirs.y.ToString());
      ChangeAnimator(currDirs);
    } else {
      currDirs.x = 0;
      currDirs.y = 0;
    }
  }

  float HandleMouse()
  {
    Vector3 playerScreenPosition = Camera.main.WorldToScreenPoint(transform.position);
    // 相对于角色的差值坐标,即以角色为原点
    Vector3 delta = Input.mousePosition - playerScreenPosition;
    // Debug.Log(playerScreenPosition);
    // Debug.Log(Input.mousePosition);
    // Debug.Log(delta);
    // Debug.Log("##########");

    //求斜边长度
    float r = Mathf.Sqrt(delta.x * delta.x + delta.y * delta.y);

    //利用反三角函数将斜率转化为角度
    float angle = Mathf.Acos(delta.x / r) * Mathf.Rad2Deg;

    if (delta.y < 0)
    {
      angle = 360 - angle;
    }

    return angle;
  }

  Vector2 HandleAngle(float angle)
  {
    int dir = Mathf.FloorToInt((angle + 45) % 360 / 90);
    Vector2 dirs = new Vector2();
    if (dir == 0)
    {
      dirs.x = 1;
      dirs.y = 0;
    }
    else if (dir == 1)
    {
      dirs.x = 0;
      dirs.y = 1;
    }
    else if (dir == 2)
    {
      dirs.x = -1;
      dirs.y = 0;
    }
    else if (dir == 3)
    {
      dirs.x = 0;
      dirs.y = -1;
    }

    return dirs;
  }

  void ChangeAnimator(Vector2 dirs)
  {
    animator.SetFloat("MoveX", dirs.x);
    animator.SetFloat("MoveY", dirs.y);
  }

  private void FixedUpdate()
  {
    if (currDirs.x == 0 && currDirs.y == 0)
    {
      return;
    }

    Vector2 newPosition = new Vector2(rigidbody.position.x, rigidbody.position.y) + currDirs * 4 * Time.fixedDeltaTime;
    Debug.Log("移动了" + newPosition.x.ToString() + " , " + newPosition.y.ToString());
    rigidbody.MovePosition(newPosition);
  }


}
