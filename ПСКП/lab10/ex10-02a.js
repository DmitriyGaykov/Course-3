// @ts-nocheck
// 3. Разработайте приложение 10-02a, представляющее собой TCP-клиента.
// Клиент принимает 2 числовых параметра(номер порта сервера и число X)
// через командную строку.Клиент через TCP - соединение отправляет 1 раз
// в секунду серверу 32 - битовое число X.Клиент принимает от сервера промежуточные
// суммы и выводит их на консоль.

import { Socket } from "net";

const client = new Socket();
const port = process.argv[2];
const x = process.argv[3];

client.on("data", (data) => {
  console.log(data.toString());
});

client.on("end", () => {
  console.log("Disconnected from server");
});

client.connect(port, "127.0.0.1", () => {
  console.log("Connected to server");
  client.write(x);
  setInterval(() => {
    client.write(x);
  }, 1000);
});
