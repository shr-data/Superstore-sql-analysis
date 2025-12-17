SELECT
    c.Region,
    COUNT(DISTINCT o.order_id),
    ROUND(SUM(oi.Sales), 2) AS total_sales,
    ROUND(SUM(oi.Profit), 2) AS total_profit
FROM customers c
JOIN orders o
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON oi.order_id = o.order_id
GROUP BY c.Region
ORDER BY total_sales DESC;

WITH orders_2017 AS (
    SELECT DISTINCT
        `Customer ID` AS customer_id
    FROM superstore
    WHERE YEAR(OrderDate) = 2017
)
SELECT
    c.customer_id,
    c.customer_name,
    c.Region
FROM customers c
LEFT JOIN orders_2017 AS o17
    ON c.customer_id = o17.customer_id
WHERE o17.customer_id IS NULL
ORDER BY c.Region, c.customer_name;

SELECT
    o.customer_id,
    c.customer_name,
    o.order_id,
    o.OrderDate,
    ROW_NUMBER() OVER (
        PARTITION BY o.customer_id
        ORDER BY o.OrderDate
    ) AS order_number_for_customer
FROM orders o
JOIN customers c
    ON c.customer_id = o.customer_id
ORDER BY c.customer_name, order_number_for_customer;

SELECT
    o.customer_id,
    c.customer_name,
    o.order_id,
    o.OrderDate,
    ROW_NUMBER() OVER (
        PARTITION BY o.customer_id
        ORDER BY o.OrderDate
    ) AS order_number_for_customer
FROM orders o
JOIN customers c
    ON c.customer_id = o.customer_id
ORDER BY c.customer_name, order_number_for_customer;

WITH customer_order_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        o.order_id,
        o.OrderDate,
        ROUND(SUM(oi.Sales), 2) AS order_sales
    FROM customers c
    JOIN orders o
        ON o.customer_id = c.customer_id
    JOIN order_items oi
        ON oi.order_id = o.order_id
    GROUP BY
        c.customer_id,
        c.customer_name,
        o.order_id,
        o.OrderDate
)
SELECT
    customer_id,
    customer_name,
    order_id,
    OrderDate,
    order_sales,
    SUM(order_sales) OVER (
        PARTITION BY customer_id
        ORDER BY OrderDate
    ) AS running_sales_per_customer
FROM customer_order_sales
ORDER BY customer_name, OrderDate;


WITH product_sales AS (
    SELECT
        Category,
        sub_category,
        product_id,
        ROUND(SUM(Sales), 2) AS total_sales,
        RANK() OVER (
            PARTITION BY Category
            ORDER BY SUM(Sales) DESC
        ) AS sales_rank_in_category
    FROM order_items
    GROUP BY
        Category,
        sub_category,
        product_id
)
SELECT
    Category,
    sub_category,
    product_id,
    total_sales,
    sales_rank_in_category
FROM product_sales
WHERE sales_rank_in_category <= 3
ORDER BY Category, sales_rank_in_category, total_sales DESC;

WITH orders_agg AS (
    SELECT
        o.order_id,
        o.customer_id,
        c.customer_name,
        o.OrderDate,
        ROUND(SUM(oi.Sales), 2) AS order_sales
    FROM orders o
    JOIN customers c
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON oi.order_id = o.order_id
    GROUP BY
        o.order_id,
        o.customer_id,
        c.customer_name,
        o.OrderDate
)
SELECT
    customer_id,
    customer_name,
    order_id,
    OrderDate,
    order_sales,
    ROUND(
        AVG(order_sales) OVER (PARTITION BY customer_id),
        2
    ) AS avg_order_value_for_customer
FROM orders_agg
ORDER BY customer_name, OrderDate;
