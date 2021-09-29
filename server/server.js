const express = require('express');
const path = require('path');
const db = require('../database/index.js');
var bodyParser = require('body-parser');

const PORT = 3000;
const app = express();

app.get('/products', (req, res) => {
  db.list((err, result) => {
    if (err) {
      res.status(500);
      console.log('error', err);
      res.send('there was an error getting the list of products!');
    } else {
      res.status(200);
      console.log('Successfully got a list of products!')
      res.send('Hello from the server!');
    }
  })
});

app.listen(PORT, () => {
  console.log(`Server listening at localhost:${PORT}!`);
});