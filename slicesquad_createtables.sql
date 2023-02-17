-- to create a table that logs orders to the restaurant.

CREATE TABLE orders(
    row_id int PRIMARY KEY NOT NULL,
    order_id VARCHAR(10) NOT NULL,
    created_at TIMESTAMP UNIQUE NOT NULL,
    item_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    cust_id VARCHAR(10) NOT NULL,
    add_id VARCHAR(10) NOT NULL,
    delivery BOOLEAN NOT NULL
);

-- to create a table that logs customers that order from the restaurant.

CREATE TABLE customers(
    cust_id VARCHAR(10) NOT NULL PRIMARY KEY,
    cust_first VARCHAR(50) NOT NULL,
    cust_last VARCHAR(50) NOT NULL
);

-- to create a table of delivery addresses that match with customers table.

CREATE TABLE address(
    address_id VARCHAR(10) PRIMARY KEY NOT NULL,
    delivery_address1 VARCHAR(200) NOT NULL,
    delivery_address2 VARCHAR(200) NULL,
    delivery_city VARCHAR(50) NOT NULL,
    delivery_zipcode VARCHAR(20) NOT NULL
);

-- to create a table of menu items.

CREATE TABLE item(
    item_id VARCHAR(10) PRIMARY KEY NOT NULL,
    sku VARCHAR(50) UNIQUE NOT NULL,
    item_name VARCHAR(50) NOT NULL,
    item_cat VARCHAR(50) NOT NULL,
    item_size VARCHAR(20) NOT NULL,
    item_price DECIMAL(5,2) NOT NULL
);

-- to create a table of recipes that matches with ingredients and inventory.

CREATE TABLE recipe(
    row_id INT PRIMARY KEY NOT NULL,
    recipe_id VARCHAR(50) NOT NULL,
    ing_id VARCHAR(20) UNIQUE NOT NULL,
    quantity INT NOT NULL
);

-- to create a table of ingredients that matches with inventory and recipes.

CREATE TABLE ingredients(
    ing_id VARCHAR(20) PRIMARY KEY NOT NULL,
    ing_name VARCHAR(50) NOT NULL,
    ing_weight INT NOT NULL,
    ing_meas VARCHAR(20) NOT NULL,
    ing_price DECIMAL(5,2) NOT NULL
);

-- to create a table that logs inventory.

CREATE TABLE inventory(
    inv_id VARCHAR(10) PRIMARY KEY NOT NULL,
    item_id VARCHAR(10) UNIQUE NOT NULL,
    quantity INT NOT NULL
);

-- to create a table of staff members.

CREATE TABLE staff(
    staff_id VARCHAR(10) PRIMARY KEY NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position VARCHAR(20) NOT NULL,
    hourly_rate DECIMAL(5,2) NOT NULL
);

-- to create a table for shifts to be worked.

CREATE TABLE shift(
    shift_id VARCHAR(10) PRIMARY KEY NOT NULL,
    day VARCHAR(10) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);

-- to create a table of shift rotations that matches shifts to staff.

CREATE TABLE rota(
    row_id INT NOT NULL,
    rota_id VARCHAR(20) PRIMARY KEY NOT NULL,
    date TIMESTAMP NOT NULL,
    shift_id VARCHAR(20) UNIQUE NOT NULL,
    staff_id VARCHAR(10) UNIQUE NOT NULL
);

-- to add foreign keys between tables.

ALTER TABLE orders
    ADD CONSTRAINT fk_orders_item_id
        FOREIGN KEY(item_id)
            REFERENCES item(item_id)
                ON DELETE CASCADE
;


ALTER TABLE orders
    ADD CONSTRAINT fk_orders_cust_id
        FOREIGN KEY(cust_id)
            REFERENCES customers (cust_id)
                ON DELETE CASCADE
;

ALTER TABLE orders
    ADD CONSTRAINT fk_orders_add_id
        FOREIGN KEY(add_id)
            REFERENCES address (address_id)
                ON DELETE CASCADE
;

ALTER TABLE recipe 
    ADD CONSTRAINT fk_recipe_recipe_id
        FOREIGN KEY(recipe_id)
            REFERENCES item (sku)
                ON DELETE CASCADE
;

ALTER TABLE recipe
    ADD CONSTRAINT fk_recipe_ing_id
        FOREIGN KEY(ing_id)
            REFERENCES inventory (item_id)
                ON DELETE CASCADE
;

ALTER TABLE ingredients
    ADD CONSTRAINT fk_ingredients_ing_id 
        FOREIGN KEY(ing_id)
            REFERENCES recipe (ing_id)
                ON DELETE CASCADE
;

ALTER TABLE inventory
    ADD CONSTRAINT fk_inventory_item_id
        FOREIGN KEY(item_id)
            REFERENCES item (item_id)
                ON DELETE CASCADE
;

ALTER TABLE staff 
    ADD CONSTRAINT fk_staff_staff_id
        FOREIGN KEY(staff_id)
            REFERENCES rota (staff_id)
                ON DELETE CASCADE
;

ALTER TABLE shift
    ADD CONSTRAINT fk_shift_shift_id
        FOREIGN KEY(shift_id)
            REFERENCES rota (shift_id)
                ON DELETE CASCADE
;

ALTER TABLE rota
    ADD CONSTRAINT fk_rota_date
        FOREIGN KEY(date)
            REFERENCES orders (created_at)
                ON DELETE CASCADE
;