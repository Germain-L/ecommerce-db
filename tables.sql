-- 
CREATE TABLE adress(
   id INT PRIMARY KEY AUTO_INCREMENT,
   zip varchar(255),
   number INT,
   street varchar(255),
   city varchar(255),
   country varchar(255)
);

--
CREATE TABLE image(
   id INT PRIMARY KEY AUTO_INCREMENT,
   link TEXT
);

--
CREATE TABLE users(
   id INT PRIMARY KEY AUTO_INCREMENT,
   username varchar(255),
   email varchar(255),
   password_hash TEXT
);

--
CREATE TABLE product(
   id INT PRIMARY KEY AUTO_INCREMENT,
   name varchar(255),
   description TEXT,
   price varchar(255)
);

--
CREATE TABLE category(
   id INT PRIMARY KEY AUTO_INCREMENT,
   name varchar(255)
);

--
CREATE TABLE payment_method(
   id INT PRIMARY KEY AUTO_INCREMENT,
   name varchar(255)
);

--
CREATE TABLE review(
   id INT PRIMARY KEY AUTO_INCREMENT,
   rating TINYINT,
   comment TEXT,
   date_created DATETIME,
   product_id INT NOT NULL,
   user_id INT,
   FOREIGN KEY(product_id) REFERENCES product(id),
   FOREIGN KEY(user_id) REFERENCES users(id)
);

--
CREATE TABLE orders(
   id INT PRIMARY KEY AUTO_INCREMENT,
   order_date DATETIME,
   price DECIMAL(10, 2),
   payment_status ENUM('PENDING', 'PAID', 'FAILED'),
   payment_method_id INT NOT NULL,
   users_id INT NOT NULL,
   adress_id INT NOT NULL,
   FOREIGN KEY(payment_method_id) REFERENCES payment_method(id),
   FOREIGN KEY(users_id) REFERENCES users(id),
   FOREIGN KEY(adress_id) REFERENCES adress(id)
);

CREATE TABLE product_category(
   product_id INT,
   category_id INT,
   FOREIGN KEY(product_id) REFERENCES product(id),
   FOREIGN KEY(category_id) REFERENCES category(id)
);

--
CREATE TABLE illustrates(
   image_id INT,
   product_id INT,
   FOREIGN KEY(image_id) REFERENCES image(id),
   FOREIGN KEY(product_id) REFERENCES product(id)
);

--
CREATE TABLE fullfils(
   product_id INT,
   orders_id INT,
   FOREIGN KEY(product_id) REFERENCES product(id),
   FOREIGN KEY(orders_id) REFERENCES orders(id)
);

