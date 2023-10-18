import EventEmitter from 'events';
import {createEvent} from "../utils/index.js";
import {address, port} from "../index.js";

const SocketController = new EventEmitter();

SocketController.on(createEvent('/socket', 'GET'), (req, res) => {
    const { remoteAddress, remotePort } = req.socket;
    res.end(`remoteAddress: ${remoteAddress}\nremotePort: ${remotePort}\nlocalAddress: ${address}\nlocalPort: ${port}`);
});

SocketController.on(createEvent('/resp-status', 'GET'), (req, res) => {
    // Задание 06 resp-status?code=c&mess=m
    //     14. При получении этого запроса, сформируйте ответ, имеющий статус, заданный значением с, и
    //     пояснение к статусу, заданное значением m.

    const { code, mess } = req.query;
    const status = isFinite(code) ? Number(code) : 200;
    const message = mess || 'OK';
    res.writeHead(status, message).end();
});

export const socketController = SocketController;