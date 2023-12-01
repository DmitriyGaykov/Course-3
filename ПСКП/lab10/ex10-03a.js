// 7. Разработайте приложение 10-03a, представляющее собой UDP-клиента, проверяющего работоспособность сервера 10-03.

import { createSocket } from "dgram";

const client = createSocket("udp4");

client.on("message", (msg) => {
  console.log(msg.toString());
  client.close();
});

client.on("close", () => {
  console.log("Disconnected from server");
});

client.send("Hello from client", 3000, "0.0.0.0");
