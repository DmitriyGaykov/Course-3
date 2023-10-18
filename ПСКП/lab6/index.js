import {createServer} from 'http';
import {
    connectionController, filesController,
    formController,
    headersController, jsonController,
    parameterController,
    socketController, uploadController, xmlController
} from "./controllers/index.js";
import {createEvent} from "./utils/index.js";
import {parse} from 'url';
import * as xml2js from 'xml2js';
import formidable from "formidable";
import fs from "fs";

const PORT = 3001;

const app = createServer( async (req, res) => {
    try {
        const form = formidable({multiples: true});
        console.log('before parse')
        const [fields, files] = await form.parse(req);
        console.log('after parse')

        req.on('data', async data => {
            console.log('ondata');

            data = data.toString();

            if (req.headers.hasOwnProperty('content-type') && req.headers['content-type'].includes('application/json')) {
                try {
                    return req.body = JSON.parse(data);
                } catch {

                }
            } else if (req.headers.hasOwnProperty('content-type') && req.headers['content-type'].includes('application/xml')) {
                try {
                    const parser = new xml2js.Parser();
                    const xml = await parser.parseStringPromise(data);
                    return req.body = xml;
                } catch (e) {
                    console.log(e)
                }
            }

            const keyEqValue = data.split('&');
            req.body = {
                ...keyEqValue.reduce((acc, cur) => {
                    const [key, value] = cur.split('=');
                    acc[key] = value;
                    return acc;
                }, {})
            }
        });
        req.on('end', async () => {
            console.log('onend');

            if (req.headers.hasOwnProperty('content-type') && req.headers['content-type'].includes('multipart/form-data') && req.method === 'POST') {
                req.body = fields;
                if (files) {
                    const buffer = await fs.promises.readFile(files?.file?.at(0)?._writeStream?.path);

                    req.fileName = files?.file?.at(0).originalFilename;
                    req.fileBuffer = buffer;
                }
            }

            const {url, method} = req;
            let {pathname, query} = parse(url, true);

            req.query = query;
            req.pathname = pathname;

            if (req.pathname.includes('parameter')) {
                const words = req.pathname.split('/');

                if (words.at(1) === 'parameter' && words.length > 2) {
                    pathname = '/parameter';
                    req.params = {
                        x: words.at(2),
                        y: words.at(3)
                    }
                }
            } else if (req.pathname.includes('files')) {
                const words = req.pathname.split('/');
                if (words.at(1) === 'files' && words.length > 2) {
                    pathname = '/files';
                    req.params = {
                        filename: words.at(2)
                    }
                }
            }

            const event = createEvent(pathname, method);

            connectionController.emit(event, req, res);
            headersController.emit(event, req, res);
            parameterController.emit(event, req, res);
            socketController.emit(event, req, res);
            formController.emit(event, req, res);
            jsonController.emit(event, req, res);
            xmlController.emit(event, req, res);
            filesController.emit(event, req, res);
            uploadController.emit(event, req, res);

            console.log('-----------------------------------');
        })

        console.log('end createServer');
        req.emit('end');
    } catch (e) {
        console.log(e);
    }
});

const start = async () => {
    try {
        await app.listen(PORT);
        console.log(`Server listening on port ${PORT}`);
    } catch (e) {
        console.error(e);
    }
}

start();
export const { address, port } = app.address() || {};