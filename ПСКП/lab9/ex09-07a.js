// 32. Разработайте приложение 09-07a, представляющее собой WS-клиент, демонстрирующий
// работоспособность сервера.Приложение шлет уведомления серверу при получении соответствующего
//  сообщения через стандартный поток ввода(консоль).

import { io } from "socket.io-client";
import { stdin } from "process";

const socket = io("ws://localhost:4000");

socket.on("connect", () => {
  console.log("Connected to server");
});

stdin.on("data", (data) => {
  const event = data.toString().trim();
  if (event === "A" || event === "B" || event === "C") {
    socket.emit(event);
  }
});
