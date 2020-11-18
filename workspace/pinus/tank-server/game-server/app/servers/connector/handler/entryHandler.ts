import { Application, FrontendSession } from 'pinus';

export default function (app: Application) {
    return new Handler(app);
}

/**
 * 帧同步模式,客户端发起notify通知,服务器对应的房间的下一个tick中转发这个notify
 */
export class Handler {
    
    constructor(private app: Application) {

    }

    /**
     * New client entry.
     *
     * @param  {Object}   msg     request message
     * @param  {Object}   session current session object
     * @param  {Function} next    next step callback
     * @return {Void}
     */
    async entry(msg: { username: string, rid: string }, session: FrontendSession) {
        const self = this;
        const rid = msg.rid;
        const uid = msg.username + "*" + rid;
        const sessionService = self.app.get('sessionService');
        if (!!sessionService.getByUid(uid)) {
            return {
                code: 500,
                msg: "already login!",
                uid: uid,
            };
        }

        await session.abind(uid);

        session.set('rid', rid);
        session.set('sid', self.app.get('serverId'));
        session.pushAll(() => {});
        return {
            code: 200,
            data: {
                uid: uid
            }
        };
    }

    private get(name: string, flag: boolean) {
        let users: string[] = [];
    }

    /**
     * Publish route for mqtt connector.
     *
     * @param  {Object}   msg     request message
     * @param  {Object}   session current session object
     * @param  {Function} next    next step callback
     * @return {Void}
     */
    async publish(msg: any, session: FrontendSession) {
        let result = {
            topic: 'publish',
            payload: JSON.stringify({ code: 200, msg: 'publish message is ok.' })
        };
        return result;
    }

    /**
     * Subscribe route for mqtt connector.
     *
     * @param  {Object}   msg     request message
     * @param  {Object}   session current session object
     * @param  {Function} next    next step callback
     * @return {Void}
     */
    async subscribe(msg: any, session: FrontendSession) {
        let result = {
            topic: 'subscribe',
            payload: JSON.stringify({ code: 200, msg: 'subscribe message is ok.' })
        };
        return result;
    }

}