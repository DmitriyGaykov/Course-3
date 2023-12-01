// 2. Разработайте приложение 10-01a, представляющее собой TCP-клиента, проверяющего работоспособность сервера 10-01.

import { Socket } from "net";

const client = new Socket();

client.on("data", (data) => {
  console.log(data.toString());
  client.end();
});

client.on("end", () => {
  console.log("Disconnected from server");
});

client.connect(3000, "127.0.0.1", () => {
  console.log("Connected to server");
  client.write("Hello from client");
});
