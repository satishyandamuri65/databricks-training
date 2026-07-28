#Customers_Table_Schema :

CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR(100),
    city VARCHAR(100)
);

INSERT INTO customers (customer_id, customer_name, city) VALUES
(101, 'Alice', 'Hyderabad'),
(102, 'Bob', 'Bangalore'),
(103, 'Charlie', 'Chennai'),
(104, 'David', 'Hyderabad'),
(105, 'Eva', 'Mumbai'),
(106, 'Frank', 'Delhi'),
(107, 'Grace', 'Pune'),
(108, 'Henry', 'Kolkata'),
(109, 'Ivy', 'Hyderabad'),
(110, 'Jack', 'Bangalore'),
(111, 'Kevin', 'Chennai'),
(112, 'Lily', 'Mumbai'),
(113, 'Mason', 'Delhi'),
(114, 'Nancy', 'Pune'),
(115, 'Oliver', 'Hyderabad'),
(116, 'Priya', 'Chennai'),
(117, 'Queen', 'Bangalore'),
(118, 'Ryan', 'Mumbai'),
(119, 'Sophia', 'Delhi'),
(120, 'Tom', 'Hyderabad'),
(121, 'Uma', 'Chennai'),
(122, 'Victor', 'Bangalore'),
(123, 'William', 'Pune'),
(125, 'Zara', 'Hyderabad');


#Orders_Table_Schema :

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_amount DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

INSERT INTO orders (order_id, customer_id, order_amount) VALUES
(1001,101,250.00),
(1002,101,450.00),
(1003,102,300.00),
(1004,103,700.00),
(1005,103,150.00),
(1006,103,400.00),
(1007,105,500.00),
(1008,105,250.00),
(1009,101,100.00),
(1010,107,350.00),
(1011,108,900.00),
(1012,109,150.00),
(1013,110,200.00),
(1014,111,450.00),
(1015,112,600.00),
(1016,113,750.00),
(1017,114,300.00),
(1018,115,550.00),
(1019,116,800.00),
(1020,117,650.00),
(1021,118,1000.00),
(1022,119,450.00),
(1023,120,300.00),
(1024,107,220.00),
(1025,108,480.00),
(1026,109,510.00),
(1027,110,620.00),
(1028,111,280.00),
(1029,112,900.00),
(1030,113,430.00),
(1031,114,210.00),
(1032,115,340.00),
(1033,116,470.00),
(1034,117,530.00),
(1035,118,610.00),
(1036,119,720.00),
(1037,120,810.00),
(1038,101,390.00),
(1039,102,560.00),
(1040,103,430.00),
(1041,105,270.00),
(1042,107,640.00),
(1043,108,510.00),
(1044,111,320.00),
(1045,115,450.00),
(1046,116,280.00),
(1047,118,700.00),
(1048,120,520.00),
(1049,119,360.00),
(1050,117,410.00),
(1051,121,650.00),
(1052,121,700.00),
(1053,122,420.00),
(1054,123,550.00),
(1056,125,900.00),
(1057,125,250.00),
(1058,108,900.00),
(1058,108,900.00),
(1059,115,620.00);


#Exercise 1: Total Order Amount For Each Customer 

SELECT
    customer_id,
    SUM(order_amount) AS total_spend
FROM orders
GROUP BY customer_id;

#Exercise 2: Top 3 Customers by Total Spend 

SELECT
    customer_id,
    SUM(order_amount) AS total_spend
FROM orders
GROUP BY customer_id
ORDER BY total_spend DESC
LIMIT 3;

#Exercise 3: Customers with No Orders

SELECT
    c.customer_id,
    c.customer_name,
    c.city
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

#Exercise 4: City-wise Total Revenue

SELECT
    c.city,
    SUM(o.order_amount) AS total_revenue
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.city;

#Exercise 5: Average Order Amount per Customer

SELECT
    customer_id,
    AVG(order_amount) AS average_order_amount
FROM orders
GROUP BY customer_id;

#Exercise 6: Customers with More Than One Order

SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders 
GROUP BY customer_id
HAVING COUNT(order_id) > 1;

#Exercise 7: Sort Customers by Total Spend (Descending)

SELECT
    customer_id,
    SUM(order_amount) AS total_spend
FROM orders
GROUP BY customer_id
ORDER BY total_spend DESC;

