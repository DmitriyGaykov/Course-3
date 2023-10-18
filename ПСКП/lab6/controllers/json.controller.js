import EventEmitter from 'events';
import {createEvent} from "../utils/index.js";

const JsonController = new EventEmitter();

JsonController.on(createEvent('/json', 'POST'), (req, res) => {
    if(!req.body)
        res.end('No body');

    const msg = req.body;
    const answer = {};

    if(msg.__comment) {
        answer.__comment = msg.__comment.replace('Запрос', 'Ответ');
    }

    if(msg.x && msg.y) {
        answer.x_plus_y = msg.x + msg.y;
    }

    if(msg.s && msg.o) {
        answer.Concatenation_s_o = msg.s + ': ' + Object.values(msg.o).join(', ');
    }

    if(msg.m) {
        answer.Length_m = msg.m.length;
    }

    res.end(JSON.stringify(answer));
})

export const jsonController = JsonController;