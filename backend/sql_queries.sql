CREATE TABLE user(
    username VARCHAR(50) PRIMARY KEY,
    role INT,
    name VARCHAR(50),
    phone VARCHAR(15),
    password VARCHAR(100) NOT NULL
);

CREATE TABLE menu (
    item VARCHAR(50) PRIMARY KEY,
    price INT,
    availability CHAR,
    rating INT,
    category VARCHAR(20),
    type INT,
    image VARCHAR(150)
);

CREATE TABLE cart (
    username VARCHAR(50),
    item VARCHAR(50),
    quantity INT,
    PRIMARY KEY (username,item),
    FOREIGN KEY (username) REFERENCES user(username),
    FOREIGN KEY (item) REFERENCES menu(item)
);

CREATE TABLE orders (
    orderId VARCHAR(75),
    username VARCHAR(50),
    orderType CHAR,
    item VARCHAR(50),
    quantity INT,
    price INT,
    order_status VARCHAR(1),
    payment_status VARCHAR(1), 
    delivery_time TIMESTAMP,
    PRIMARY KEY (orderID,item),
    FOREIGN KEY (username) REFERENCES user(username),
    FOREIGN KEY (item) REFERENCES menu(item)
);
