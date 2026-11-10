CREATE DATABASE IF NOT EXISTS streetwear_db;

USE streetwear_db;

CREATE TABLE jordan_sales (
	transaction_id VARCHAR(30) PRIMARY KEY,
    sale_date DATETIME,
    shoe_model VARCHAR(100),
    colorway VARCHAR(100),
    shoe_condition VARCHAR(100),
    retail_price_usd FLOAT,
    resale_price_usd FLOAT,
    sales_channel VARCHAR(100),
    days_in_inventory INT,
    profit_margin_usd FLOAT
);

show tables;

describe jordan_sales;

SELECT * FROM jordan_sales;

DROP TABLE jordan_sales;

CREATE TABLE streetwear_sales (
	date DATETIME,
    product_name VARCHAR(100),
    product_type VARCHAR(100),
    brand VARCHAR(100),
    gender VARCHAR(100),
    category VARCHAR(100),
    country VARCHAR(100),
    quantity INT,
    unit_price_usd FLOAT,
    amount_usd FLOAT,
    payment_mode VARCHAR(100)
);
    
SELECT * FROM streetwear_sales;

SHOW TABLES;

SELECT shoe_model, SUM(profit_margin_usd) AS total_profits
FROM jordan_sales
GROUP BY shoe_model;

SELECT shoe_model, COUNT(transaction_id) AS number_of_units
FROM jordan_sales
GROUP BY shoe_model;

SELECT product_name, COUNT(product_name) AS number_of_units
FROM streetwear_sales
GROUP BY product_name;

SELECT brand, COUNT(brand) AS number_of_units
FROM streetwear_sales
GROUP BY brand;