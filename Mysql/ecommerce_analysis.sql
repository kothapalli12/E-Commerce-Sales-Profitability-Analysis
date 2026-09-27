create database ecommerce_analysis;
use ecommerce_analysis;
select * from data_clean;
select count(*) from data_clean;
USE ecommerce_analysis;

SELECT COUNT(*) AS total_records
FROM data_clean;

SELECT *
FROM data_clean
LIMIT 10;

SELECT SUM(sales) AS total_sales
FROM data_clean;

SELECT SUM(profit) AS total_profit
FROM data_clean;

SELECT SUM(quantity) AS total_quantity
FROM data_clean;

SELECT COUNT(*) AS total_transactions
FROM data_clean;

SELECT
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM data_clean;

SELECT
    category,
    SUM(sales) AS total_sales
FROM data_clean
GROUP BY category
ORDER BY total_sales DESC;

SELECT
    category,
    SUM(profit) AS total_profit
FROM data_clean
GROUP BY category
ORDER BY total_profit DESC;

SELECT
    category,
    SUM(quantity) AS total_quantity
FROM data_clean
GROUP BY category
ORDER BY total_quantity DESC;

SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity,
    COUNT(*) AS total_transactions
FROM data_clean
GROUP BY category
ORDER BY total_sales DESC;

SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM data_clean
GROUP BY category
ORDER BY profit_margin DESC;

SELECT
    region,
    SUM(sales) AS total_sales
FROM data_clean
GROUP BY region
ORDER BY total_sales DESC;

SELECT
    region,
    SUM(profit) AS total_profit
FROM data_clean
GROUP BY region
ORDER BY total_profit DESC;

SELECT
    region,
    SUM(quantity) AS total_quantity
FROM data_clean
GROUP BY region
ORDER BY total_quantity DESC;

SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity,
    COUNT(*) AS total_transactions
FROM data_clean
GROUP BY region
ORDER BY total_sales DESC;

SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM data_clean
GROUP BY region
ORDER BY profit_margin DESC;

SELECT
    product_name,
    SUM(sales) AS total_sales
FROM data_clean
GROUP BY product_name
ORDER BY total_sales DESC;

SELECT
    product_name,
    SUM(sales) AS total_sales
FROM data_clean
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

SELECT
    product_name,
    SUM(profit) AS total_profit
FROM data_clean
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;

SELECT
    product_name,
    SUM(quantity) AS total_quantity
FROM data_clean
GROUP BY product_name
ORDER BY total_quantity DESC
LIMIT 10;

SELECT
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity,
    COUNT(*) AS total_transactions
FROM data_clean
GROUP BY product_name
ORDER BY total_sales DESC;

SELECT
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM data_clean
GROUP BY product_name
ORDER BY profit_margin DESC;

SELECT
    YEAR(order_date) AS year,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM data_clean
GROUP BY YEAR(order_date)
ORDER BY year;

SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM data_clean
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    year,
    month;
    
    SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    MONTHNAME(order_date) AS month_name,
    SUM(sales) AS total_sales,
    round(SUM(profit),2) AS total_profit
FROM data_clean
GROUP BY
    YEAR(order_date),
    MONTH(order_date),
    MONTHNAME(order_date)
ORDER BY
    year,
    month;
    
    SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(profit) / SUM(sales) * 100,
        2
    ) AS profit_margin
FROM data_clean
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    year,
    month;
    
    SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(sales) AS total_sales
FROM data_clean
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY total_sales DESC
LIMIT 1;

SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(profit) AS total_profit
FROM data_clean
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY total_profit DESC
LIMIT 1;

SELECT
    product_name,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM (
    SELECT
        product_name,
        SUM(sales) AS total_sales
    FROM data_clean
    GROUP BY product_name
) AS product_summary
ORDER BY sales_rank;

SELECT *
FROM (
    SELECT
        product_name,
        total_sales,
        RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
    FROM (
        SELECT
            product_name,
            SUM(sales) AS total_sales
        FROM data_clean
        GROUP BY product_name
    ) AS product_summary
) AS ranked_products
WHERE sales_rank <= 5;

SELECT
    category,
    product_name,
    total_sales,
    RANK() OVER (
        PARTITION BY category
        ORDER BY total_sales DESC
    ) AS category_rank
FROM (
    SELECT
        category,
        product_name,
        SUM(sales) AS total_sales
    FROM data_clean
    GROUP BY category, product_name
) AS product_summary
ORDER BY category, category_rank;

SELECT *
FROM (
    SELECT
        category,
        product_name,
        total_sales,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS category_rank
    FROM (
        SELECT
            category,
            product_name,
            SUM(sales) AS total_sales
        FROM data_clean
        GROUP BY category, product_name
    ) AS product_summary
) AS ranked_products
WHERE category_rank <= 3
ORDER BY category, category_rank;

			