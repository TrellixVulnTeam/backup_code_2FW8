import React, { useRef, useEffect, useState } from 'react'
import CanvasWork from './CanvasWork'


export default function Board({ drawType = 'line', cards = [] }) {
  const canvas = useRef(null)

  const [cw, setCw] = useState(null)

  useEffect(() => {
    if (canvas && canvas.current) {
      const c = new CanvasWork(canvas.current)
      setCw(c)
    }
  }, [canvas])

  if (!!cw) {
    cw.setDrawType(drawType)
    if (cards instanceof Array) {
      cw.cards = cards
    }
  }

  return (
    <div>
      <canvas ref={canvas} width={800} height={600}></canvas>
    </div>
  )
}