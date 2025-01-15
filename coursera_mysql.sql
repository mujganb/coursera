create schema if not exists coursera_work;
use coursera_work;
SET SQL_SAFE_UPDATES = 0;

SELECT * FROM greenspot;

ALTER TABLE greenspot RENAME COLUMN `Item num` TO item_num;
ALTER TABLE greenspot RENAME COLUMN `description` TO item_description;
ALTER TABLE greenspot RENAME COLUMN `quantity on-hand` TO quantity_available;
ALTER TABLE greenspot RENAME COLUMN `purchase date` TO purchase_date;
ALTER TABLE greenspot RENAME COLUMN `date sold` TO date_sold;
ALTER TABLE greenspot RENAME COLUMN `cust` TO cust_id;
ALTER TABLE greenspot RENAME COLUMN `Quantity` TO quantity_sold;
ALTER TABLE greenspot RENAME COLUMN `item type` TO item_type;
ALTER TABLE greenspot RENAME COLUMN `Location` TO location;
ALTER TABLE greenspot RENAME COLUMN `Unit` TO unit;

SELECT * from greenspot WHERE item_num="";
DELETE FROM greenspot WHERE item_num="";

/*
UPDATE greenspot SET item_description = NULL WHERE item_description NOT REGEXP '^[0-9]+$' OR item_description = '' OR item_description = ' ';
UPDATE greenspot SET quantity_available = NULL WHERE quantity_available NOT REGEXP '^[0-9]+$' OR quantity_available = '' OR quantity_available = ' ';
UPDATE greenspot SET cost = NULL WHERE cost NOT REGEXP '^[0-9]+$' OR cost = '' OR cost = ' ';
UPDATE greenspot SET purchase_date = NULL WHERE purchase_date NOT REGEXP '^[0-9]+$' OR purchase_date = '' OR purchase_date = ' ';
UPDATE greenspot SET vendor = NULL WHERE vendor NOT REGEXP '^[0-9]+$' OR vendor = '' OR vendor = ' ';
UPDATE greenspot SET price = NULL WHERE price NOT REGEXP '^[0-9]+$' OR price = '' OR price = ' ';
UPDATE greenspot SET date_sold = NULL WHERE date_sold NOT REGEXP '^[0-9]+$' OR date_sold = '' OR date_sold = ' ';
UPDATE greenspot SET cust_id = NULL WHERE cust_id NOT REGEXP '^[0-9]+$' OR cust_id = '' OR cust_id = ' ';
UPDATE greenspot SET quantity_sold = NULL WHERE quantity_sold NOT REGEXP '^[0-9]+$' OR quantity_sold = '' OR quantity_sold = ' ';
UPDATE greenspot SET item_type = NULL WHERE item_type NOT REGEXP '^[0-9]+$' OR item_type = '' OR item_type = ' ';
UPDATE greenspot SET location = NULL WHERE location NOT REGEXP '^[0-9]+$' OR location = '' OR location = ' ';
UPDATE greenspot SET unit = NULL WHERE unit NOT REGEXP '^[0-9]+$' OR unit = '' OR unit = ' ';
*/

ALTER TABLE greenspot MODIFY item_num INT;

UPDATE greenspot SET item_description = NULL WHERE item_description = '' OR item_description = ' ';
UPDATE greenspot SET quantity_available = NULL WHERE quantity_available = '' OR quantity_available = ' ';
UPDATE greenspot SET cost = NULL WHERE cost = '' OR cost = ' ';
UPDATE greenspot SET purchase_date = NULL WHERE purchase_date = '' OR purchase_date = ' ';
UPDATE greenspot SET vendor = NULL WHERE vendor = '' OR vendor = ' ';
UPDATE greenspot SET price = NULL WHERE price = '' OR price = ' ';
UPDATE greenspot SET date_sold = NULL WHERE date_sold = '' OR date_sold = ' ';
UPDATE greenspot SET cust_id = NULL WHERE cust_id = '' OR cust_id = ' ';
UPDATE greenspot SET quantity_sold = NULL WHERE quantity_sold = '' OR quantity_sold = ' ';
UPDATE greenspot SET item_type = NULL WHERE item_type = '' OR item_type = ' ';
UPDATE greenspot SET location = NULL WHERE location = '' OR location = ' ';
UPDATE greenspot SET unit = NULL WHERE unit = '' OR unit = ' ';

SELECT * FROM greenspot;

-- Lets create data tables

-- Vendors Table
CREATE TABLE vendors (
    vendor_id INT AUTO_INCREMENT PRIMARY KEY,
    vendor_name VARCHAR(255) NOT NULL
);

-- Items Table
CREATE TABLE items (
    item_num INT PRIMARY KEY,
    item_description VARCHAR(255) NOT NULL,
    item_type VARCHAR(100),
    unit VARCHAR(50),
    vendor_id INT,
    FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id)
);

-- Inventory Table
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    item_num INT NOT NULL,
    quantity_available INT NOT NULL,
    purchase_date DATE,
	cost DECIMAL(10, 2),
    location VARCHAR(255),
    FOREIGN KEY (item_num) REFERENCES items(item_num)
);

-- Sales Table
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    item_num INT NOT NULL,
    date_sold DATE,
    cust_id INT,
    quantity_sold INT NOT NULL,
    price DECIMAL(10, 2),
    FOREIGN KEY (item_num) REFERENCES items(item_num)
);

INSERT INTO vendors (vendor_name)
SELECT DISTINCT vendor -- Assuming no contact_info in the original table
FROM greenspot WHERE vendor IS NOT NULL;


INSERT INTO items (item_num, item_description, item_type, unit, vendor_id)
SELECT DISTINCT
	gs.item_num,
    gs.item_description,
    gs.item_type,
    gs.unit,
    v.vendor_id
FROM 
    greenspot gs
JOIN 
    vendors v ON gs.vendor = v.vendor_name;

-- We need to convert date type
INSERT INTO inventory (item_num, quantity_available, purchase_date, location, cost)
SELECT 
    item_num,
    quantity_available,
    STR_TO_DATE(purchase_date, '%m/%d/%Y'),
    location,
    cost
FROM greenspot;

INSERT INTO sales (item_num, date_sold, cust_id, quantity_sold, price)
SELECT 
    item_num,
    STR_TO_DATE(date_sold, '%m/%d/%Y'),
    cust_id,
    quantity_sold,
    price
FROM greenspot;

SELECT COUNT(*) AS total_rows, COUNT(DISTINCT vendor_name) AS unique_vendors FROM Vendors;

SELECT i.item_description, v.vendor_name 
FROM items i JOIN vendors v ON i.vendor_id = v.vendor_id;

SELECT i.item_description, inv.quantity_available, inv.location
FROM inventory inv JOIN items i ON inv.item_num = i.item_num;

SELECT s.sale_id, i.item_description, s.cust_id, s.quantity_sold
FROM sales s JOIN items i ON s.item_num = i.item_num;

SELECT 
    i.item_num,
    i.item_description,
    inv.quantity_available,
    inv.cost,
    v.vendor_name AS vendor,
    s.price,
    s.date_sold,
    s.cust_id,
    s.quantity_sold,
    i.item_type,
    inv.purchase_date,
    inv.location,
    i.unit
FROM items i
JOIN vendors v ON i.vendor_id = v.vendor_id
JOIN inventory inv ON i.item_num = inv.item_num
LEFT JOIN sales s ON i.item_num = s.item_num;





