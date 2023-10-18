import EventEmitter from 'events';
import {createEvent} from "../utils/index.js";
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';
import * as fs from 'fs';

const FormController = new EventEmitter();

FormController.on(createEvent('/formparameter', 'GET'), async (req, res) => {
    const __filename = fileURLToPath(import.meta.url)
    const file = await fs.readFileSync(join(dirname(__filename),'../views/form.html'), 'utf-8');
    res.end(file);
});

FormController.on(createEvent('/formparameter', 'POST'), async (req, res) => {
    let msg = '';

    const keys = Object.keys(req.body);
    const values = Object.values(req.body);

    for(let i = 0; i < keys.length; i++) {
        msg += `${keys[i]}: ${values[i]}\n`;
    }

    res.end(msg);
})

export const formController = FormController;