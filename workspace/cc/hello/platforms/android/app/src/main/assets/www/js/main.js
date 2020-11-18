const runBallGame = (function () {
  let canvas = null
  let ctx = null

  //所有存在球体的集合
  let balls = []
  let new_ball = null;
  let mousepositions = [];

  //创建球体
  function createBall(x, y) {
    let ball = {
      position: { x, y },
      velocity: { x: 0, y: 0 },
    }

    return ball
  }

  //循环更新
  function update() {
    mousepositions.push(input.mouseposition)
    if (mousepositions.length > 10) {
      mousepositions.shift()
    }

    if (input.mousedown) {
      mousepositions = []
      new_ball = createBall(input.mouseposition.x, input.mouseposition.y)
    }

    if (input.mouseup) {
      if (!!new_ball) {
        let mv = {
          x: input.mouseposition.x - mousepositions[0].x,
          y: input.mouseposition.y - mousepositions[0].y,
        }
        new_ball.velocity.x += mv.x * 0.2
        new_ball.velocity.y += mv.y * 0.2

        balls.push(new_ball)
        new_ball = null
      }
    }

    ctx.save()
    ctx.fillStyle = '#D0104C'
    ctx.fillRect(0, 0, canvas.width, canvas.height)
    ctx.restore()

    if (!!new_ball) {
      nonPhysicUpdate(new_ball)
      draw(new_ball);
    }

    balls.forEach(b => physicsUpdate(b))
    balls.forEach(b => draw(b))
    balls.forEach(b => collide(b))

    input.mousedown = false
  }

  function nonPhysicUpdate(b) {
    b.position = { ...input.mouseposition }
  }

  //物理计算
  function physicsUpdate(b) {
    b.velocity.y += 0.12
    if (b.velocity.y > 12) {
      b.velocity.y = 12
    }
    b.velocity = addFriction(b.velocity)
    b.position.x += b.velocity.x
    b.position.y += b.velocity.y
  }

  //添加摩檫力
  function addFriction(velocity) {
    let d = vectorMult({...velocity}, -1)
    let vn = vectorNormalize(d)
    let f = vectorMult(vn, 0.01)
    return {
      x: velocity.x + f.x,
      y: velocity.y + f.y
    }
  }

  //向量归一
  function vectorNormalize(vector) {
    let total = vector.x * vector.x + vector.y * vector.y
    let n = 1 / Math.sqrt(total)
    return { x: vector.x * n, y: vector.y * n }
  }

  //向量乘法
  function vectorMult(vector, m) {
    return { x: vector.x * m, y: vector.y * m }
  }


  function draw(b) {
    ctx.beginPath();
    ctx.arc(b.position.x, b.position.y, 40, 0, Math.PI * 2)
    ctx.fill()
  }

  //边界碰撞检测处理
  function collide(ball) {
    if (ball.position.x < 0) {
      ball.position.x = 0
      ball.velocity.x *= -1
    }

    if (ball.position.x > canvas.width) {
      ball.position.x = canvas.width
      ball.velocity.x *= -1
    }

    if (ball.position.y > canvas.height) {
      ball.position.y = canvas.height
      ball.velocity.y *= -1
    }
  }

  function resizeWindow(e) {
    canvas.width = window.innerWidth
    canvas.height = window.innerHeight
  }

  return (selector) => {
    canvas = document.querySelector(selector)
    if (canvas == null) {
      console.error('未找到画布元素');
      return
    }

    resizeWindow(canvas)
    window.addEventListener('resize', resizeWindow)
    ctx = canvas.getContext('2d')
    ctx.fillStyle = '#E8B647'

    initInput()
    setInterval(update, 16)
  }
}())