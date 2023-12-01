// 11. Разработайте приложение 09-03a, представляющее собой WS-клиент, демонстрирующий
// работоспособность сервера.Продемонстрируйте работу сервера с несколькими экземплярами 09-03a.

import { io } from "socket.io-client";

const socket = io("ws://localhost:4000");

socket.on("connect", () => {
  console.log("Connected to server");
  socket.on("message", console.log);
  socket.on("ping", () => socket.emit("pong"));
});
