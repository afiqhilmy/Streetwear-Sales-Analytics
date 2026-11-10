USE streetwear_db;

SHOW tables;

SELECT * FROM streetwear_sales;

-- 1) product type/brand revenue --
SELECT product_type, brand, ROUND(SUM(amount_usd),2) AS total_revenue_usd
FROM streetwear_sales
GROUP BY product_type, brand
ORDER BY total_revenue_usd DESC;

SELECT brand, ROUND(SUM(amount_usd),2) AS total_revenue_usd
FROM streetwear_sales
GROUP BY brand
ORDER BY total_revenue_usd DESC;


-- 2) preferences by country/region --
CREATE VIEW vw_product_by_country AS
SELECT country, product_type, SUM(quantity) AS total_units_sold, ROUND(SUM(amount_usd), 2) AS total_revenue
FROM streetwear_sales
GROUP BY country, product_type
ORDER BY total_revenue DESC;

SELECT * FROM vw_product_by_country;

WITH RankedSales AS (
    SELECT 
        country,
        product_type,
        ROUND(SUM(amount_usd), 2) AS total_revenue,
        SUM(quantity) AS total_units_sold,
        ROW_NUMBER() OVER (PARTITION BY country ORDER BY SUM(amount_usd) DESC) AS `rank`
    FROM streetwear_sales
    GROUP BY country, product_type
)
SELECT 
    country,
    product_type,
    total_units_sold,
    total_revenue
FROM RankedSales
WHERE `rank` = 1
ORDER BY total_revenue DESC;


-- 3) price compare to revenue --
SELECT product_type, ROUND(SUM(unit_price_usd),2) AS total_price, 
ROUND(AVG(unit_price_usd),2) AS average_price, 
ROUND(SUM(amount_usd),2) AS total_revenue
FROM streetwear_sales
GROUP BY product_type
ORDER BY total_revenue DESC; 

-- 4) Monthly revenue --
CREATE VIEW vw_monthly_revenue AS
SELECT 
    YEAR(date) AS revenue_year,
    DATE_FORMAT(date, '%M') AS revenue_month_name,
    SUM(amount_usd) AS total_amount_usd
FROM streetwear_sales
GROUP BY YEAR(date), MONTH(date), DATE_FORMAT(date, '%M')
ORDER BY total_amount_usd;

SELECT * FROM vw_monthly_revenue;