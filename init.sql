-- создание базы данных
CREATE DATABASE my_shop CHARACTER SET utf8 COLLATE utf8_general_ci;

USE my_shop;

-- таблица пользователей
CREATE TABLE users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone_number VARCHAR(50) NOT NULL
);

-- таблица категорий
CREATE TABLE categories(
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL
);

-- таблица продуктов
CREATE TABLE products(    
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL NOT NULL CHECK(price > 0),
    quantity INT NOT NULL
);

-- соединительная таблица категорий и продуктов (связь многие ко многим)
CREATE TABLE category_product(    
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY(category_id) REFERENCES categories(id),
    FOREIGN KEY(product_id) REFERENCES products(id)
);  

-- таблица путей фотографий к продуктам
CREATE TABLE product_photos(
    id INT PRIMARY KEY AUTO_INCREMENT, 
    product_id INT NOT NULL,
    path_to_photo VARCHAR(255) NOT NULL,
    FOREIGN KEY(product_id) REFERENCES products(id)
);    

-- таблица способов доставки
CREATE TABLE delivery(
    id INT PRIMARY KEY AUTO_INCREMENT,
    delivery_method VARCHAR(100) NOT NULL
);

-- таблица заказов
CREATE TABLE orders(
    id INT PRIMARY KEY AUTO_INCREMENT, 
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    delivery_id INT NOT NULL,
    quantity INT NOT NULL CHECK(quantity > 0),
    total_sum DECIMAL NOT NULL CHECK(total_sum > 0),
    order_date DATETIME NOT NULL DEFAULT NOW(),
    FOREIGN KEY(user_id) REFERENCES users(id),
    FOREIGN KEY(product_id) REFERENCES products(id),
    FOREIGN KEY(delivery_id) REFERENCES delivery(id)
); 

-- добавляю пользователей
INSERT INTO users(first_name, last_name, email, phone_number) VALUES
    ('Вася', 'Пупкин', 'vasya@gmail.com', '+380503422432'),
    ('Даша', 'Федорова', 'kyka@gmail.com', '0636466112'),
    ('Егор', 'Луковников', 'egor@gmail.com', '380976789011');
    
-- добавляю категории
INSERT INTO categories(category_name) VALUES
    ('Ноутбуки'), 
    ('Смартфоны'),
    ('Компьютеры'),
    ('Бытовая техника');

-- добавляю продукты
INSERT INTO products(title, description, price, quantity) VALUES
    ('Asus Rog Strix', 'лалалалалаалаллалалала', 32999.99, 100),
    ('Xiaomi redmi note 8', 'лалалалалалалалалалал', 6899.9, 332),
    ('Холодильник Nord t-867', 'lalalalalalallalala', 6499.999, 56),
    ('Стиральная машинка LG', 'lalalalalalala', 12999.99, 1100);
    
-- добавляю связи между продуктами и категориями
INSERT INTO category_product(category_id, product_id) VALUES
    (1, 1),
    (3, 1),
    (2, 2),
    (4, 3),
    (4, 4);

-- добавляю пути к фото к товарам
INSERT INTO product_photos(product_id, path_to_photo) VALUES
    (1, '/var/www/project/images/asus-rog/img1.jpg'),
    (1, '/var/www/project/images/asus-rog/img2.jpg'),
    (1, '/var/www/project/images/asus-rog/img3.jpg'),
    (2, '/var/www/project/images/xiaomi-8/img1.jpg'),
    (2, '/var/www/project/images/xiaomi-8/img2.jpg'),
    (2, '/var/www/project/images/xiaomi-8/img3.jpg'),
    (3, '/var/www/project/images/nord/img1.jpg'),
    (3, '/var/www/project/images/nord/img2.jpg'),
    (3, '/var/www/project/images/nord/img3.jpg');
        
-- добавляю способы доставки
INSERT INTO delivery(delivery_method) VALUES
    ('Новая почта'),
    ('Укрпочта'),
    ('Интайм'),
    ('Самовывоз');
    
-- добавляю покупки
INSERT INTO orders(user_id, product_id, delivery_id, quantity, total_sum) VALUES
    (1, 2, 1, 1, 1 * (select price from products where id = 2)),
    (1, 1, 4, 2, 2 * (select price from products where id = 1)), 
    (2, 4, 2, 1, 1 * (select price from products where id = 4)), 
    (3, 4, 2, 1, 1 * (select price from products where id = 4)), 
    (3, 2, 4, 6, 6 * (select price from products where id = 2));

  






