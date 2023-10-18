import EventEmitter from 'events';
import {createEvent} from "../utils/index.js";

const HeadersController = new EventEmitter();

HeadersController.on(createEvent('/headers', 'GET'), (req, res) => {
    const { headers } = req;
    const keys = Object.keys(headers);
    const values = Object.values(headers);

    let resp = "";

    for(let i = 0; i < keys.length; i++) {
        resp += `${keys[i]}: ${values[i]}\n`;
    }

    res.end(resp);
})

export const headersController = HeadersController;