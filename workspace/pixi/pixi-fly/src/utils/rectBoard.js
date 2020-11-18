export default (function() {
    
    function rectBoard(sprite) {
        const width = app.r.width
        const height = app.r.height
        if (sprite.x < 0) sprite.x = 0
        if (sprite.x > width) sprite.x = width
        if (sprite.y < 0) sprite.y = 0
        if (sprite.y > height) sprite.y = height
     }

     return rectBoard
}())
    