using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class NpcTalkManager : MonoBehaviour
{
  [SerializeField]

  public GameObject Dialog;
  [SerializeField]
  private RectTransform talk;

  [SerializeField]
  private Text text;

  private Queue<string> queue;

  private bool IsRunText;
  private bool IsShowDialog {
      get {
          return Dialog.activeSelf;
      }

      set {
          Dialog.SetActive(value);
      }
  }

  // Start is called before the first frame update
  void Start()
  {
    queue = new Queue<string>();
    IsShowDialog = false;
    IsRunText = false;
  }

  // Update is called once per frame
  void Update()
  {

    if (IsShowDialog == true)
    {
      if (!IsRunText && Input.GetKeyDown(KeyCode.Space))
      {
          NextDialog();
      }
      return;
    }

    Vector2 mouseInWorld = Camera.main.ScreenToWorldPoint(Input.mousePosition);

    RaycastHit2D hit = Physics2D.Raycast(mouseInWorld, Vector2.zero);

    if (hit.collider != null)
    {
      TalkEnable = true;
    }
    else if (TalkEnable != false)
    {
      TalkEnable = false;
    }

    if (Input.GetMouseButtonDown(0) && hit.collider != null)
    {
      Talk talk = hit.collider.gameObject.GetComponent<Talk>();
      if (talk != null)
      {
        string[] talks = talk.Talks;
        StartDialog(talks);
      }
    }
  }

  private bool TalkEnable
  {
    get
    {
      return this.talk.gameObject.active;
    }

    set
    {
      this.talk.gameObject.active = value;
      Cursor.visible = !value;
      this.talk.position = Input.mousePosition;
    }
  }

  private void StartDialog(string[] talks)
  {
    IsShowDialog = true;
    queue.Clear();
    for (int i = 0; i < talks.Length; i++)
    {
      queue.Enqueue(talks[i]);
    }

    NextDialog();
  }

  void NextDialog()
  {
    if (queue.Count > 0) {
        StartCoroutine(RunText(queue.Dequeue()));
    } else {
        IsShowDialog = false;
    }
  }

  IEnumerator RunText(string t) {
      IsRunText = true;
      text.text = "";
      Debug.Log(t);
      for (int i = 0; i < t.Length; i++) {
          text.text += t[i];
          yield return new WaitForSeconds(0.1f);
      }

      IsRunText = false;
  }

}
