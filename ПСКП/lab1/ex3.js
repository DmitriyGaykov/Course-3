const http = require('http')
const PORT = 3001

const app = http.createServer((req, res) => {
    const { method, url, httpVersion, headers } = req
    const uri = url
    let body;

    if(method === 'POST' || method === 'PUT' || method === 'PATCH' || method === 'DELETE') {
        req.on('data', data =>  {
            body = data.toString()
        });
    } else {
        req.on('data', () => {})
    }

    res.writeHead(200, {
        'Content-Type': 'text/html'
    })

    req.on('end', () => {
        const answer = `
        <p>
            method: ${method}
        </p>
        <p>
            uri: ${uri}
        </p>
        <p>
            httpVersion: ${httpVersion}
        </p>
        <p>
            headers: ${Object.keys(headers).map(key => `<br>${key}: ${headers[key]}`)}
        </p>
        <p>
            body: ${body}
        </p>
    `

        res.end(answer)
    })
})

const startListening = async () => {
    try {
        await app.listen(PORT)
        console.log(`Server started on the PORT ${PORT}`)
    } catch {
        console.error('Server not started')
    }
}

startListening()