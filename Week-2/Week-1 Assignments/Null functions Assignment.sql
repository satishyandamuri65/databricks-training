DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;

CREATE TABLE Employees (
    emp_id INT,
    name VARCHAR(50),
    salary INT,
    bonus INT,
    manager_id INT
);

INSERT INTO Employees VALUES
(1, 'Amit', 50000, NULL, 101),
(2, 'John', NULL, 5000, 102),
(3, 'Sara', 60000, NULL, NULL),
(4, 'David', NULL, NULL, 103),
(5, 'Priya', 45000, 3000, 101),
(6, 'Kiran', NULL, NULL, NULL),
(7, 'Ravi', 70000, 7000, 102),
(8, 'Neha', NULL, 2000, NULL);

CREATE TABLE Orders (
    order_id INT,
    customer_name VARCHAR(50),
    amount INT,
    discount INT,
    coupon_code VARCHAR(20)
);

INSERT INTO Orders VALUES
(101, 'Amit', 1000, NULL, 'DISC10'),
(102, 'John', NULL, 50, NULL),
(103, 'Sara', 2000, NULL, 'DISC20'),
(104, 'David', NULL, NULL, NULL),
(105, 'Priya', 1500, 100, NULL),
(106, 'Kiran', NULL, NULL, 'DISC5'),
(107, 'Ravi', 3000, NULL, NULL),
(108, 'Neha', NULL, 200, 'DISC15');

CREATE TABLE Products (
    product_id INT,
    product_name VARCHAR(50),
    price INT,
    category VARCHAR(50),
    stock INT
);

INSERT INTO Products VALUES
(1, 'Laptop', 50000, 'Electronics', 10),
(2, 'Phone', NULL, 'Electronics', NULL),
(3, 'Tablet', 30000, NULL, 5),
(4, 'Headphones', NULL, NULL, NULL),
(5, 'Monitor', 20000, 'Electronics', 0),
(6, 'Keyboard', NULL, 'Accessories', 15),
(7, 'Mouse', 500, NULL, NULL),
(8, 'Printer', NULL, 'Electronics', 3);


-- LEVEL 1: BASIC

-- Show all employees whose salary is NULL
SELECT * FROM Employees WHERE salary IS NULL;

-- Show all orders where discount is NOT NULL
SELECT * FROM Orders WHERE discount IS NOT NULL;

-- Get products where category is NULL
SELECT * FROM Products WHERE category IS NULL;

-- Count number of employees with NULL manager_id
SELECT COUNT(*) AS no_manager_count FROM Employees WHERE manager_id IS NULL;


-- LEVEL 2: ISNULL

-- Replace NULL salary with 0
SELECT name, ISNULL(salary, 0) AS salary FROM Employees;

-- Replace NULL bonus with 1000
SELECT name, ISNULL(bonus, 1000) AS bonus FROM Employees;

-- Show order amount, if NULL replace with 500
SELECT customer_name, ISNULL(amount, 500) AS amount FROM Orders;

-- Replace NULL stock with 0
SELECT product_name, ISNULL(stock, 0) AS stock FROM Products;


-- LEVEL 3: COALESCE

-- Show employee earnings: use salary, if NULL use bonus
SELECT name, COALESCE(salary, bonus) AS earnings FROM Employees;

-- Show first available value: salary > bonus > 0
SELECT name, COALESCE(salary, bonus, 0) AS earnings FROM Employees;

-- Show product price, default to 1000 if NULL
SELECT product_name, COALESCE(price, 1000) AS price FROM Products;

-- Get customer payment: amount > discount > 0
SELECT customer_name, COALESCE(amount, discount, 0) AS payment FROM Orders;


-- LEVEL 4: NULLIF

-- Convert salary to NULL if salary = 0
SELECT name, NULLIF(salary, 0) AS salary FROM Employees;

-- Convert discount to NULL if discount = 0
SELECT customer_name, NULLIF(discount, 0) AS discount FROM Orders;

-- Use NULLIF to avoid divide by zero
SELECT customer_name, amount / NULLIF(discount, 0) AS ratio FROM Orders;

-- Replace coupon_code with NULL if it is 'DISC10'
SELECT customer_name, NULLIF(coupon_code, 'DISC10') AS coupon_code FROM Orders;


-- LEVEL 5: REAL-TIME SCENARIOS

-- Calculate total earnings: salary + bonus (handle NULL properly)
SELECT name, COALESCE(salary, 0) + COALESCE(bonus, 0) AS total_earnings FROM Employees;

-- Show employees where both salary AND bonus are NULL
SELECT * FROM Employees WHERE salary IS NULL AND bonus IS NULL;

-- Show products where price is NULL but category is NOT NULL
SELECT * FROM Products WHERE price IS NULL AND category IS NOT NULL;

-- Show orders where both amount and discount are NULL
SELECT * FROM Orders WHERE amount IS NULL AND discount IS NULL;


-- LEVEL 6: ADVANCED

-- Show employee income using COALESCE
SELECT name, COALESCE(salary, bonus, 1000) AS income FROM Employees;

-- Replace empty discount with NULL using NULLIF
SELECT customer_name, NULLIF(discount, 0) AS discount FROM Orders;

-- Show final payable amount: amount - discount (handle NULL)
SELECT customer_name,
COALESCE(amount, 0) - COALESCE(discount, 0) AS final_amount
FROM Orders;

-- Find employees where salary is NULL but manager exists
SELECT * FROM Employees WHERE salary IS NULL AND manager_id IS NOT NULL;