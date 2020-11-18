"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const AreaService_1 = require("../../../services/AreaService");
const make_1 = require("../../../utils/make");
function default_1(app) {
    return new Handler(app);
}
exports.default = default_1;
class Handler {
    constructor(app) {
        this.app = app;
        this.channelService = app.get("channelService");
        this.areaServiceMap = new Map();
        this.pos = [{ x: 100, y: 100 }, { x: 800, y: 200 }, { x: 100, y: 600 }, { x: 800, y: 600 }];
    }
    /**
     * 用户加入动作
     * @param msg
     * @param session
     */
    join(msg, session) {
        return __awaiter(this, void 0, void 0, function* () {
            const rid = session.get('rid');
            const uid = session.uid;
            const sid = session.get('sid');
            const channel = this.channelService.getChannel(rid, true);
            //判断人数是否高于房间上限
            if (channel.userAmount > this.pos.length - 1) {
                return make_1.make500Error("user amount max!");
            }
            if (!channel) {
                return make_1.make500Error("channel is undefine!");
            }
            channel.add(uid, sid);
            let areaService = this.getOrCreateAreaService(rid, channel);
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
        });
    }
    /**
    * 用户退出动作
    */
    leave(msg, session) {
        return __awaiter(this, void 0, void 0, function* () {
            const uid = session.uid;
            const rid = session.get('rid');
            const sid = session.get('sid');
            const areaService = this.areaServiceMap.get(rid);
            if (!areaService) {
                return;
            }
            areaService.channel.leave(uid, sid);
        });
    }
    /**
     * 客户端上传action
     * 服务端广播该action
     * @param {Action} msg
     */
    action(msg, session) {
        return __awaiter(this, void 0, void 0, function* () {
            const uid = session.uid;
            const rid = session.get('rid');
            const areaService = this.areaServiceMap.get(rid);
            if (!areaService) {
                return make_1.make500Error();
            }
            areaService.addAction({
                type: msg.type,
                args: msg.args,
                uid: uid
            });
        });
    }
    getOrCreateAreaService(rid, channel) {
        let areaService = this.areaServiceMap.get(rid);
        if (!areaService) {
            areaService = new AreaService_1.default(channel);
            this.areaServiceMap.set(rid, areaService);
            areaService.run();
        }
        return areaService;
    }
}
exports.Handler = Handler;
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoicm9vbUhhbmRsZXIuanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi8uLi8uLi8uLi8uLi9hcHAvc2VydmVycy9yb29tL2hhbmRsZXIvcm9vbUhhbmRsZXIudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6Ijs7Ozs7Ozs7OztBQUNBLCtEQUF3RDtBQUl4RCw4Q0FBbUQ7QUFFbkQsbUJBQXlCLEdBQWdCO0lBQ3JDLE9BQU8sSUFBSSxPQUFPLENBQUMsR0FBRyxDQUFDLENBQUM7QUFDNUIsQ0FBQztBQUZELDRCQUVDO0FBRUQ7SUFLSSxZQUFvQixHQUFnQjtRQUFoQixRQUFHLEdBQUgsR0FBRyxDQUFhO1FBQ2hDLElBQUksQ0FBQyxjQUFjLEdBQUcsR0FBRyxDQUFDLEdBQUcsQ0FBQyxnQkFBZ0IsQ0FBQyxDQUFDO1FBQ2hELElBQUksQ0FBQyxjQUFjLEdBQUcsSUFBSSxHQUFHLEVBQXVCLENBQUM7UUFDckQsSUFBSSxDQUFDLEdBQUcsR0FBRyxDQUFDLEVBQUMsQ0FBQyxFQUFFLEdBQUcsRUFBRSxDQUFDLEVBQUUsR0FBRyxFQUFDLEVBQUUsRUFBQyxDQUFDLEVBQUUsR0FBRyxFQUFFLENBQUMsRUFBQyxHQUFHLEVBQUMsRUFBRSxFQUFDLENBQUMsRUFBQyxHQUFHLEVBQUUsQ0FBQyxFQUFFLEdBQUcsRUFBQyxFQUFFLEVBQUMsQ0FBQyxFQUFDLEdBQUcsRUFBRSxDQUFDLEVBQUUsR0FBRyxFQUFDLENBQUMsQ0FBQTtJQUNwRixDQUFDO0lBRUQ7Ozs7T0FJRztJQUNVLElBQUksQ0FBQyxHQUFRLEVBQUUsT0FBd0I7O1lBQ2hELE1BQU0sR0FBRyxHQUFHLE9BQU8sQ0FBQyxHQUFHLENBQUMsS0FBSyxDQUFDLENBQUM7WUFDL0IsTUFBTSxHQUFHLEdBQUcsT0FBTyxDQUFDLEdBQUcsQ0FBQztZQUN4QixNQUFNLEdBQUcsR0FBRyxPQUFPLENBQUMsR0FBRyxDQUFDLEtBQUssQ0FBQyxDQUFDO1lBRS9CLE1BQU0sT0FBTyxHQUFHLElBQUksQ0FBQyxjQUFj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