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

-- 7. ORDER BY QUERIES (Q31 - Q35)
-- Select all employees ordered by their salary in ascending order.
SELECT * FROM Employee ORDER BY salary ASC;
-- Select all employees ordered by their age in descending order.
SELECT * FROM Employee ORDER BY age DESC;
-- Select all employees ordered by their hire date in ascending order.
SELECT * FROM Employee ORDER BY hire_date ASC;
-- Select employees ordered by their department and then by their salary.
SELECT * FROM Employee ORDER BY department_id ASC, salary ASC;
-- Select departments ordered by the total salary of their employees.
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id
ORDER BY total_salary ASC;

-- 8. JOIN QUERIES (Q36 - Q45)
-- Select employee names along with their department names.
SELECT e.name AS employee_name, d.name AS department_name
FROM Employee e
INNER JOIN Department d ON e.department_id = d.department_id;
-- Select project names along with the department names they belong to.
SELECT p.name AS project_name, d.name AS department_name
FROM Project p
INNER JOIN Department d ON p.department_id = d.department_id;
-- Select employee names and their corresponding project names.
SELECT e.name AS employee_name, p.name AS project_name
FROM Employee e
INNER JOIN Department d ON e.department_id = d.department_id
INNER JOIN Project p ON d.department_id = p.department_id;
-- Select all employees and their departments, including those without a department.
SELECT e.name AS employee_name, d.name AS department_name
FROM Employee e
LEFT JOIN Department d ON e.department_id = d.department_id;
-- Select all departments and their employees, including departments without employees.
SELECT d.name AS department_name, e.name AS employee_name
FROM Department d
LEFT JOIN Employee e ON d.department_id = e.department_id;
-- Select employees who are not assigned to any project.
SELECT e.name AS employee_name
FROM Employee e
LEFT JOIN Project p ON e.department_id = p.department_id
WHERE p.project_id IS NULL;
-- Select employees and the number of projects their department is working on.
SELECT e.name AS employee_name, COUNT(p.project_id) AS project_count
FROM Employee e
LEFT JOIN Project p ON e.department_id = p.department_id
GROUP BY e.emp_id, e.name;
-- Select the departments that have no employees.
SELECT d.name AS department_name
FROM Department d
LEFT JOIN Employee e ON d.department_id = e.department_id
WHERE e.emp_id IS NULL;
-- Select employee names who share the same department with 'John Doe'.
SELECT e.name AS employee_name
FROM Employee e
INNER JOIN Employee jd ON e.department_id = jd.department_id
WHERE jd.name = 'John Doe'
AND e.name != 'John Doe';
-- Select the department name with the highest average salary.
SELECT d.name AS department_name, AVG(e.salary) AS avg_salary
FROM Employee e
INNER JOIN Department d ON e.department_id = d.department_id
GROUP BY d.department_id, d.name
ORDER BY avg_salary DESC
LIMIT 1;

-- 9. NESTED AND CORRELATED QUERIES (Q46 - Q55)
-- Select the employee with the highest salary.
SELECT * FROM Employee
WHERE salary = (SELECT MAX(salary) FROM Employee);
-- Select employees whose salary is above the average salary.
SELECT * FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee);
-- Select the second highest salary from the Employee table.
SELECT MAX(salary) AS second_highest_salary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);
-- Select the department with the most employees.
SELECT department_id, COUNT(*) AS employee_count
FROM Employee
GROUP BY department_id
ORDER BY employee_count DESC
LIMIT 1;
-- Select employees who earn more than the average salary of their department.
SELECT e.name, e.salary, e.department_id
FROM Employee e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM Employee e2
    WHERE e2.department_id = e.department_id
);
-- Select the nth highest salary (3rd highest).
SELECT DISTINCT salary AS third_highest_salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 2;
-- Select employees who are older than all employees in the HR department.
SELECT * FROM Employee
WHERE age > (SELECT MAX(age) FROM Employee WHERE department_id = 2);
-- Select departments where the average salary is greater than 55000.
SELECT department_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;
-- Select employees who work in a department with at least 2 projects.
SELECT e.name AS employee_name
FROM Employee e
WHERE e.department_id IN (
    SELECT department_id
    FROM Project
    GROUP BY department_id
    HAVING COUNT(project_id) >= 2
);
-- Select employees who were hired on the same date as 'Jane Smith'.
SELECT * FROM Employee
WHERE hire_date = (SELECT hire_date FROM Employee WHERE name = 'Jane Smith')
AND name != 'Jane Smith';

-- 10. COMBINED MODERATE DIFFICULTY QUERIES (Q56 - Q65)
-- Select the total salary of employees hired in the year 2020.
SELECT SUM(salary) AS total_salary
FROM Employee
WHERE YEAR(hire_date) = 2020;
-- Select the average salary of employees in each department, ordered by average salary descending.
SELECT department_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id
ORDER BY avg_salary DESC;
-- Select departments with more than 1 employee and an average salary greater than 55000.
SELECT department_id, COUNT(*) AS employee_count, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 1 AND AVG(salary) > 55000;
-- Select employees hired in the last 2 years, ordered by their hire date.
SELECT * FROM Employee
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
ORDER BY hire_date ASC;
-- Select the total number of employees and the average salary for departments with more than 2 employees.
SELECT department_id, COUNT(*) AS total_employees, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;
-- Select the name and salary of employees whose salary is above the average salary of their department.
SELECT e.name, e.salary
FROM Employee e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM Employee e2
    WHERE e2.department_id = e.department_id
);
-- Select the names of employees who are hired on the same date as the oldest employee in the company.
SELECT name
FROM Employee
WHERE hire_date = (SELECT MIN(hire_date) FROM Employee);
-- Select department names along with the total number of projects they are working on, ordered by number of projects.
SELECT d.name AS department_name, COUNT(p.project_id) AS project_count
FROM Department d
LEFT JOIN Project p ON d.department_id = p.department_id
GROUP BY d.department_id, d.name
ORDER BY project_count DESC;
-- Select the employee name with the highest salary in each department.
SELECT e.name AS employee_name, e.department_id, e.salary
FROM Employee e
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM Employee e2
    WHERE e2.department_id = e.department_id
);
-- Select the names and salaries of employees who are older than the average age of employees in their department.
SELECT e.name, e.salary
FROM Employee e
WHERE e.age > (
    SELECT AVG(e2.age)
    FROM Employee e2
    WHERE e2.department_id = e.department_id
);