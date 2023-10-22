import EventEmitter from 'events';
import * as fs from 'fs';
import {createEvent} from "../utils/index.js";

const UploadController = new EventEmitter();

UploadController.on(createEvent('/upload', 'GET'), async (req, res) => {
    const dir = await fs.promises.readdir('./views');
    const file = dir.find(file => file === 'upload-form.html');
    res.writeHead(200, {
        'Content-Type': 'text/html; charset=utf-8'
    });
    res.end(await fs.promises.readFile(`./views/${file}`, 'utf-8'));
});

UploadController.on(createEvent('/upload', 'POST'), async (req, res) => {
    try {
        await fs.writeFileSync('./static/' + req.fileName, req.fileBuffer);
        res.end('Ok');
    } catch (e) {
        res.end('some ok')
    }
})

export const uploadController = UploadController;