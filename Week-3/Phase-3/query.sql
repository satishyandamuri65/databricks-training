#Business Pipeline Exercise 1
#Daily Sales

SELECT
sale_date,
SUM(amount) AS daily_sales
FROM sales
GROUP BY sale_date;

#Business Pipeline Exercise 2
#City-wise Revenue

SELECT
c.city,
SUM(o.amount) AS total_revenue
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.city;

#Business Pipeline Exercise 3
#Repeat Customers (>2 Orders)

SELECT
customer_id,
COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 2;

#Business Pipeline Exercise 4
#Highest Spending Customer in Each City

SELECT *
FROM
(
    SELECT
        c.customer_id,
        c.name,
        c.city,
        SUM(o.amount) AS total_spend,
        ROW_NUMBER() OVER(
            PARTITION BY c.city
            ORDER BY SUM(o.amount) DESC
        ) AS rank
    FROM customers c
    JOIN orders o
    ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.name,
        c.city
) t
WHERE rank = 1;

#Business Pipeline Exercise 5
#Final Reporting Table

SELECT
c.customer_id,
c.name,
c.city,
SUM(o.amount) AS total_spend,
COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY
c.customer_id,
c.name,
c.city;
