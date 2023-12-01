// 17. Разработайте приложение 09-05, представляющее собой WebSocket(WS)-север, прослушивающий порт 4000.
// 18. Сервер обеспечивает следующий RPC-интерфейс:
// RPC
// метод	public
// protected	Описание RPC-метода
// square	public	если принимает один параметр r, то возвращается площадь круга радиуса r;
// если принимает два параметрa a и b, то возвращается площадь прямоугольника с длинами сторон a и b;
// sum	public	принимает переменное количество числовых параметров, возвращает сумму значений всех параметров;
// mul	public	принимает переменное количество числовых параметров, возвращает  произведение значений всех параметров;
// fib	protected	принимает один числовой параметр n, возвращает массив, содержащий n  элементов последовательности Фибоначчи;
// fact	protected	принимает один числовой параметр n, возвращает факториал числа n;

import { Server } from "rpc-websockets";
import { fact, fib, mul, square, sum } from "./scripts/index.js";

const config = {
  host: "localhost",
  port: 4000,
};

const server = new Server(config);
server.setAuth(
  ({ login, password }) =>
    new Promise((resolve, reject) => {
      if (login === "admin" && password === "admin") resolve(true);
      else reject(false);
    })
);

server.register("square", square).public();
server.register("sum", sum).public();
server.register("mul", mul).public();
server.register("fib", fib).protected();
server.register("fact", fact).protected();
