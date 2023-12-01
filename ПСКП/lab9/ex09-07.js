// 30. Разработайте приложение 09-07, представляющее собой WebSocket(WS)-север, прослушивающий порт 4000.
// 31. Приложение может принимать три типа уведомлений: A, B, C. При получении уведомления, сервер выводит
//  соответствующее сообщение на консоль.

import { createServer } from "http";
import { stdin } from "process";
import { Server } from "socket.io";

const server = createServer();
const io = new Server(server);

io.on("connection", (socket) => {
  console.log("Client connected");

  socket.on("A", () => console.log("A"));
  socket.on("B", () => console.log("B"));
  socket.on("C", () => console.log("C"));

  socket.on("disconnect", () => console.log("Client disconnected"));
});

server.listen(4000, () => console.log("Server started"));
