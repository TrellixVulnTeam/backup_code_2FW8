import {Bodies} from "matter-js"
import Actor from "../controller/Actor";
export default class Wall extends Actor {

    constructor() {
        super()
        this.body = new Bodies.rectangle(0, 0, 1280, 720, {
            isStatic: true
        })
    }
}