Vue.component('mixin-audio', {
    template: `
        <div class="outer-box">
            <div class="inner-box">
                <img class="image" :src="imgSrc" />
                <h3>{{aname}}</h3>
                <input class="range"  v-model="volume" max="1.0" step="0.2" type="range" />
                <audio ref="audio" :src="source" loop/>
            </div>
        </div>
    `,
    props: {
        aname: {
            type: String,
            required: true
        },
        source: {
            type: String,
            required: true
        },
        isplay: {
            type: Boolean,
            default: true
        }
    },
    data: function () {
        return {
            volume: 0,
            audio: null,
        }
    },
    mounted: function () {
        this.audio = this.$refs.audio
        this.audio.volume = 0
    },
    methods: {
        playAudio() {
            this.audio.play()
        },

        pauseAudio() {
            this.audio.pause()
        },

        reset() {
            this.volume = 0
            this.pauseAudio()
        }
    },
    computed: {
        imgSrc: function () {
            return "./img/" + this.aname + ".png"
        },
    },
    watch: {
        volume(val) {
            this.audio.volume = val
            this.isplay && this.playAudio()
        },
        isplay(val) {
            if (val) {
                this.playAudio()
            } else {
                this.pauseAudio()
            }
        }
    }
})

Vue.component('Timers', {
    template: `
    <div class="panel">

        <template v-if="count <= 0">
            <div class="panel-row">
                <button :class="['marge', 'none-border-btn', {focus: mode == 1}]" @click=setMode(1)>Stop playing after</button>
                <button :class="['marge', 'none-border-btn', {focus: mode == 2}]" @click=setMode(2)>Start playing after</button>
            </div>
            <div class="panel-row panel-center">
                <input class="num-input" type="number" v-model="hour" />
                hours and
                <input class="num-input" type="number" v-model="minute" />
                minutes
            </div>
            <div class="panel-row space panel-footer">
                <button class="btn" @click="close">
                    Cancel
                </button>
                <button class="btn" @click="start">
                    Start Timer
                </button>
            </div>
        </template>
        
        <template v-else>
            <div class="panel-row-2 center" @click="close">
                <strong>Sounds will stop in</strong>
                <p class="timer">{{time}}</p>
            </div>
            <div class="panel-row space panel-footer">
                <button class="btn">
                    Close
                </button>
                <button class="btn" @click="stop">
                    Stop Timer
                </button>
            </div>
        </template>

    </div>
    `,
    data: function () {
        return {
            count: 0,
            hour: 0,
            minute: 0,
            mode: 1,
        }
    },
    methods: {
        //向外部发出计时器开始事件
        start() {
            this.count = this.hour * 3600 + this.minute * 60
            this.$emit('start', this.mode)
            this.tick()
        },

        tick() {
            if (this.count <= 0) {
                this.$emit("stop", this.mode)
                return
            }
            this.count--;
            setTimeout(this.tick.bind(this), 1000);
            this.$emit("tick", this.mode)
        },

        stop() {
            this.count = 0;
            this.$emit("stop", this.mode)
        },

        setMode(mode) {
            this.mode = mode
        },

        close() {
            this.$emit("close")
        }
    },
    computed: {
        time() {
            return timeFormat(this.count)
        }
    }
})

Vue.component('Mixes', {
    template: `
    <div class="panel ex">
        <div class="panel-row item-form">
            <input placeholder="New mix name" type="text" v-model="newName" />
            <button class="btn" @click="save">Save</button>
        </div>
        <div class="panel-row-2 items">
            <div class="item" v-show="mixess" v-for="(key, index) of mixess" :key="index">
                <button class="none-border-btn name" @click="setting(key)">
                    {{key}}
                </button>
                <button class="none-border-btn" @click="remove(index)">
                    X
                </button>
            </div>
        </div>
        <div class="panel-row space panel-footer">
            <button class="btn">Close</button>
            <button class="btn">Random Mix</button>
        </div>
    </div>
    `,
    data: function () {
        return {
            mixess: [],
            newName: "",
        }
    },
    mounted: function () {
        //从localStorage中读取
        let mixess_json = localStorage.getItem("mixess")
        if (mixess_json) {
            //数组,保存了各个建值
            this.mixess = JSON.parse(mixess_json)
        }
    },
    methods: {
        save() {
            if (this.newName.length <= 0) return
            let vs = audios.map(audio => {
                return audio.volume
            })
            this.mixess.push(this.newName)
            localStorage.setItem("mixess", JSON.stringify(this.mixess))
            localStorage.setItem(this.newName, JSON.stringify(vs))
        },

        remove(index) {
            let delKey = this.mixess[index]
            if (!delKey) return;
            this.mixess.splice(index, 1)
            localStorage.setItem("mixess", JSON.stringify(this.mixess))
            localStorage.removeItem(delKey)
        },

        setting(mixesName) {
            let mixes = localStorage.getItem(mixesName)
            if (!mixes) {
                return;
            }

            mixes = JSON.parse(mixes)
            audios.forEach((audio,index) => {
                audio.volume = mixes[index] || 0;
            })
        }
    }
})
