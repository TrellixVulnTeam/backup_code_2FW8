export default (function () {
  let p5 = null;
  const animations = new Map();

  const load = (name, animData) => {
    const { frames = [], frameDelay = 4 } = animData;
    const anim = p5.loadAnimation(...frames);
    anim.frameDelay = frameDelay;
    animations.set(name, anim);
  }

  const get = (name) => {
    return animations.get(name);
  }

  const init = (p5Ins) => {
    p5 = p5Ins;
  }

  return {
    load,
    get,
    init,
  }
})();