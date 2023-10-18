import EventEmitter from 'events';
import {createEvent} from "../utils/index.js";

const XmlController = new EventEmitter();

XmlController.on(createEvent('/xml', 'POST'), (req, res) => {
    if(!req.body)
        res.end('No body');

    console.log(req.body.request.x.at(0))

    const msg = req.body.request;

    const answer = {
        sum: {
            result: 0
        },
        concat: {
            result: ''
        }
    };

    if(msg.x) {
        answer.sum.result = msg.x.reduce((acc, val) => acc + Number(val['$'].value), 0);
    }

    if(msg.m) {
        answer.concat.result = msg.m.reduce((acc, val) => acc + val['$'].value, '');
    }
    res.end(`
    <response id="${Math.floor(Math.random() * 30)}" request="${msg['$']?.id}">
        <sum element="x" result="${answer.sum.result}"/>
        <concat element="m" result="${answer.concat.result}"/>
    </response>
    `);
});

export const xmlController = XmlController;