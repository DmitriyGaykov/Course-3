// 19. Разработайте приложение 09-05a, представляющее собой WS-клиент, демонстрирующий работоспособность сервера.
// Приложение осуществляет следующие RPC - вызовы:
// square(3), square(5,4),
// sum(2), sum(2,4,6,8,10),
// mul(3), mul(3,5,7,9,11,13),
// fib(1), fib(2), fib(7),
// fact(0), fact(5), fact(10)

import { Client } from "rpc-websockets";

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
    console.log(await client.call("square", [3]));
    console.log(await client.call("square", [5, 4]));
    console.log(await client.call("sum", [2]));
    console.log(await client.call("sum", [2, 4, 6, 8, 10]));
    console.log(await client.call("mul", [3]));
    console.log(await client.call("mul", [3, 5, 7, 9, 11, 13]));

    await client.login({ login: config.login, password: config.password });

    console.log(await client.call("fib", [1]));
    console.log(await client.call("fib", [2]));
    console.log(await client.call("fib", [7]));
    console.log(await client.call("fact", [0]));
    console.log(await client.call("fact", [5]));
    console.log(await client.call("fact", [10]));
  } catch (e) {
    console.log(e);
  }

  client.close();
});
