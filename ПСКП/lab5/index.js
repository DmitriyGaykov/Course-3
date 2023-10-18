import { createServer } from 'http';
import * as fs from 'fs';
import {send} from "m06_gdv";
import {config} from 'dotenv';

config();

const PORT = 5000;

const app = createServer(async (req, res) => {
    const { method, url } = req;

    req.on('data', data => req.body = JSON.parse(data));
    req.on('end', async () => {
        try {
            if(url === '/send') {
                const result = await send('andrysa.shev.133@gmail.com', 'dima.gaykov.04@gmail.com', process.env.PASS, 'Hello mir, manera crutit mir')
                res.end(result.toString());
            }
            if (url === '/api/emails') {
                switch (method) {
                    case 'GET':
                        const file = fs.readFileSync('./views/form.html')
                        res.end(file)
                        break;
                    case 'POST':
                        const body = req.body;

                        if(!body)
                            throw 'No body';

                        const { sender, recipient, message } = body;

                        if(!sender || sender === '')
                            throw 'Provide sender';
                        else if(!recipient || recipient === '')
                            throw 'Provide recipient';
                        else if(!message || message === '')
                            throw 'Provide message';

                        if(true) {
                            const result = await send(recipient, sender, 'rnlajcdowwafibkh', message);

                            res.writeHead(result ? 201 : 400, {
                                'Content-Type': 'text/plain'
                            })
                            res.end(result ? 'Успешно отправлено' : 'Неуспешно!');
                        } else {
                            console.log(req.body)
                            res.writeHead(201, {
                                "Content-Type": "text/plain"
                            });
                            res.end('Success')
                        }
                }
            }
        } catch(e) {
            res.status = 500;
            res.end(e);
        }
    });
});

const start = async () => {
    try {
        await app.listen(PORT);
        console.log('Сервер запущен на порту ', PORT);
    } catch (e) {
        console.log('Сервер не запущен');
    }
}

start();