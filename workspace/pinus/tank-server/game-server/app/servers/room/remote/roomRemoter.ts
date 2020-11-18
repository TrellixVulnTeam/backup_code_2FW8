import {Application, RemoterClass, FrontendSession, ChannelService, Channel} from 'pinus';
import AreaService from '../../../services/AreaService';


export default function (app: Application) {
    return new RoomRemoter(app);
}

declare global {
    interface UserRpc {
        room: {
            // 一次性定义一个类自动合并到UserRpc中
            roomRemoter: RemoterClass<FrontendSession, RoomRemoter>;
        };
    }
}

export class RoomRemoter {
    private channelService: ChannelService;
    private areaServiceMap: Map<String, AreaService>;

    constructor(private app: Application) {
        this.channelService = app.get('channelService');
        this.areaServiceMap = app.get("areaServiceMap");
    }

    public get(name: string) {
        let users: string[];
        const channel = this.channelService.getChannel(name, false);
        if (!!channel) {
            users = channel.getMembers();
        }

        for (let i = 0; i < users.length; i++) {
            users[i] = users[i].split('*')[0];
        }

        return users
    }
}