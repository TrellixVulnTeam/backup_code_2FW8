class GameManager {
  private static _instance = null
  private username: string = ""
  static get Instance() {
    if (GameManager._instance === null) {
      GameManager._instance = new GameManager()
    }
    return GameManager._instance
  }
}