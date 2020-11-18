import View from "./View";
import BgMap from '../fly/BgMap'
import Player from "../fly/Player";
import Enemy from "../fly/Enemy";

export default class Main extends View {
    init() {
        // let bg = new Image("image/bg.jpg")
        // this.addChild(bg)
        this.addChild(new BgMap())
        this.addChild(new Player(100, 200))
        this.enemyManager = new EnemyManager(this)
    }
}

class EnemyManager {
    constructor(view) {
        //敌人要生成的场景
        this.view = view
        this.enemyInfo = [
            {img: "enemy_01.png", speed: 2},
            {img: "enemy_02.png", speed: 2},
            {img: "enemy_03.png", speed: 3},
            {img: "enemy_04.png", speed: 3},
        ]

        app.ticker.add(this.onCreate.bind(this))
    }

    createEnemy(x, y, img_src, speed) {
        const enemy = new Enemy(x, y, img_src, speed)
        return enemy
    }

    onCreate() {
        if (Math.random() < 0.03) {
            this.generator()
            this.generator()
        }
    }

    generator() {
        const x = Math.random() * this.view.width
        const y = -100
        const index = Math.floor(Math.random() * this.enemyInfo.length)
        const currEnemyInfo = this.enemyInfo[index]

        const enemy = this.createEnemy(x, y, currEnemyInfo.img, currEnemyInfo.speed)
        this.view.addChild(enemy)
    }
}
