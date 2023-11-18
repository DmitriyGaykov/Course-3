import * as io from 'socket.io-client';

const socket = io('ws://localhost:5000');
const number = Math.round(Math.random() * 1000000);

setInterval(() => {
  socket.send(`Message from server #${number}`);
}, 2000);

socket.on('message', console.log);