import { createServer } from "http";
import * as fs from "fs";
import { Server } from "socket.io";

// 1. Разработайте приложение 09-01, представляющее собой WebSocket(WS)-север, прослушивающий порт 4000.
// 2. WS-сервер предназначен для приема по ws-каналу файлов.
// 3. Принятый по ws-каналу файл записывается в директорию upload.

const server = createServer();
const io = new Server(server);

io.on("connection", (socket) => {
  socket.on("file", async (data) => {
    const fileName = data.name;
    const fileData = data.data;
    await fs.promises.writeFile(`./upload/${fileName}`, fileData);
  });
});

server.listen(4000, () => {
  console.log("Server started on 4000 port");
});
