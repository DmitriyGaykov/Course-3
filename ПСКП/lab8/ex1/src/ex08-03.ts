import {createServer} from "http";
import {Server} from "socket.io";

const server = createServer(() => {});
const socket = new Server(server);

socket.on('connection', client => {
  client.on('message', message => socket.emit('message', message));
})

server.listen(5000, () => {
  console.log(`Ex3 started`);
})