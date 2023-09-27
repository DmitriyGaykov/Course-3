import { createServer } from 'http'

const PORT = 5000
const states = ['norm', 'stop', 'test', 'idle', 'exit']

let AppState = states.at(0)

const app = createServer((req, res) => {
    const { method, url } = req

    if (method === 'GET' && url === '/') {
        res.writeHead(200, { 'Content-Type': 'text/plain' })
        res.end(AppState)
    }
})

const start = async () => {
    try {
        await app.listen(PORT)
        console.log(`Server started at http://localhost:${PORT}`)
    } catch (e) {
        console.log(e)
    }
}

start()

const setState = state => {
    state = state.trim()

    if(!states.includes(state))
        throw 'Invalid state'

    console.log(`reg = ${AppState} ---> ${state}`)
    AppState = state

    AppState === 'exit' && process.exit(0)
}

process.stdin.setEncoding('utf-8')
process.stdin.on('readable', () => {
  let text = null;

  while((text = process.stdin.read()) !== null) {
      try {
          setState(text)
      } catch (e) {
          console.log(e)
      }
  }
})
