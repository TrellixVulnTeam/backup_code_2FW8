var Swiper = (function() {

    function Swiper(id, delta = 1000) {
        this.nowIndex = 0;
        this.timer = 0;
        this.delta = delta;

        this.swiperRoot = document.querySelector(id);
        this.swiperNode = this.swiperRoot.querySelector("ul");

        this.swiperNode.appendChild(this.swiperNode.children[0].cloneNode(true));
        this.swiperList = this.swiperNode.children;
        this.swiperNode.style.left = `-${this.nowIndex}%`;
    }

    Swiper.prototype.stop = function () {
        clearInterval(this.timer);
    };

    Swiper.prototype.run = function (delta) {
        this.timer = setTimeout(this.next.bind(this), delta || this.delta);
    };
    var s = null;
    Swiper.prototype.next = function () {
        this.nowIndex += 1;
        if (this.nowIndex >= this.swiperList.length) {
            s = this.swiperNode.style.transition;
            this.swiperNode.style.transition = "none";
            this.swiperNode.style.left = "0";
            this.nowIndex = 0;
            this.run(1);
        } else {
            if (s !== null && this.swiperNode.style.transition !== s) {
                this.swiperNode.style.transition = s;
            }
            this.swiperNode.style.left = `-${this.nowIndex * 100}%`;
            this.run();
        }
    };

    return Swiper;
})();
