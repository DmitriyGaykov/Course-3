import EventEmitter  from 'events';
import {createEvent} from "../utils/index.js";
import * as fs from 'fs';

const FilesController = new EventEmitter();

FilesController.on(createEvent('/files', 'GET'), async (req, res) => {
    // 28. В ответ на запрос высылается ответ с заголовком X-static-files-count: n,
    // где n - количество файлов в директории static. Используйте функции модуля fs.

    if(req.params) {
        return FilesController.emit('/files/:filename', req, res);
    }

    const files = await fs.promises.readdir('./static');
    res.writeHead(200, {
        'X-static-files-count': files.length
    }).end();
});

FilesController.on('/files/:filename', async (req, res) => {
    // 29. В ответ на запрос высылается содержимое файла, имя которого задано в параметре запроса filename.
    // Если такого файла нет, то сервер высылает ответ с кодом 404.

    const { filename } = req.params;
    const files = await fs.promises.readdir('./static');
    const file = files.find(file => file === filename);

    if(file) {
        const content = await fs.promises.readFile(`./static/${file}`);
        res.writeHead(200, {
            'Content-Type': 'text/plain; charset=utf-8'
        }).end(content);
    } else {
        res.writeHead(404).end();
    }
})

export const filesController = FilesController;