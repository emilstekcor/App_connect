import express from 'express';
import { WebSocketServer } from 'ws';
import http from 'http';
import dotenv from 'dotenv';
import router from './routes/index.js';
import { createHub } from './ws/hub.js';

dotenv.config();

const app = express();
app.use(express.json());
app.use('/api', router);

const server = http.createServer(app);
const wss = new WebSocketServer({ server, path: '/ws' });
createHub(wss);

const port = process.env.SERVER_PORT || 3000;
server.listen(port, () => {
  console.log(`Server listening on ${port}`);
});
