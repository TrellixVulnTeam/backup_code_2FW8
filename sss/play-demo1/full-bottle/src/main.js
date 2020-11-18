import p5 from "@cmu-eberly-center/p5"
import p5play from "@cmu-eberly-center/p5.play"

import { Game, gObject } from "./core/index"
import AnimationManager from "./utils/AnimationManager";
import camera from "./core/camera";
import Keyword from "./inputs/keyword";
import Mouse from "./inputs/mouse";
import Options from "./utils/Options";

const p5Instance = (gameData) => (c) => {

  const { options } = gameData
  const { background = "#ffffff" } = options
  Options.load(options)
  const game = new Game(gameData)
  c.preload = () => {
    const { animations, cameraOptions = {} } = gameData

    gObject.paint = c
    AnimationManager.init(c)
    Keyword.init(c)
    Mouse.init(c)
    camera.init(c, cameraOptions)

    for (let animName in animations) {
      const animation = animations[animName]
      AnimationManager.load(animName, animation)
    }
  }

  c.setup = () => {
    c.createCanvas(Options['width'], Options['height'])
    game.start();
    camera.on();
  }

  c.draw = () => {
    c.background(Options['background'])
    Keyword.keyIsDown()
    Mouse.update()
    game.update()
    game.draw(c)
  }

  c.keyPressed = Keyword.keyPressed
  c.keyReleased = Keyword.keyReleased

  c.mousePressed = Mouse.mousePressed
  c.mouseReleased = Mouse.mouseReleased
}

/**
 * @param {Object} data
 * @param {Function} callback
 */
export default function runGame(gameData) {
  const { defaultScene = "default", scenes = [] } = gameData;
  if (scenes[defaultScene] == null) return;

  new p5(p5Instance(gameData));
}

window.runGame = runGame;
window.camera = camera;
window.Mouse = Mouse;
window.Keyword = Keyword;