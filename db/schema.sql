CREATE DATABASE IF NOT EXISTS mantle-product;

USE mantle-product;

CREATE TABLE products (
  id INT NOT NULL AUTO_INCREMENT,
  name TEXT NOT NULL,
  slogan TEXT NOT NULL,
  description TEXT NOT NULL,
  default-price INT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE product-features (
  id INT NOT NULL AUTO_INCREMENT,
  feature TEXT NOT NULL,
  value TEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE product-styles (
  id INT NOT NULL AUTO_INCREMENT,
  name TEXT NOT NULL,
  original-price INT NOT NULL,
  sale-price INT,
  default Boolean NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE product-category (
  id INT NOT NULL AUTO_INCREMENT,
  name TEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE style-photos (
  id INT NOT NULL AUTO_INCREMENT,
  thumbnailurl TEXT NOT NULL,
  url TEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE style-skus (
  id INT NOT NULL AUTO_INCREMENT,
  quantity INT NOT NULL,
  size TEXT NOT NULL,
  PRIMARY KEY (id)
);