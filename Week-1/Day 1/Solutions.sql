-- Schema code
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    salary DECIMAL(10, 2),
    department_id INT,
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

INSERT INTO Department (department_id, name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
(1, 'John Doe', 28, 50000.00, 1, '2020-01-15'),
(2, 'Jane Smith', 34, 60000.00, 2, '2019-07-23'),
(3, 'Bob Brown', 45, 80000.00, 1, '2018-02-12'),
(4, 'Alice Blue', 25, 45000.00, 3, '2021-03-22'),
(5, 'Charlie P.', 29, 50000.00, 2, '2019-12-01'),
(6, 'David Green', 38, 70000.00, 4, '2022-05-18'),
(7, 'Eve Black', 40, 55000.00, 3, '2021-08-30');

INSERT INTO Project (project_id, name, department_id) VALUES
(1, 'Project Alpha', 1),
(2, 'Project Beta', 2),
(3, 'Project Gamma', 1),
(4, 'Project Delta', 3),
(5, 'Project Epsilon', 4),
(6, 'Project Zeta', 4),
(7, 'Project Eta', 3);

INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
(8, 'Frank White', 32, 48000.00, NULL, '2021-07-10'),  -- Employee without a department
(9, 'Grace Kelly', 27, 65000.00, 1, '2018-11-13'),
(10, 'Hannah Lee', 30, 53000.00, 4, '2020-02-25');

INSERT INTO Project (project_id, name, department_id) VALUES
(8, 'Project Theta', 1),
(9, 'Project Iota', NULL);  -- Project without a department

-- 1. Basic Queries
-- select all columns from the Employee table.
SELECT * FROM  Employee;
-- select only name and salary columns from the Employee table.
SELECT name,salary FROM Employee;
-- select employees who are older than 30.
SELECT * FROM Employee WHERE age > 30 ;
-- select the names of all departments.
SELECT name FROM Department;
-- select employees who work in the IT department.
SELECT * FROM Employee WHERE department_id = 1;

-- 2. String Matching Queries
-- select employees whose names start with 'J'.
SELECT * FROM Employee WHERE name LIKE 'J%';
-- select employees whose names end with 'e'.
SELECT * FROM Employee WHERE name LIKE '%e';
-- select employees whose names contain 'a'.
SELECT * FROM Employee WHERE name LIKE '%a%';
-- select employees whose names are exactly 9 characters long.
SELECT * FROM Employee WHERE LENGTH(name) = 9;
-- select employees whose names have 'o' as the second character.
SELECT * FROM Employee WHERE name LIKE '_o%';

-- 3. Date Queries
-- select employees hired in the year 2020.
SELECT * FROM Employee WHERE YEAR(hire_date) = 2020;
-- select employees hired in January of any year.
SELECT * FROM Employee WHERE MONTH(hire_date) = 1;
-- select employees hired before 2019.
SELECT * FROM Employee WHERE YEAR(hire_date) < 2019;
-- select employees hired on or after March 1, 2021.
SELECT * FROM Employee WHERE hire_date >= '2021-03-01';
-- select employees hired in the last 2 years.
SELECT * FROM Employee WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

-- 4. Aggregate Queries
-- select the total salary of all employees.
SELECT SUM(salary) AS total_salary FROM Employee;
-- select the average salary of employees.
SELECT AVG(salary) AS avg_salary FROM Employee;
-- select the minimum salary in the Employee table.
SELECT MIN(salary) AS min_salary FROM Employee;
-- select the number of employees in each department.
SELECT department_id, COUNT(*) AS employee_count
FROM Employee
GROUP BY department_id;
-- select the average salary of employees in each department.
SELECT department_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id;


-- 5. Group by Queries
-- select the total salary for each department.
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id;
-- select the average age of employees in each department.
SELECT department_id, AVG(age) AS avg_age
FROM Employee
GROUP BY department_id;
-- select the number of employees hired in each year.
SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS employee_count
FROM Employee
GROUP BY YEAR(hire_date)
ORDER BY hire_year;
-- select the highest salary in each department.
SELECT department_id, MAX(salary) AS max_salary
FROM Employee
GROUP BY department_id;

-- select the department with the highest average salary.
SELECT department_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id
ORDER BY avg_salary DESC
LIMIT 1;

-- 6. Having Queries
-- select departments with more than 2 employees.
SELECT department_id, COUNT(*) AS employee_count
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;

-- select departments with an average salary greater than 55000.
SELECT department_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;

-- select years with more than 1 employee hired.
SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS employee_count
FROM Employee
GROUP BY YEAR(hire_date)
HAVING COUNT(*) > 1;

-- select departments with a total salary expense less than 100000.
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id
HAVING SUM(salary) < 100000;

-- select departments with the maximum salary above 75000.
SELECT department_id, MAX(salary) AS max_salary
FROM Employee
GROUP BY department_id
HAVING MAX(salary) > 75000;