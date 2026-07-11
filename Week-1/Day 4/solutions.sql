-- schema code:
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;
 
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(100),
    manager_id INT NULL,
    salary DECIMAL(10,2),
    hire_date DATE
);
 
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100)
);
 
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
 
INSERT INTO employees VALUES
(1, 'Alice Johnson', 'Sales', NULL, 70000, '2020-01-15'),
(2, 'Bob Smith', 'Sales', 1, 65000, '2021-03-20'),
(3, 'Charlie Brown', 'IT', NULL, 90000, '2019-07-01'),
(4, 'Diana Prince', 'IT', 3, 95000, '2018-11-11'),
(5, 'Ethan Hunt', 'HR', NULL, 60000, '2022-02-10'),
(6, 'Fiona Green', 'HR', 5, 58000, '2023-05-12'),
(7, 'George Miller', 'Finance', NULL, 85000, '2017-09-18'),
(8, 'Hannah Lee', 'Finance', 7, 82000, '2021-08-30');
 
INSERT INTO customers VALUES
(1, 'Acme Corp', 'New York'),
(2, 'Tech Solutions', 'Chicago'),
(3, 'Global Retail', 'Dallas'),
(4, 'Blue Sky Ltd', 'Seattle'),
(5, 'NextGen Systems', 'Boston');
 
INSERT INTO orders VALUES
(101, 1, 1, '2024-01-10', 500),
(102, 2, 2, '2024-01-11', 700),
(103, 1, 1, '2024-01-15', 1200),
(104, 3, 3, '2024-01-18', 300),
(105, 4, 4, '2024-01-20', 900),
(106, 5, 2, '2024-01-25', 1500),
(107, 2, 1, '2024-02-01', 650),
(108, 1, 3, '2024-02-05', 1100),
(109, 3, 4, '2024-02-10', 400),
(110, 4, 2, '2024-02-15', 950),
(111, 5, 1, '2024-02-20', 2000),
(112, 1, 4, '2024-02-25', 750);
 
-- assign row numbers to employees ordered by salary highest to lowest
select employee_name, department, salary,
row_number() over (order by salary desc) as row_num
from employees;
 
-- rank employees by salary using RANK()
select employee_name, department, salary,
rank() over (order by salary desc) as salary_rank
from employees;
 
-- rank employees by salary using DENSE_RANK()
select employee_name, department, salary,
dense_rank() over (order by salary desc) as dense_rank
from employees;
 
-- find top 3 highest paid employees
select employee_name, department, salary, salary_rank
from (
    select employee_name, department, salary,
    rank() over (order by salary desc) as salary_rank
    from employees
) ranked
where salary_rank <= 3;
 
-- rank employees within each department by salary
select employee_name, department, salary,
rank() over (partition by department order by salary desc) as dept_rank
from employees;
 
-- show highest salary in each department
select distinct department,
max(salary) over (partition by department) as highest_salary
from employees;
 
-- running total of order amounts by date
select order_id, order_date, total_amount,
sum(total_amount) over (order by order_date) as running_total
from orders;
 
-- cumulative sales for each employee
select order_id, employee_id, order_date, total_amount,
sum(total_amount) over (partition by employee_id order by order_date) as cumulative_sales
from orders;
 
-- show previous order amount for each customer using LAG()
select order_id, customer_id, order_date, total_amount,
lag(total_amount) over (partition by customer_id order by order_date) as prev_order_amount
from orders;
 
-- show next order amount for each customer using LEAD()
select order_id, customer_id, order_date, total_amount,
lead(total_amount) over (partition by customer_id order by order_date) as next_order_amount
from orders;
 
-- difference between current and previous order amount
select order_id, customer_id, order_date, total_amount,
total_amount - lag(total_amount) over (partition by customer_id order by order_date) as amount_diff
from orders;
 
-- moving average of last 3 orders
select order_id, order_date, total_amount,
avg(total_amount) over (order by order_date rows between 2 preceding and current row) as moving_avg_3
from orders;
 
-- divide employees into 4 salary quartiles using NTILE
select employee_name, department, salary,
ntile(4) over (order by salary desc) as salary_quartile
from employees;
 
-- find the first order placed by each customer
select customer_id, order_id, order_date, total_amount
from (
    select customer_id, order_id, order_date, total_amount,
    row_number() over (partition by customer_id order by order_date asc) as rn
    from orders
) ranked
where rn = 1;
 
-- find the latest order placed by each customer
select customer_id, order_id, order_date, total_amount
from (
    select customer_id, order_id, order_date, total_amount,
    row_number() over (partition by customer_id order by order_date desc) as rn
    from orders
) ranked
where rn = 1;