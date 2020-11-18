import { pinus } from 'pinus';
import { preload } from './preload';
import * as  routeUtil from './app/util/routeUtil';
/**
 *  替换全局Promise
 *  自动解析sourcemap
 *  捕获全局错误
 */
preload();

/**
 * Init app for client.
 */
let app = pinus.createApp();
app.set('name', 'demo1');

// app configuration
app.configure('production|development', 'connector', function () {
    app.set('connectorConfig',
        {
            connector: pinus.connectors.hybridconnector,
            heartbeat: 3,
            useDict: true,
            useProtobuf: true
        });

    // app.route('chat', routeUtil.chat);
    
});

// start app
app.start();

