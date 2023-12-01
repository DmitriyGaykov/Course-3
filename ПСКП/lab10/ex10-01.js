// 1. Разработайте приложение 10-01, представляющее собой TCP-сервер.
// Сервер должен через TCP - соединение принимать строковое сообщение от TCP - клиента и возвращать
// клиенту текст полученного сообщения с префиксом ECHO:.

import { createServer } from "net";

const server = createServer((socket) => {
  socket.on("data", (data) => {
    socket.write(`ECHO: ${data}`);
  });
});

server.listen(3000, () => {
  console.log("Server started on port 3000");
});
