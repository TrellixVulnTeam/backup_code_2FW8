import AreaService from "./AreaService";
import { Channel } from "pinus";

export default class AreaServiceManager {
    private areaServiceMap: Map<string, AreaService>;

    constructor() {
        this.areaServiceMap = new Map<string, AreaService>();
    }

    add(key:string, channel: Channel) {
        let areaService  = new AreaService(channel);
        return areaService;
    }

    get(key: string) {
        return this.areaServiceMap.get(key);
    }

}