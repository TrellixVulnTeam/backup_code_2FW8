class MouseEvent {
  /**
   * 
   * @param {HTMLElement} elem 
   */
  constructor(elem) {
    this.elem = elem
    this.pos = { x: 0, y: 0 }
    this.isMouseDown = false
    this.elem.addEventListener('mousemove', this.mouseMove.bind(this))
    this.elem.addEventListener('mousedown', this.mouseDown.bind(this))
    this.elem.addEventListener('mouseup', this.mouseUp.bind(this))
  }

  mouseDown() {
    this.isMouseDown = true
  }

  mouseUp() {
    this.isMouseDown = false
  }

  mouseMove(e) {
    this.pos = {
      x: e.clientX,
      y: e.clientY
    }
  }
}


class CanvasWork {
  constructor(canvas) {
    this.canvas = canvas
    this.ctx = this.canvas.getContext('2d')
    //绘制层
    this.gs = this.ctx.createImageData(300, 300)
    this.bufferGs = this.ctx.createImageData(300, 300)
    this.startPos = { x: 0, y: 0 }
    this.isDraw = false
    this.mouse = new MouseEvent(this.canvas)
    this.cards = []
    this.id = 0

    this.drawFuncs = {
      'line': this.drawLine.bind(this),
      'rect': this.drawRect.bind(this),
      'eraser': this.eraser.bind(this)
    }

    this.drawFunc = this.drawFuncs['line']
    setInterval(this.update.bind(this), 33)
  }

  update() {
    // this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height)
    this.ctx.putImageData(this.gs, 0, 0)
    if (this.mouse.isMouseDown) {
      if (!this.isDraw) {
        this.isDraw = true
        this.startPos = this.mouse.pos
      } else {
        const { x: x1, y: y1 } = this.startPos
        const { x: x2, y: y2 } = this.mouse.pos
        this.drawFunc && this.drawFunc(x1, y1, x2, y2)
      }
    }
    //绘制状态为真
    else if (this.isDraw) {
      this.isDraw = false
      this.gs = this.bufferGs
    }

    this.bufferGs = this.ctx.getImageData(0, 0, this.canvas.width, this.canvas.height)


    //绘制卡片功能
    this.cards.forEach(({x, y, image}) => {
      this.drawImage(x, y, )
    })
  }

  drawImage(image, x, y) {
    this.ctx.drawImage(image, x, y, 150, 150)
  }

  drawLine(x1, y1, x2, y2) {
    this.ctx.beginPath()
    this.ctx.moveTo(x1, y1)
    this.ctx.lineTo(x2, y2)
    this.ctx.closePath();
    this.ctx.stroke()
  }

  drawRect(x1, y1, x2, y2) {
    this.ctx.strokeRect(x1, y1, x2 - x1, y2 - x1)
  }

  eraser(x1, y1, x2, y2) {
    this.ctx.save()
    this.ctx.fillStyle = 'white'
    this.ctx.strokeStyle = 'white'
    this.ctx.fillRect(x1, y1, x2 - x1, y2 - x1)
    this.ctx.restore()
  }

  setDrawType(type) {
    this.drawFunc = this.drawFuncs[type]
  }

}

export default CanvasWork