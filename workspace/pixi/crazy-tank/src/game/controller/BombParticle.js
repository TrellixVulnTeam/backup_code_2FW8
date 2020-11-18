import * as Particles from "pixi-particles"
import { Texture, Container } from "pixi.js";


/**
 * 
 * @param {Container} container 
 * @param {Object} options 
 */
function createEmitter(container, options) {
    const img_name = options['image']
    const emitter = new Particles.Emitter(container, Texture.fromImage(img_name), options)

    let elapsed = Date.now();
    let update = () => {

        // Update the next frame
        requestAnimationFrame(update);    
        var now = Date.now();

        // The emitter requires the elapsed
        // number of seconds since the last update
       
        emitter.update((now - elapsed) * 0.001);
        elapsed = now;
    
        // Should re-render the PIXI Stage
        // renderer.render(stage);
    };
    update()
    return emitter
}

// const particles_json = require("../config/particles.json")

export default class BombParticle extends Container {
    constructor() {
        super()
        this._emitter = createEmitter(this, {
                "image": "images/particle.png",
                "alpha": {
                    "start": 0.74,
                    "end": 0
                },
                "scale": {
                    "start": 5,
                    "end": 1.2
                },
                "color": {
                    "start": "ffdfa0",
                    "end": "100f0c"
                },
                "speed": {
                    "start": 200,
                    "end": 0
                },
                "startRotation": {
                    "min": 0,
                    "max": 360
                },
                "rotationSpeed": {
                    "min": 0,
                    "max": 200
                },
                "lifetime": {
                    "min": 0.5,
                    "max": 1
                },
                "blendMode": "normal",
                "ease": [
                    {
                        "s": 0,
                        "cp": 0.329,
                        "e": 0.548
                    },
                    {
                        "s": 0.548,
                        "cp": 0.767,
                        "e": 0.876
                    },
                    {
                        "s": 0.876,
                        "cp": 0.985,
                        "e": 1
                    }
                ],
                "frequency": 0.001,
                "emitterLifetime": 0.1,
                "maxParticles": 100,
                "pos": {
                    "x": 0,
                    "y": 0
                },
                "addAtBack": true,
                "spawnType": "point"
            }
        )
    }

    run(callback) {
        this._emitter.playOnceAndDestroy(callback)
    }

    setPosition(x, y) {
        this._emitter.updateOwnerPos(x, y)
    }
}