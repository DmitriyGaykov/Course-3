import * as http from "http";

const app = http.createServer(async (req : Request, res : Response) : Promise<any> => {
    res.end(`<h1>Hello world</h1>`);
})

const start  = async () : Promise<void> => {
    try {
        const PORT = 3000
        await app.listen(PORT)
        console.log(`Server started on the PORT ${PORT}`)
    } catch (e : unknown) {
        console.error(e.message)
    }
}

start()