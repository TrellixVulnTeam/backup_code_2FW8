import * as Matter from 'matter-js'
import { Application, Graphics } from 'pixi.js';
// module aliases
var Engine = Matter.Engine,
    Render = Matter.Render,
    World = Matter.World,
    Bodies = Matter.Bodies;

// create an engine
var engine = Engine.create();

// create two boxes and a ground
var boxA = Bodies.rectangle(400, 200, 80, 80);
var boxB = Bodies.rectangle(450, 50, 80, 80);
var ground = Bodies.rectangle(300, 400, 810, 60, { isStatic: true });

// add all of the bodies to the world
World.add(engine.world, [boxA, boxB, ground]);

// run the engine
Engine.run(engine);

const app = new Application()
document.body.appendChild(app.view)
app.renderer.backgroundColor = 0xff0000;
/**
 * 
 * @param {Matter.Body} body 
 */
function createBox(body, x, y, width, height) {
    const box = new Graphics()
    box.position.set(x, y)
    box.beginFill()
    box.drawRect(0, 0, width, height)
    box.endFill()
    app.ticker.add(() => {
        box.position.set(
            body.position.x,
            body.position.y,
        )
    })
    return box
}

const sboxA = createBox(boxA, 400, 200, 80, 80)
const sboxB = createBox(boxB, 450, 50, 80, 80)

app.stage.addChild(sboxA)
app.stage.addChild(sboxB)