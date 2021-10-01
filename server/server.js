const express = require('express');
const db = require('../db');

const PORT = 3000;
const app = express();

app.get('/products', (req, res) => {
  const sqlString = 'SELECT * FROM products LIMIT 5';

  db.query(sqlString, (err, result) => {
    if (err) {
      res.status(500);
      console.log('error', err);
      res.send('there was an error getting the list of products!');
    } else {
      res.status(200);
      console.log('Successfully got a list of products!');
      res.json(result);
    }
  });
});

app.get('/products/:product_id', (req, res) => {
  const sqlString = 'SELECT * FROM products WHERE id = ?';
  const values = [req.params.product_id];

  db.query(sqlString, values, (err, result) => {
    if (err) {
      res.status(500);
      console.log('error', err);
      res.send('there was an error getting the product!');
    } else {
      res.status(200);
      console.log(`Successfully got product with id = ${req.params.product_id}`);
      res.json(result);
    }
  });
});

app.get('/products/:product_id/styles', (req, res) => {
  const sqlString = 'SELECT * FROM styles WHERE product_id = ?';
  const values = [req.params.product_id];

  db.query(sqlString, values, (err, result) => {
    if (err) {
      res.status(500);
      console.log('error', err);
      res.send('there was an error getting the list of styles!');
    } else {
      res.status(200);
      console.log(`Successfully got a list of styles with product id = ${req.params.product_id}`);
      res.json(result);
    }
  });
});

app.listen(PORT, () => {
  console.log(`Server listening at http://localhost:${PORT}!`);
});
