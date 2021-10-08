const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: '172.31.42.77',
  user: 'sdc',
  password: 'hackreactor',
  database: 'mantle_product',
});

connection.connect((err) => {
  if (err) {
    console.log(err);
  } else {
    console.log('Connected to MySQL!');
  }
});

module.exports = connection;
