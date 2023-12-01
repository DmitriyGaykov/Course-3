// 12. Разработайте приложение 09-04, представляющее собой WebSocket(WS)-север, прослушивающий порт 4000.
// 13. Сервер принимает сообщение вида:

// {client:x, timestamp:t}, где x-имя клиента, а t–штамп времени.

// Сообщение передается клиентом в json-формате.
// 14. Сервер отправляет в ответ клиенту сообщение вида:

// {server: n client:x, timestamp:t}, где n –номер сообщения, x-имя клиента, а t–штамп времени.

// Сообщение передается сервером в json-формате.

import { createServer } from "http";
import { Server } from "socket.io";

const server = createServer();
const io = new Server(server);

let counter = 0;

io.on("connection", (socket) => {
  socket.on("message", (data) => {
    const { client, timestamp } = JSON.parse(data);
    socket.send(
      JSON.stringify({
        server: ++counter,
        client,
        timestamp,
      })
    );
  });
});

server.listen(4000, () => {
  console.log("Listening on port 4000");
});
