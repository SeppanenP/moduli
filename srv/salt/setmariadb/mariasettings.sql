# Create Database
CREATE DATABASE products;
USE products;
CREATE TABLE products (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(1024), price FLOAT);
INSERT INTO products (name, price) VALUES ("Product 1" , 99.9);
INSERT INTO products (name, price) VALUES ("Product 2" , 55.5);

# Create user "test" and allow database "products"
GRANT ALL ON products.* TO test@localhost IDENTIFIED BY 'really_good_password_here';

