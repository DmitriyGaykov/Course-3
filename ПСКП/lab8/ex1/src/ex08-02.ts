import * as io from 'socket.io-client';

const socket = io('ws://localhost:4000');
let n = 0;

setInterval(() => {
  socket.send(`08-02-client: ${++n}`);
}, 3000)

socket.on('message', console.log);

