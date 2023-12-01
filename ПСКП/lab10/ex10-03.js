// 6. Разработайте приложение 10-03, представляющее собой UDP-сервер.
// Сервер должен принимать строковое сообщения от UDP - клиента и возвращать
// клиенту текст полученного сообщения с префиксом ECHO:.

import { createSocket } from "dgram";

const server = createSocket("udp4");

server.on("message", (msg, rinfo) => {
  server.send(`ECHO: ${msg}`, rinfo.port, rinfo.address);
});

server.bind(3000, () => {
  console.log("Server started on port 3000");
});
