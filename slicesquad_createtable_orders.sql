/* creation of orders table with connections to customers, address, and items tables */

CREATE TABLE orders (
    row_id int PRIMARY KEY,
    order_id VARCHAR(10),
    date date,
    time time,
    quantity INT,
    cust_id INT
    delivery BOOLEAN,
    add_id INT,    
);


CREATE TABLE customers (
    cust_id INT PRIMARY KEY,
    cust_first VARCHAR(50),
    cust_last VARCHAR(50),
);


CREATE TABLE address (
    cust_id INT PRIMARY KEY,
    cust_first VARCHAR(50),
    cust_last VARCHAR(50),
    delivery_address1 VARCHAR(200),
    delivery_address2 VARCHAR(200) NULL, 
    delivery_city VARCHAR(50),
    delivery_zipcode VARCHAR(20)
);


CREATE TABLE item (
    item_id int PRIMARY KEY,
    sku VARCHAR(50),
    item_name VARCHAR(50),
    item_cat VARCHAR(20),
    item_size DECIMAL(5,2),
    item_price int
);




