import {Sprite, loader} from "pixi.js"


export class Image extends Sprite {
    constructor(src)  {
        super(loader.resources[src].texture)
    }
}