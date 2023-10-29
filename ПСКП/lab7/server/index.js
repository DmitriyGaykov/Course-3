import express from 'express';
import cors from 'cors';
import bodyParser from "express";
import {xmlMiddleware} from "./middlewares/index.js";
import fileUpload from 'express-fileupload'
import { join, dirname } from 'path';
import { fileURLToPath } from 'url'

const app = express();
const PORT = 3000;

app.use(cors());
app.use(bodyParser.text({ type: 'text/xml' }));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.get('/api/ex01', (req, res) => {
  res.json({ message: 'Hello World!' });
});

app.get('/api/ex02', (req, res) => {
  res.json(req.query);
});

app.post('/api/ex03', (req, res) => {
  res.json(req.body);
});

app.post('/api/ex04', (req, res) => {
  const body = req.body;
  
  const answer = {
    __comment: body.__comment.replace('Запрос', 'Ответ'),
    x_plus_y: body.x + body.y,
    Concatenation_s_o: body.s + ': ' + body.o.surname + ', ' + body.o.name,
    Length_m: body.m.length
  };
  
  res.json(answer);
})

app.post('/api/ex05', xmlMiddleware, (req, res) => {
  const arrayX = req.body.request.x.map(el => Number(el['$'].value));
  const arrayM = req.body.request.m.map(el => el['$'].value);
  const answer = `
    <response id="33" request="${req.body.request['$'].id}">
        <sum element="x" result="${arrayX.reduce((sum, el) => sum + el, 0)}"/>
        <concat element="m" result="${arrayM.join('')}"/>
    </response>
  `;
  res.headers = {
    'Content-Type': 'text/xml'
  }
  res.send(answer);
})

app.post('/api/ex06', fileUpload(), (req, res) => {
  console.log(req.files.image);
  res.json();
})

app.get('/api/ex07', async (req, res) => {
  try {
    const currentURL = import.meta.url;
    const currentPath = fileURLToPath(currentURL);
    const currentDirectory = dirname(currentPath);
    await res.sendFile(join(currentDirectory, 'index.js'));
  } catch (e) {
    console.log(e)
    res.status(500).json();
  }
})

app.listen(PORT, () => {
  console.log(`Server is listening on port ${PORT}`);
});