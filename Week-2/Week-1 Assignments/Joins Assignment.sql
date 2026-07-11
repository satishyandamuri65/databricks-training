DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT,
    dept_id INT
);
INSERT INTO employees (emp_id, emp_name, manager_id, dept_id) VALUES
(1, 'Karthik', NULL, 1),
(2, 'Ajay', 1, 1),
(3, 'Vijay', 1, 2),
(4, 'Vinay', 2, 2),
(5, 'Meena', 3, 3),
(6, 'Veer', NULL, 4),
(7, 'Keerthi', 4, 5),
(8, 'Priya', 4, 5);

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);
INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Sales');

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    emp_id INT
);
INSERT INTO projects (project_id, project_name, emp_id) VALUES
(1, 'Project A', 1),
(2, 'Project B', 2),
(3, 'Project C', 3),
(4, 'Project D', 4),
(5, 'Project E', 5);


-- 1. Employees and their managers, including those without managers
SELECT e.emp_name AS employee, m.emp_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

-- 2. All employees and their departments, including those without a department
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

-- 3. Employees who report to a manager with their manager name
SELECT e.emp_name AS employee, m.emp_name AS manager
FROM employees e
INNER JOIN employees m ON e.manager_id = m.emp_id;

-- 4. All departments including those with no employees
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name;

-- 5. Employees who do not belong to any department
SELECT e.emp_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL;

-- 6. Employees and their projects, NULL for those without projects
SELECT e.emp_name, p.project_name
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id;

-- 7. Employees who have at least one project
SELECT e.emp_name, p.project_name
FROM employees e
INNER JOIN projects p ON e.emp_id = p.emp_id;

-- 8. All projects including those without an employee assigned
SELECT e.emp_name, p.project_name
FROM employees e
RIGHT JOIN projects p ON e.emp_id = p.emp_id;

-- 9. All employees (no salary table - shown as concept)
SELECT e.emp_name, NULL AS salary
FROM employees e;

-- 10. Employees and their department names including those not in any department
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

-- 11. All departments and employees, including departments with no employees
SELECT d.dept_name, e.emp_name
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id;

-- 12. All employees with contact info (no contact table - shown as concept)
SELECT e.emp_name, NULL AS contact
FROM employees e;

-- 13. All employees and departments including unmatched from both sides (FULL OUTER JOIN simulation)
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
UNION
SELECT e.emp_name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;

-- 14. Employees who have not completed any project
SELECT e.emp_name, p.project_name
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
WHERE p.project_id IS NULL;

-- 15. Employees and their projects, including those without a project
SELECT e.emp_name, p.project_name
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id;

-- 16. All projects and their assigned employees, including unassigned projects
SELECT e.emp_name, p.project_name
FROM projects p
LEFT JOIN employees e ON p.emp_id = e.emp_id;

-- 17. Employees who have both a manager and at least one project
SELECT e.emp_name, m.emp_name AS manager, p.project_name
FROM employees e
INNER JOIN employees m ON e.manager_id = m.emp_id
INNER JOIN projects p ON e.emp_id = p.emp_id;

-- 18. Employees and departments, excluding those without a department
SELECT e.emp_name, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

-- 19. Employees with their department names, all including no dept
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

-- 20. All departments and employees, including empty departments
SELECT d.dept_name, e.emp_name
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id;

-- 21. Employees who have a project but no department
SELECT e.emp_name, p.project_name
FROM employees e
INNER JOIN projects p ON e.emp_id = p.emp_id
LEFT JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL;

-- 22. Total employees per department including empty departments
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name;

-- 23. Employees who report to a manager only
SELECT e.emp_name, m.emp_name AS manager
FROM employees e
INNER JOIN employees m ON e.manager_id = m.emp_id;

-- 24. All employees with their manager, including those without a manager
SELECT e.emp_name, m.emp_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

-- 25. Departments and number of employees including empty departments
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name;

-- 26. All employees and departments including empty departments
SELECT e.emp_name, d.dept_name
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id;

-- 27. Employees without any salary records (no salary table - concept)
SELECT e.emp_name
FROM employees e;

-- 28. Employees and their project assignments, NULL if no project
SELECT e.emp_name, p.project_name
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id;

-- 29. Employees with department and project, including those without either
SELECT e.emp_name, d.dept_name, p.project_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN projects p ON e.emp_id = p.emp_id;

-- 30. Employees with their department, including those without a department
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;