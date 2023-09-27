const http = require('http')

const ex02_01 = require('./02_01')
const ex02_02 = require("./02_02");
const ex02_03 = require("./02_03");
const ex02_04 = require("./02_04");
const ex02_05 = require("./02_05");
const ex02_06 = require("./02_06");


const PORT = 5000

const app = http.createServer(async (req, res) => {
    try {
        switch (req.url) {
            case '/html':
                return ex02_01(req, res)
            case '/png':
                if(req.method === 'GET')
                    return ex02_02(req, res)
            case '/api/name':
                if(req.method === 'GET')
                    return ex02_03(req, res)
            case '/xmlhttprequest':
                if(req.method === 'GET')
                    return ex02_04(req, res)
            case '/fetch':
                if(req.method === 'GET')
                    return ex02_05(req, res)
            case '/jquery':
                if(req.method === 'GET')
                    return ex02_06(req, res)
        }

        return res.writeHead(404).end('Not found')
    } catch (e) {
        res.writeHead(500).end()
    }
})

const start =  async () => {
    try {
        await app.listen(PORT)
        console.info('Server started on PORT ' + PORT)
    } catch (e) {
        console.error(e)
    }
}

start()