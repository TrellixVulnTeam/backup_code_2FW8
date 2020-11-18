function clamp(v, min, max) {
  return v < min ? min : v > max ? max : v;
}

//实例化对象
//每一个创建的对象都会是一个工厂函数
//调用该函数即可返回一个对象
function Initialize(objFactory, args = []) {
  return objFactory(...args);
}

//函数节流
function throttle(func, minsecond) {
  let flag = true;

  return function() {
    if (flag) {
      func();
      flag = false;
      setTimeout(() => {
        flag = true
      }, minsecond);
    }
  }
}
