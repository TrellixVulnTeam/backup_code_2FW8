/**
 * 为Sprite添加的碰撞组件
 * @param {Sprite} sprite
 * @param {Number} x 
 * @param {Number} y 
 * @param {Number} r 
 */
export default function Collision(sprite, options) {
    options = options || {}
    const centerX = 0
    const centerY = 0
    const r = sprite.width > sprite.height ? sprite.height : sprite.width
    sprite.isCollision = true

    sprite.collision = {
        r: r
    }

    sprite.collisionTypes =  options['collisionTypes'] || []
}