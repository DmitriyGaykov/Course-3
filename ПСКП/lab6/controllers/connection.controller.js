import EventEmitter from 'events';
import {createEvent} from "../utils/index.js";

const ConnectionController = new EventEmitter();
let KeepAliveTimeout = 0;
// 2. При GET-запросе /connection в окно браузера вывести текущее значение параметра KeepAliveTimeout.
// 3. При GET-запросе /connection?set=set установить новое значение системного параметра KeepAliveTimeout = set
// и вывести в окно браузера сообщение, что установлено новое значение параметра KepAliveTimeout=set.
ConnectionController.on(createEvent('/connection', 'GET'), (req, res) => {
    return setTimeout(() => {
        const { set } = req.query;

        if (set) {
            KeepAliveTimeout = isFinite(set) ? Number(set) : KeepAliveTimeout;
            return res.end(`set KeepAliveTimeout=${KeepAliveTimeout}`);
        }

        return res.end(`Current state KeepAliveTimeout=${KeepAliveTimeout}`);
    }, KeepAliveTimeout);
});

export const connectionController = ConnectionController;