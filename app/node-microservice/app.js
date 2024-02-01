const http = require('http');

const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello, World!\n');
});

app.get('/trigger-flask-request', (req, res) => {
  const flaskServerHost = process.env.FLASK_HOST;
  const flaskServerPort = process.env.FLASK_PORT;

  const options = {
    hostname: flaskServerHost,
    port: flaskServerPort,
    path: '/',
    method: 'GET',
  };

  const httpRequest = http.request(options, (flaskRes) => {
    let data = '';

    flaskRes.on('data', (chunk) => {
      data += chunk;
    });

    flaskRes.on('end', () => {
      console.log('Response from Flask server:', data);
      res.send('Triggered Flask request. Check the console for the response.');
    });
  });

  httpRequest.on('error', (error) => {
    console.error('Error making request to Flask server:', error.message);
    res.status(500).send('Internal Server Error');
  });

  httpRequest.end();
});

const PORT = process.env.PORT || 80;
const HOST = process.env.HOST || '127.0.0.1';

app.listen(PORT, HOST, () => {
  console.log(`Server running at http://${HOST}:${PORT}/`);
});
