// 5. Разработайте приложение 09-02, представляющее собой WebSocket(WS)-север, прослушивающий порт 4000.
// 6. WS-сервер предназначен для отправки по ws-каналу файлов из директории download.

import { createServer } from "http";
import * as fs from "fs";
import { Server } from "socket.io";

const server = createServer();
const io = new Server(server);

io.on("connection", (socket) => {
  socket.on("file", async (fileName) => {
    try {
      const fileData = await fs.promises.readFile(`./download/${fileName}`);
      socket.emit("file", {
        name: fileName,
        data: fileData,
      });
    } catch (err) {
      console.log(err);
    }
  });
});

server.listen(4000, () => {
  console.log("Server started on 4000 port");
});
