// 2. Разработайте приложение 10-02, представляющее собой TCP - сервер, прослушивающий 2 порта: 40000, 50000.
//  Сервер должен через TCP - соединение принимать поток 32 - битовых чисел(по одному числу за каждую отправку клиентом).
//  Сервер суммирует полученные числа и каждые 5 сек.отправляет клиенту полученную(промежуточную) сумму.
//  Сервер обеспечивает каждому подключенному клиенту получение правильных промежуточных сумм чисел,
//   отправленных клиентом серверу.Сервер должен обеспечивать вывод на консоль диагностических сообщений,
//     позволяющих проверить корректность его работы

import { createServer } from "net";

const handler = (socket) => {
  const logs = [];
  let sum = 0;
  
  socket.on("data", (data) => {
    const num = parseInt(Buffer.from(data));
    sum += num || 0;
    
    logs.push(`${logs.length + 1}. num = ${num} | sum = ${sum}`);
  });
  
  setInterval(() => {
    socket.write(sum.toString());
  }, 5000);
  
  setInterval(() => {
    console.log(logs.join("\n"));
  }, 10000);
}

const server1 = createServer(handler);
const server2 = createServer(handler);

server1.listen(40000, () => {
  console.log("Server started on port 40000");
});

server2.listen(50000, () => {
  console.log("Server started on port 50000");
});
