import 'bootstrap/dist/css/bootstrap.min.css'
import axios from "axios";

/*
2. Разработайте приложение (клиент) 07-01, предназначенное для отправки GET-запроса.
3. Выведите на консоль: статус ответа, сообщение к статусу ответа, IP-адрес удаленного сервера, порт удаленного сервера.
4. Для проверки разработайте соответствующий сервер.

5. Разработайте приложение (клиент) 07-02, предназначенное для отправки GET-запроса с числовыми параметрами x и y (параметры должны передаваться в URL).
6. Выведите на консоль: статус ответа, данные, пересылаемые в теле ответа.
7. Для проверки разработайте соответствующий сервер.

8. Разработайте приложение (клиент) 07-03, предназначенное для отправки POST-запроса с параметрами x, y, s (параметры должны передаваться в теле).
9. Выведите на консоль: статус ответа, данные, пересылаемые в теле ответа.
10. Для проверки разработайте соответствующий сервер.

11. Разработайте приложение (клиент) 07-04, предназначенное для отправки POST-запроса с данными в json-формате и обработки ответа в json-формате.
12. Используйте структуры данных в запросах и ответах из задания 8 лабораторной работы 6.
13. Выведите на консоль: статус ответа, данные, пересылаемые в теле ответа.
14. Для проверки разработайте соответствующий сервер.

15. Разработайте приложение (клиент) 07-05, предназначенное для отправки POST-запроса с данными в xml-формате и обработки ответа в xml-формате.
16. Используйте структуры данных в запросах и ответах из задания 9 лабораторной работы 6.
17. Выведите на консоль: статус ответа, данные, пересылаемые в теле ответа.
18. Для проверки разработайте соответствующий сервер.

19. Создайте файл MyFile.png размером более 0.5 МБ.
20. Разработайте приложение (клиент) 07-06, предназначенное для отправки POST-запроса с вложенным файлом MyFile.png (multipart/form-data).
21. Для проверки разработайте соответствующий сервер.

22. Разработайте приложение (клиент) 07-07, предназначенное для отправки GET-запроса и получения ответа с вложенным файлом.
23. Для проверки разработайте соответствующий сервер.

 */




const host : string = 'http://localhost:3000/api';

const root = document.querySelector<HTMLDivElement>('#app');

root!.innerHTML = `
  <div class="d-flex container flex-column align-items-start gap-5 justify-content-start">
    <div class="d-flex flex-column gap-2">
        <h1 class="flex-column">ex07_01</h1>
        <button class="ex01 btn btn-primary">Click</button>
    </div>
    <div class="d-flex flex-column gap-2">
        <h1 class="flex-column">ex07_02</h1>
        <h3 class="h3">Params x = 1, y = 2</h3>
        <button class="ex02 btn btn-danger">Click</button>
    </div>
    <div class="d-flex flex-column gap-2">
        <h1 class="flex-column">ex07_03</h1>
        <h3 class="h3">Body x = 1, y = 2, s = 'string'</h3>
        <button class="ex03 btn btn-dark">Click</button>
    </div>
    <div class="d-flex flex-column gap-2">
        <h1 class="flex-column">ex07_04</h1>
        <h3 class="h3">Body x = 1, y = 2, s = 'string', m = ['1', 'v', '3', '4', '5'], o = { surname: 'Иванов', name: 'Иван' }</h3>
        <button class="ex04 btn btn-success">Click</button>
    </div>
    <div class="d-flex flex-column gap-2">
        <h1 class="flex-column">ex07_05</h1>
        <button class="ex05 btn btn-warning">Click</button>
    </div>
    <div class="d-flex flex-column gap-2">
        <h1 class="flex-column">ex07_06</h1>
        <form class="file-form ex06 form-control container d-flex flex-column gap-2 border border-1 rounded-1 border-dark" encType="multipart/form-data">
          <input class="form-control" type="file" name="image" id="file"/>
          <button class="submit btn btn-info">Send</button>
        </form>
    </div>
    <div class="d-flex flex-column gap-2">
      <h1>ex07-07</h1>
      <button class="ex07 btn btn-primary">Get File</button>
    </div>
  </div>
`;

const onEx01 = async () : Promise<void> => {
  try {
    const response = await axios.get(host + '/ex01');
    let [ip, port] = response.config.url!.split('//')[1].split(':');
    port = port.split('/')[0];

    console.log(response.status);
    console.log(response.statusText);
    console.log(ip);
    console.log(port);
  } catch (e) {
    console.log(e);
  }
}
const onEx02 = async () : Promise<void> => {
  try {
    const response = await axios.get(host + '/ex02', {
      params: {
        x: 1,
        y: 2
      }
    });

    console.log(response.status);
    console.log(response.data);
  } catch (e) {
    console.log(e);
  }
}
const onEx03 = async () : Promise<void> => {
  try {
    const response = await axios.post(host + '/ex03', {
      x: 1,
      y: 2,
      s: 'string'
    });

    console.log(response.status);
    console.log(response.data);
  } catch (e) {
    console.log(e);
  }
}
const onEx04 = async () : Promise<void> => {
  try {
    const response = await axios.post(host + '/ex04', {
      "__comment": "Запрос. Лабораторная номер 7",
      "x": 1,
      "y": 2,
      "s": "Сообщение",
      "m": ['1', 'v', '3', '4', '5'],
      "o": {
        "surname": "Иванов",
        "name": "Иван",
      }
    });

    console.log(response.status);
    console.log(response.data);
  } catch (e) {
    console.log(e);
  }
}
const onEx05 = async () : Promise<void> => {
  try {
    const xml = `
     <request id="28">
        <x value="1"/>
        <x value="2"/>
        <m value="a"/>
        <m value="b"/>
        <m value="c"/>
     </request>
    `

    const response = await axios.post(host + '/ex05', xml, {
      headers: {
        'Content-Type': 'text/xml'
      }
    });

    console.log(response.status);
    console.log(response.data);
  } catch (e) {
    console.log(e);
  }
}
const onEx06 = async (e : Event) : Promise<void> => {
  e.preventDefault();
  try {
    const form = document.querySelector<HTMLFormElement>('.file-form')!;
    const formData = new FormData(form);

    await axios.post(host + '/ex06', formData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    });
  } catch (e) {
    console.log(e);
  }
}
const onEx07 = async () : Promise<void> => {
  try {
    const response = await axios.get(host + '/ex07');
    const file = response.data;
    console.log(file);
  } catch (e: unknown) {
    console.log(e);
  }
}

root?.querySelector('.ex01')!.addEventListener('click', onEx01);
root?.querySelector('.ex02')!.addEventListener('click', onEx02);
root?.querySelector('.ex03')!.addEventListener('click', onEx03);
root?.querySelector('.ex04')!.addEventListener('click', onEx04);
root?.querySelector('.ex05')!.addEventListener('click', onEx05);
root?.querySelector('.ex06')!.addEventListener('submit', onEx06);
root?.querySelector('.ex07')!.addEventListener('click', onEx07);
