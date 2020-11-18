import { Channel } from "pinus";
import { Action } from "../model/Action";

/**
 * 房间管理类,维护帧集合
 */
export default class AreaService {
    private frame_list: Action[][];
    private frame_index: number = 0;
    private frame_interval: NodeJS.Timer = null;
    private frame_space: number = 3;
    public channel: Channel = null;

    constructor(channel: Channel) {
        this.channel = channel;
    }

    public run() {
        this.frame_index = 0;
        this.frame_list = [];
        this.frame_interval = setInterval(this.tick.bind(this), 50);
    }

    public stop() {
        clearInterval(this.frame_interval);
    }

    private tick() {
        let frames = [this.getFrameByIndex(this.frame_index)]
        this.channel.pushMessage("onUpdate", {
            code: 200,
            data: frames,
        })

        this.frame_index += this.frame_space;
    }

    getFrameByIndex(index: number) {
        if (this.frame_list[index] == undefined) {
            this.frame_list[index] = []
        }

        return this.frame_list[index]
    }

    public addAction(action: Action): void {
        const frame = this.getFrameByIndex(this.frame_index);
        frame.push(action);
    }

    public getAllFrames() {
        let frames = []
        for (let i: number = 0; i < this.frame_list.length - 1; i += this.frame_space) {
            frames.push(this.getFrameByIndex(i));
        }
        return frames;
    }
}