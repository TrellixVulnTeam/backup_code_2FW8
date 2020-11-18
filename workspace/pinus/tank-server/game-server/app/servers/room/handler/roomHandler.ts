import { Application, FrontendSession, ChannelService, Channel } from 'pinus';
import AreaService from '../../../services/AreaService';
import { Action } from "../../../model/Action";
import { Point } from '../../../model/Point';
import { ConsoleModule } from 'pinus/lib/modules/console';
import { make500Error } from '../../../utils/make';

export default function (app: Application) {
    return new Handler(app);
}

export class Handler {
    private channelService: ChannelService;
    private areaServiceMap: Map<string, AreaService>;
    private pos: Point[];

    constructor(private app: Application) {
        this.channelService = app.get("channelService");
        this.areaServiceMap = new Map<string, AreaService>();
        this.pos = [{x: 100, y: 100}, {x: 800, y:200}, {x:100, y: 600}, {x:800, y: 600}]
    }

    /**
     * 用户加入动作
     * @param msg 
     * @param session 
     */
    public async join(msg: any, session: FrontendSession) {
        const rid = session.get('rid');
        const uid = session.uid;
        const sid = session.get('sid');

        const channel = this.channelService.getChannel(rid, true);

        //判断人数是否高于房间上限
        if (channel.userAmount > this.pos.length - 1) {
            return make500Error("user amount max!");
        }

        if (!channel) {
            return make500Error("channel is undefine!")
        }

        channel.add(uid, sid);
        let areaService: AreaService = this.getOrCreateAreaService(rid, channel);

        areaService.addAction({
            type: "joinUser",
            args: [this.pos[channel.userAmount - 1]],
            uid: uid,
        });

        return {
            code: 200,
            data: areaService.getAllFrames(),
            sid: sid
        };
    }

    /**
    * 用户退出动作
    */
   public async leave(msg: any,  session: FrontendSession) {
        const uid = session.uid;
        const rid = session.get('rid');
        const sid = session.get('sid');
        const areaService = this.areaServiceMap.get(rid);
        if (!areaService) {
            return
        }

        areaService.channel.leave(uid, sid);
    }

    /**
     * 客户端上传action
     * 服务端广播该action
     * @param {Action} msg 
     */
    public async action(msg: Action, session: FrontendSession) {
        const uid = session.uid;
        const rid = session.get('rid');
        const areaService = this.areaServiceMap.get(rid);
        if (!areaService) {
            return make500Error()
        }

        areaService.addAction({
            type: msg.type,
            args: msg.args,
            uid: uid
        })
    }

    getOrCreateAreaService(rid: string, channel: Channel) {
        let areaService = this.areaServiceMap.get(rid);
        if (!areaService) {
            areaService = new AreaService(channel);
            this.areaServiceMap.set(rid, areaService);
            areaService.run();
        }
        return areaService;
    }
}
