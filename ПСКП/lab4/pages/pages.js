import EventEmitter from 'events'
import * as fs from 'fs'
import { join, dirname } from 'path'
import { fileURLToPath } from 'url'

export class Pages extends EventEmitter {
    async getFile(req, res, url) {
        return new Promise((resolve, reject) => {
            const filePath = join('public', url)

            fs.access(filePath, fs.constants.F_OK, err => {
                if(err) {
                    res.statusCode = 404
                    res.end('Not Found')
                    return reject();
                }

                fs.createReadStream(filePath).pipe(res)
                resolve()
            })
        })
    }
    async getHTMLPage(title) {
        const __filename = fileURLToPath(import.meta.url)
        const filePath = join(dirname(__filename),title)
        return fs?.promises?.readFile(filePath, 'utf-8');
    }
}

export const pages = new Pages()