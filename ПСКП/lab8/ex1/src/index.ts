import * as express from 'express';
import router from "./routes";
import createWsServer from './ws';
import * as cors from 'cors';

const app = express();
const HTTP_PORT: number = 3000;

app.set('view engine', 'ejs');

app.use(express.static('public'));
app.use(cors());
app.use(router);

app.listen(HTTP_PORT, () => {
  console.log(`Server started on PORT ${HTTP_PORT}`);
})

export const App = app;
createWsServer()();