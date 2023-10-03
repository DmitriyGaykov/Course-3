import { createServer } from 'http'
import {parse} from "url";
import {receiveBody} from "./utils/receive-body.js";
import {DB} from "./data/DB.js";
import {pages} from "./pages/pages.js";

const db = new DB()

db.on('GET', async (req, res) => {
    const data = await db.select()

    return res.writeHead(
        data.length === 0 ? 204 : 200,
        {
            'Content-Type': 'text/json'
        }
    ).end(JSON.stringify(data))
})
db.on('POST', async (req, res) => {
    try {
        const user = await db.insert(req.body)
        return res.writeHead(201, {
            'Content-Type': 'text/json'
        }).end(JSON.stringify(user))
    } catch (e) {
        return res.writeHead(400, {
            'Content-Type': 'text/plain'
        }).end(e)
    }
})
db.on('PUT', async (req, res) => {
    try {
        const user = await db.update(req.body)
        res.writeHead(200, {
            "Content-Type": 'text/json'
        }).end(JSON.stringify(user))
    } catch (e) {
        return res.writeHead(400, {
            'Content-Type': 'text/plain'
        }).end(e)
    }
})
db.on('DELETE', async (req, res) => {
    try {
        await db.delete(parseInt(req.query.id))
        res.end()
    } catch {
        res.writeHead(204).end()
    }
})
pages.on('HTML', async (req, res) => {
    try {
        const file = await pages.getHTMLPage(req.pathname)
        return res.writeHead(200, {
            "Content-Type": "text/html"
        }).end(file)
    } catch {
        try {
            return await pages.getFile(req, res, req.pathname)
        } catch (e) {
            console.log('Not found')

            return;
        }
    }
})

const server = createServer((req, res) => {
    receiveBody(req)
    const {pathname, query} = parse(req.url, true)
    req.query = query
    req.pathname = pathname

    console.log(req.url)

    return req.on('end', () => {
        if(pathname === '/api/db')
            return db.emit(req.method, req, res)
        else
            return pages.emit('HTML', req, res)
    })
})

export const start = async (server, port) => {
    try {
        await server.listen(port)
        console.log('Server started on port ' + port)
    } catch (e) {
        console.error(e)
    }
}

start(server, 5000)