import { Application, FrontendSession } from 'pinus';

export default function (app: Application) {
    return new Handler(app);
}

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
    async entry(msg: { rid: string, username: string}, session: FrontendSession) {
        let self = this;
        const rid = msg.rid;
        const uid = msg.username + "*" + rid;

        const sessionService = self.app.get("sessionService");

        if (!!sessionService.getByUid(uid)) {
            return {
                code: 500,
                erro: true,
                msg: "use already login!!!"
            };
        }

        await session.abind(uid);
        session.set('rid', rid);
        session.push('rid', err =>  {
            if (err) {
                console.error('set rid for session service failed! error is : %j', err.stack);
            }
        })

        // let users = await self.app.rpc.room.roomRemoter.add.route(session)(uid, self.app.get('serverId'), rid, true);

        return {
            code: 200,
            data: {
                uid: uid
            }
        }
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
        const username = session.uid.split("*")[0];
        return {
            code: 200,
            data: {
                username: username,
                msg: "connector ok!"
            }
        };
    }
}