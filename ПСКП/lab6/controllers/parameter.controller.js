import EventEmitter from 'events';
import {createEvent} from "../utils/index.js";

const ParameterController = new EventEmitter();

ParameterController.on(createEvent('/parameter', 'GET'), (req, res) => {
    if(req.params !== undefined && req.params !== null) {
        return ParameterController.emit('/parameter/:x/:y', req, res);
    }

    try {
        let {x, y} = req.query;

        if(!isFinite(x))
            throw 'x is not a number';
        else if(!isFinite(y))
            throw 'y is not a number';

        x = Number(x);
        y = Number(y);

        const result = `
        x + y = ${x + y}
        x - y = ${x - y}
        x * y = ${x * y}
        x / y = ${x / y}
        `
        return res.end(result);
    } catch (e) {
        return req.params === null ? res.end(req.url) : res.end(`Error: ${e}`);
    }
});

ParameterController.on('/parameter/:x/:y', (req, res) => {
    const { x, y } = req.params;

    req.params = null;
    req.query = {
        x,
        y
    };

    return ParameterController.emit(createEvent('/parameter', 'GET'), req, res);
})

export const parameterController = ParameterController;