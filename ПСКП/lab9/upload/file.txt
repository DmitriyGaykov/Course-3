import { io } from "socket.io-client";
import * as fs from "fs";

// 4. Разработайте приложение 09-01a, представляющее собой WS-клиент, демонстрирующий работоспособность сервера.

const socket = io("ws://localhost:4000");

socket.on("connect", () => {
  console.log("Connected to server");
  socket.emit("file", {
    name: "file.txt",
    data: fs.readFileSync("./ex09-01a.js"),
  });
});
