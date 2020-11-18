import { Sprite, Texture, BaseTexture } from "pixi.js";

const default_style = {
    fontSize: '25px',
    width: '250px',
    color: '#666',
    border: 'none',
    backgroundColor: "transparent"
}

const default_border_style = {
    default: { fill: 0x000000, rounded: 16, stroke: { color: 0xCBCEE0, width: 4 } },
    focused: { fill: 0x000000, rounded: 16, stroke: { color: 0xABAFC6, width: 4 } },
    disabled: { fill: 0x000000, rounded: 16 }
}

export function createBox(img, placeholder = "", style = {}, border_style = {}) {
    Object.assign(style, default_style)
    Object.assign(border_style, default_border_style)

    const box = new Sprite(Texture.from(BaseTexture.from(img)));
    const box_input = new PIXI.TextInput(style, border_style);
    box_input.position.set(15, 50);
    box_input.placeholder = placeholder
    Object.defineProperty(box, "text", {
        get: function() {
            return box_input.text
        }
    })

    box.addChild(box_input)
    return box
}