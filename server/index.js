const express = require('express');
const db = require('../db');

const PORT = process.env.PORT || 3000;
const app = express();

app.get('/products', (req, res) => {
  const sqlString = 'SELECT * FROM products LIMIT 5';

  db.query(sqlString, (err, dbProducts) => {
    if (err) {
      res.status(500);
      console.log('error', err);
      res.send('there was an error getting the list of products!');
    } else {
      res.status(200);
      // console.log('Successfully got a list of products!');
      res.json(dbProducts);
    }
  });
});

app.get('/products/:product_id', (req, res) => {
  const sqlString = 'SELECT p.id, p.name, slogan, description, category, default_price, '
  + 'JSON_ARRAYAGG(JSON_OBJECT("feature", feature, "value", value)) AS features '
  + 'FROM products AS p '
  + 'JOIN features AS f ON p.id = f.product_id '
  + 'WHERE p.id = ? '
  + 'GROUP BY id, name, slogan, description, category, default_price';
  const values = [req.params.product_id];
  // console.log(sqlString);

  db.query(sqlString, values, (err, dbProducts) => {
    if (err) {
      res.status(500);
      console.log('error', err);
      res.send('there was an error getting the product!');
    } else {
      const dbProduct = dbProducts[0];
      // console.log(dbProduct);
      res.status(200);
      // console.log(`Successfully got product with id = ${req.params.product_id}`);
      res.json(dbProduct);
    }
  });
});

app.get('/products/:product_id/styles', (req, res) => {
  const sqlString = 'SELECT s.id AS style_id, s.name, original_price, sale_price, default_style, '
    + 'JSON_ARRAYAGG(JSON_OBJECT("thumbnail_url", thumbnail_url, "url", url)) AS photos, '
    + 'JSON_OBJECTAGG(sk.id, JSON_OBJECT("quantity", quantity, "size", size)) AS skus '
    + 'FROM styles AS s '
    + 'JOIN skus AS sk ON s.id = sk.style_id '
    + 'JOIN photos AS p ON s.id = p.style_id '
    + 'WHERE product_id = ? '
    + 'GROUP BY style_id, name, original_price, sale_price, default_style';
  const values = [req.params.product_id];
  // console.log(sqlString);

  db.query(sqlString, values, (err, dbStyles) => {
    if (err) {
      res.status(500);
      console.log('error', err);
      res.send('there was an error getting the list of styles!');
    } else {
      // console.log(dbStyles);
      const apiStyles = {
        product_id: req.params.product_id,
        results: dbStyles.map((style) => ({
          style_id: style.id,
          name: style.name,
          original_price: style.original_price,
          sale_price: style.sale_price,
          'default?': style.default_style === 1,
          photos: style.photos,
          skus: style.skus,
        })),
      };
      res.status(200);
      // console.log(`Successfully got list of styles with product id = ${req.params.product_id}`);
      res.json(apiStyles);
    }
  });
});

app.listen(PORT, () => {
  console.log(`Server listening at http://localhost:${PORT}!`);
});
