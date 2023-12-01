// 7. Разработайте приложение 09-02a, представляющее собой WS-клиент, демонстрирующий работоспособность сервера.

import { io } from "socket.io-client";

const socket = io("ws://localhost:4000");

socket.on("connect", () => {
  console.log("Connected to server");
  socket.emit("file", "test-file.txt");

  socket.on("file", (data) => {
    console.log(data);
  });
});
