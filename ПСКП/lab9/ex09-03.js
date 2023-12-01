// 8. Разработайте приложение 09-03, представляющее собой WebSocket(WS)-север, прослушивающий порт 4000.
// 9. Сервер каждые 15 секунд всем подключившимся клиентам высылает сообщение следующего формата:

// 09-03-server: n, где n - последовательный номер отправляемого сервером сообщения.

// 10. С помощью ping/pong-механизма сервер проверяет работоспособность соединений, каждые 5 секунд, при этом сервер выводит
// на консоль количество работоспособных соединений.

import { createServer } from "http";
import { Server } from "socket.io";

const server = createServer();
const io = new Server(server);

let counter = 0;
let messageCounter = 0;

io.on("connection", (socket) => {
  socket.on("pong", () => {
    counter++;
  });

  setInterval(() => {
    counter = 0;
    io.emit("ping");
  }, 5000);

  setInterval(() => {
    console.log(`Connections: ${counter}`);
  }, 6000);

  setInterval(() => {
    io.send(`09-03-server: ${++messageCounter}`);
  }, 15000);
});

server.listen(4000, () => {
  console.log("Listening on port 4000");
});
