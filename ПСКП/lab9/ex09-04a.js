// 15. Разработайте приложение 09 - 04 a, представляющее собой WS - клиент, демонстрирующий работоспособность сервера.
// Приложение принимает параметр командной строки, значение которого используется в качестве значения x, в сообщении для сервера.
// 16. Продемонстрируйте взаимодействие сервера с несколькими клиентами(клиенты должны иметь разные значения параметра).

import { io } from "socket.io-client";
import { dateMapperFromString } from "./scripts/index.js";

const socket = io("ws://localhost:4000");
const name = process.argv[2];

socket.on("connect", () => {
  console.log("Connected to server");
  socket.send(
    JSON.stringify({
      client: name,
      timestamp: Date.now(),
    })
  );
  socket.on("message", (msg) => {
    const { server, client, timestamp } = JSON.parse(msg);
    console.log(
      `server: ${server}, client: ${client}, timestamp: ${dateMapperFromString(
        timestamp
      )}`
    );
  });
});
