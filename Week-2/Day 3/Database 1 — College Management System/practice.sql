-- Write a query to display address details by concatenating address and city of students . 
-- Give an alias as Address and sort the result based on the concatenated column in descending order

SELECT CONCAT(address,",",city) AS Address
FROM Student
ORDER BY Address DESC;

-- Write a query to display the names of the departments in block number 3.
-- Sort the records in ascending order.

SELECT department_name
FROM Department
WHERE department_block_number = 3
ORDER BY department_name;

-- Insert the following records into the department table
-- | department_id | department_name | department_block_number |
-- | 1 | CSE | 3 |
-- | 2 | IT | 3 |
-- | 3 | SE | 3 |

INSERT INTO Department(department_id,department_name,department_block_number)
VALUES(1,'CSE',3),(2,'IT',3),(3,'SE',3);

-- Write a query to display list of students name and their department name who are all from 'Coimbatore'. 
-- Sort the result based on students name  

SELECT s.student_name as s_name , d.department_name as d_name
FROM Student s
INNER JOIN Department d 
ON s.department_id = d.department_id
WHERE s.city = 'Coimbatore'
ORDER BY s_name;