const express = require('express');
const db = require('../db');

const PORT = 3000;
const app = express();

app.get('/products', (req, res) => {
  const sqlString = 'SELECT * FROM products';

  db.query(sqlString, (err, result) => {
    if (err) {
      res.status(500);
      console.log('error', err);
      res.send('there was an error getting the list of products!');
    } else {
      res.status(200);
      console.log('Successfully got a list of products!');
      res.send(`Hello from the server!${result}`);
    }
  });
});

app.listen(PORT, () => {
  console.log(`Server listening at http://localhost:${PORT}!`);
});
