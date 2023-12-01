// 21. Разработайте приложение 09-05b, представляющее собой WS-клиент,
// демонстрирующий работоспособность сервера.Приложение осуществляет параллельные(async / parallel)
// RPC - вызовы из п.20.Результаты вычислений отобразите в консоли приложения.

import { Client } from "rpc-websockets";
import { parallel } from "async";

const config = {
  host: "localhost",
  port: 4000,
  login: "admin",
  password: "admin",
};

const client = new Client(`ws://${config.host}:${config.port}`);

client.on("open", async () => {
  console.log("open");
  try {
    await client.login({ login: config.login, password: config.password });

    const promises = [
      client.call("square", [3]),
      client.call("square", [5, 4]),
      client.call("sum", [2]),
      client.call("sum", [2, 4, 6, 8, 10]),
      client.call("mul", [3]),
      client.call("mul", [3, 5, 7, 9, 11, 13]),
      client.call("fib", [1]),
      client.call("fib", [2]),
      client.call("fib", [7]),
      client.call("fact", [0]),
      client.call("fact", [5]),
      client.call("fact", [10]),
    ];

    const results = await parallel(promises.map((p) => async () => p));
    console.log(results);
  } catch (e) {
    console.log(e);
  }

  client.close();
});
