import { WebSocketServer, WebSocket } from 'ws';

export function createHub(wss: WebSocketServer) {
  wss.on('connection', (socket: WebSocket) => {
    socket.on('message', (data) => {
      // TODO: handle messages
      console.log('ws message', data.toString());
    });
  });
}
