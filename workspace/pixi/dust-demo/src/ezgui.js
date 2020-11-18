import { Application } from "pixi.js"
// ES6:
import * as dat from 'dat.gui';

const gui = new dat.GUI();
var FizzyText = function () {
    this.message = 'dat.gui';
    this.speed = 0.8;
    this.displayOutline = false;
    // Define render logic ...
};

var text = new FizzyText();
gui.add(text, 'message');
gui.add(text, 'message');
gui.add(text, 'speed', -5, 5);
gui.add(text, 'displayOutline');
