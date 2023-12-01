// 22. Разработайте приложение 09 - 05 с, представляющее собой WS - клиент, демонстрирующий работоспособность сервера.
// Приложение вычисляет с помощью RPC - вызовов следующее выражение:
//     sum(square(3), square(5, 4), mul(3, 5, 7, 9, 11, 13)) +
//     fib(7) *
//     mul(2, 4, 6)

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

    const sum = async (...args) => await client.call("sum", args);
    const square = async (...args) => await client.call("square", args);
    const mul = async (...args) => await client.call("mul", args);
    const fib = async (...args) => await client.call("fib", args);

    const promises = [
      sum(await square(3), await square(5, 4), await mul(3, 5, 7, 9, 11, 13)),
      mul((await fib(7))["length"], await mul(2, 4, 6)),
    ];

    const results = await parallel(promises.map((p) => async () => p));
    console.log(results[0] + results[1]);
  } catch (e) {
    console.log(e);
  }

  client.close();
});
