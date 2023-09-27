const http = require('http')
const PORT = 3001

const server = http.createServer((req, res) => {
    const answer = '<h1>Hello world</h1>>'
    const statusOk = 200

    res.writeHead(statusOk, {
        'Content-Type': 'text/html'
    })

    res.end(answer)
})

const startListening = async () => {
    try {
        await server.listen(PORT)
        console.log('Server started on PORT ' + PORT)
    } catch {
        console.error('Server was not started')
    }
}

startListening()