
new Vue({
    el: "#app",
    data: {
        isplay: false,
        mode: null,
        audioRes: [
            ["bee", "bee.wav"],
            ["burn", "burn.mp3"],
            ["chocolate", "chocolate.mp3"],
            ["duck-head", "duck-head.mp3"],
            ["lotus", "lotus.wav"],
            ["rain", "rain.mp3"],
            ["television", "television.mp3"],
            ["zebra", "zebra.mp3"],
            ["piano", "music.mp3"],
            ["thunder", "thunder.wav"],
        ]
    },
    mounted: function () {
        audios = this.$refs.audio
    },
    methods: {
        control() {
            this.isplay = !this.isplay
        },

        play() {
            audios.forEach(audio => {
                audio.playAudio()
            })
        },

        pause() {
            audios.forEach(audio => {
                audio.pauseAudio()
            })
        },

        reset() {
            if (!audios) {
                return
            }

            audios.forEach(audio => {
                audio.reset()
            })
        },

        setMode(mode) {
            if (this.mode == mode) {
                this.mode = null
            } else {
                this.mode = mode
            }
        },

        timerStart(mode) {
            if (mode == 1) {
                this.play()
            }
        },

        timerStop(mode) {
            if (mode == 2) {
                this.play()
            } else {
                this.pause()
            }
        }
    }
})