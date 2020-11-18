class Timer extends gObject {
  constructor(parent, minsecond, handle = () => {}) {
    super(parent);
    this._isRepeat = true;
    this.minsecond = minsecond;
    this._current = 0;
    this.isComponent = false;
    this._handle = handle;
  }

  update() {
    if (this.isComponent && !this.isRepeat) {
      return;
    }

    this._current += deltaTime;
    if (this._current > this.minsecond) {
      this._handle();
      this._current = 0;
      this.isComponent = true;
    }
  }

  get isRepeat() {
    return this._isRepeat;
  }

  set isRepeat(value) {
    this._isRepeat = value;
    this.isComponent = false;
  }
}