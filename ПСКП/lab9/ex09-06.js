// 23. Разработайте приложение 09-06, представляющее собой WebSocket(WS)-север, прослушивающий порт 4000.
// 24. Приложение может генерировать три события: A, B, C.
// 25. Генерация событий осуществляется при получении соответствующего сообщения через стандартный поток
// ввода(через консоль).При вводе символа A сервер генерирует событие A; при вводе символа B сервер генерирует событие B;
//  при вводе символа C сервер генерирует событие C.

import { createServer } from "http";
import { stdin } from "process";
import { Server } from "socket.io";

const server = createServer();
const io = new Server(server);

io.on("connection", (socket) => {
  console.log("Client connected");
  socket.on("disconnect", () => console.log("Client disconnected"));
});

server.listen(4000, () => console.log("Server started"));

stdin.on("data", (data) => {
  const event = data.toString().trim();
  if (event === "A" || event === "B" || event === "C") {
    io.emit(event);
  }
});
