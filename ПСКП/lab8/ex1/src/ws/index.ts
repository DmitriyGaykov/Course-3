import {Server} from 'socket.io';
import {createServer} from "http";
import {App} from "../index";
import * as cors from 'cors';

export default function createWs() {
  App.use(cors());

  const server = createServer(App);
  const io = new Server(server);
  const WS_PORT: number = 4000;

  io.on('connection', client => {
    console.log('connected');

    let lastN: string = NaN;
    let k = 0;

    const handle = setInterval(() => {
      client.send(`08-01-server: ${lastN}->${++k}`);
    }, 5000);

    client.on('message', (message: string) => {
      console.log(message);
      lastN = message.split(' ').at(-1);
    })

    client.on('disconnect', () => {
      console.log('disconnected');
      clearInterval(handle);
    })
  });

  return () => server.listen(WS_PORT, () => {
    console.log(`WsServer started on PORT ${WS_PORT}`);
  });
}