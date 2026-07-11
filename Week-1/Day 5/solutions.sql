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


-- show employee salaries with department average salary
select employee_name, department, salary,
avg(salary) over (partition by department) as dept_avg_salary
from employees;

-- find employees earning above their department average
select employee_name, department, salary, dept_avg_salary
from (
    select employee_name, department, salary,
    avg(salary) over (partition by department) as dept_avg_salary
    from employees
) dept_data
where salary > dept_avg_salary;

-- calculate total payroll per department
select employee_name, department, salary,
sum(salary) over (partition by department) as dept_payroll
from employees;

-- percentage of each employee salary within their department
select employee_name, department, salary,
round(salary / sum(salary) over (partition by department) * 100, 2) as salary_pct
from employees;

-- show total employee count alongside every row
select employee_name, department, salary,
count(*) over () as total_employees
from employees;


-- CTEs
-- total sales per employee using a CTE
with employee_sales as (
    select employee_id, sum(total_amount) as total_sales
    from orders
    group by employee_id
)
select e.employee_name, e.department, es.total_sales
from employees e
join employee_sales es on e.employee_id = es.employee_id;

-- employees whose sales exceed the company average
with employee_sales as (
    select employee_id, sum(total_amount) as total_sales
    from orders
    group by employee_id
),
avg_sales as (
    select avg(total_sales) as company_avg
    from employee_sales
)
select e.employee_name, e.department, es.total_sales, a.company_avg
from employees e
join employee_sales es on e.employee_id = es.employee_id
join avg_sales a on es.total_sales > a.company_avg;

-- customer total spending and rankings using multiple CTEs
with customer_spending as (
    select customer_id, sum(total_amount) as total_spent
    from orders
    group by customer_id
),
customer_ranked as (
    select customer_id, total_spent,
    rank() over (order by total_spent desc) as spending_rank
    from customer_spending
)
select c.customer_name, c.city, cr.total_spent, cr.spending_rank
from customers c
join customer_ranked cr on c.customer_id = cr.customer_id;

-- recursive CTE to generate numbers 1 to 10
with recursive numbers as (
    select 1 as n
    union all
    select n + 1 from numbers where n < 10
)
select n from numbers;

-- recursive CTE to show employee hierarchy
with recursive emp_hierarchy as (
    select employee_id, employee_name, manager_id, department, 1 as level
    from employees
    where manager_id is null
    union all
    select e.employee_id, e.employee_name, e.manager_id, e.department, eh.level + 1
    from employees e
    join emp_hierarchy eh on e.manager_id = eh.employee_id
)
select employee_id, employee_name, manager_id, department, level
from emp_hierarchy
order by level, employee_id;

-- filter orders above the average order amount using a CTE
with avg_order as (
    select avg(total_amount) as avg_amount from orders
)
select o.order_id, o.customer_id, o.total_amount, a.avg_amount
from orders o
join avg_order a on o.total_amount > a.avg_amount;

-- rank customers by total spending using CTE + window function
with customer_totals as (
    select customer_id, sum(total_amount) as total_spent
    from orders
    group by customer_id
)
select c.customer_name, ct.total_spent,
rank() over (order by ct.total_spent desc) as spending_rank
from customers c
join customer_totals ct on c.customer_id = ct.customer_id;

-- second highest salary in each department
select department, employee_name, salary
from (
    select department, employee_name, salary,
    dense_rank() over (partition by department order by salary desc) as dept_rank
    from employees
) ranked
where dept_rank = 2;

-- difference between each employee salary and their department max
select employee_name, department, salary,
max(salary) over (partition by department) as dept_max_salary,
max(salary) over (partition by department) - salary as diff_from_max
from employees;

-- top performing employee per department based on total sales
with emp_sales as (
    select employee_id, sum(total_amount) as total_sales
    from orders
    group by employee_id
),
emp_ranked as (
    select e.employee_id, e.employee_name, e.department, es.total_sales,
    rank() over (partition by e.department order by es.total_sales desc) as sales_rank
    from employees e
    join emp_sales es on e.employee_id = es.employee_id
)
select employee_name, department, total_sales
from emp_ranked
where sales_rank = 1;


-- bonus: monthly sales trends with running totals, LAG and percentage growth
with monthly_sales as (
    select date_format(order_date, '%Y-%m') as month,
    sum(total_amount) as monthly_total
    from orders
    group by date_format(order_date, '%Y-%m')
),
monthly_with_lag as (
    select month, monthly_total,
    sum(monthly_total) over (order by month) as running_total,
    lag(monthly_total) over (order by month) as prev_month_total
    from monthly_sales
)
select month, monthly_total, running_total, prev_month_total,
round((monthly_total - prev_month_total) / prev_month_total * 100, 2) as pct_growth
from monthly_with_lag;