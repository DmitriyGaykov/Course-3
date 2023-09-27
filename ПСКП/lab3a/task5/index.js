import {createServer} from 'http'
import {parse} from "url";
import {fact} from "./utils.js";
import fs from 'fs'

const PORT = 5002

const app = createServer((req, res) => {
    try {
        const {url, method} = req

        const {pathname, query} = parse(url, true);

        switch (pathname) {
            case '/':
                if (method === 'GET') {
                    return setImmediate(() => {
                        const file = fs.readFileSync('index.html')
                        res.writeHead(200, {'Content-Type': 'text/html'})
                        return res.end(file)
                    })
                }
            case '/fact':
                if (method === 'GET') {
                    if(!isFinite(query.k)) {
                        res.statusCode = 400
                        return res.end('Bad request')
                    }

                    const k = parseInt(query.k)

                    if (k) {
                        res.writeHead(200, {'Content-Type': 'application/json'})
                        return setImmediate(() => {
                            res.end(JSON.stringify({
                                k,
                                fact: fact(k)
                            }))
                        })
                    }
                }
        }

        res.statusCode = 404
        res.end('Not found')
    } catch (e) {
        console.log(e)
        res.statusCode = 500
        res.end('Internal server error')
    }
})

const start = async () => {
    try {
        await app.listen(PORT)
        console.log(`Server started on port ${PORT}`)
    } catch (e) {
        console.log(e)
    }
}

start()
