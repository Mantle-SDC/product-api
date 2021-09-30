DROP DATABASE IF EXISTS mantle_product;

CREATE DATABASE IF NOT EXISTS mantle_product;

USE mantle_product;

CREATE TABLE products (
  id INT NOT NULL AUTO_INCREMENT,
  name TEXT NOT NULL,
  slogan TEXT NOT NULL,
  description TEXT NOT NULL,
  category_id INT NOT null,
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
  original_price INT NOT NULL,
  sale_price INT,
  default_style BIT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE categories (
  id INT NOT NULL AUTO_INCREMENT,
  name TEXT NOT NULL,
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
  quantity INT NOT NULL,
  size TEXT NOT NULL,
  PRIMARY KEY (id)
);

ALTER TABLE features ADD FOREIGN KEY (product_id) REFERENCES products (id);
ALTER TABLE styles ADD FOREIGN KEY (product_id) REFERENCES products (id);
ALTER TABLE products ADD FOREIGN KEY (category_id) REFERENCES categories (id);
ALTER TABLE photos ADD FOREIGN KEY (style_id) REFERENCES styles (id);
ALTER TABLE skus ADD FOREIGN KEY (style_id) REFERENCES styles (id);