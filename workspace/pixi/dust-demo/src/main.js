import { Application, loader, particles, Sprite, Container, Rectangle } from 'pixi.js'
import * as Particles from "pixi-particles"
const app = new Application()

document.body.appendChild(app.view)

// Start the update
update();