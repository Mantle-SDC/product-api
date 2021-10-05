DROP DATABASE IF EXISTS mantle_product;

CREATE DATABASE IF NOT EXISTS mantle_product;

USE mantle_product;

SET GLOBAL local_infile=1;

CREATE TABLE products (
  id INT NOT NULL AUTO_INCREMENT,
  name TEXT NOT NULL,
  slogan TEXT NOT NULL,
  description TEXT NOT NULL,
  category TEXT NOT null,
  default_price INT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE features (
  id INT NOT NULL AUTO_INCREMENT,
  product_id INT NOT NULL,
  feature TEXT NOT NULL,
  value TEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE styles (
  id INT NOT NULL AUTO_INCREMENT,
  product_id INT NOT NULL,
  name TEXT NOT NULL,
  sale_price INT,
  original_price INT NOT NULL,
  default_style BOOLEAN NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE photos (
  id INT NOT NULL AUTO_INCREMENT,
  style_id INT NOT NULL,
  thumbnail_url TEXT NOT NULL,
  url TEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE skus (
  id INT NOT NULL AUTO_INCREMENT,
  style_id INT NOT NULL,
  size TEXT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (id)
);

ALTER TABLE features ADD FOREIGN KEY (product_id) REFERENCES products (id);
ALTER TABLE styles ADD FOREIGN KEY (product_id) REFERENCES products (id);
ALTER TABLE photos ADD FOREIGN KEY (style_id) REFERENCES styles (id);
ALTER TABLE skus ADD FOREIGN KEY (style_id) REFERENCES styles (id);

LOAD DATA LOCAL INFILE './data/product.csv'
-- LOAD DATA LOCAL INFILE 'product_head.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE './data/features.csv'
INTO TABLE features
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE './data/styles.csv'
-- LOAD DATA LOCAL INFILE 'styles_head.csv'
INTO TABLE styles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
-- (id, product_id, name, sale_price, original_price, @default_style)
-- SET default_style = CAST(@default_style AS UNSIGNED)
;

LOAD DATA LOCAL INFILE './data/skus.csv'
INTO TABLE skus
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE './data/photos.csv'
INTO TABLE photos
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
