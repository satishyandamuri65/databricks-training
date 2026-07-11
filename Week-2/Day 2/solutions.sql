-- College Management System (CMS)
-- SQL Practice Queries - Week 2 Day 2 - Q26 to Q50
-- Platform: db-fiddle.com (MySQL 8.0)


-- schema setup
DROP TABLE IF EXISTS Mark;
DROP TABLE IF EXISTS Subject;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Department;

CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    department_block_number INT,
    yearly_budget DECIMAL(12,2)
);

CREATE TABLE Staff (
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(50),
    designation VARCHAR(30),
    salary DECIMAL(10,2),
    hire_date DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    gender VARCHAR(10),
    city VARCHAR(50),
    admission_year INT,
    department_id INT,
    cgpa DECIMAL(3,2),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

CREATE TABLE Subject (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(50),
    subject_code VARCHAR(20),
    semester INT,
    credits INT,
    staff_id INT,
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

CREATE TABLE Mark (
    student_id INT,
    subject_id INT,
    exam_type VARCHAR(20),
    marks INT,
    exam_date DATE,
    PRIMARY KEY(student_id, subject_id, exam_type),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);

INSERT INTO Department VALUES
(1,'Computer Science',101,800000),
(2,'Mechanical',102,600000),
(3,'Electronics',103,550000),
(4,'Civil',104,450000),
(5,'Mathematics',105,300000),
(6,NULL,106,200000),
(7,'Biotechnology',NULL,NULL);

INSERT INTO Staff VALUES
(1,'Alice Johnson','Professor',95000,'2015-06-12',1),
(2,'Bob Smith','Associate Professor',82000,'2017-09-01',1),
(3,'Charlie Brown','Professor',91000,'2014-03-21',2),
(4,'David Lee','Lecturer',55000,'2020-07-15',2),
(5,'Eva Green','Professor',99000,'2013-11-05',3),
(6,'Frank Hall','Lecturer',NULL,'2021-01-12',3),
(7,'Grace Miller','HOD',120000,'2010-02-28',4),
(8,NULL,'Lecturer',50000,'2022-08-18',NULL),
(9,'Henry Ford','Assistant Professor',65000,NULL,5),
(10,'Ivy Clark','Professor',98000,'2012-04-17',NULL);

INSERT INTO Student VALUES
(101,'John Doe','Male','New York',2021,1,8.7),
(102,'Mary Jane','Female','Chicago',2020,1,9.1),
(103,'Steve Rogers','Male','Dallas',2022,2,7.5),
(104,'Natasha Romanoff','Female','Boston',2021,2,8.0),
(105,'Bruce Wayne','Male','Gotham',2019,3,9.5),
(106,'Clark Kent','Male','Metropolis',2020,3,6.9),
(107,'Diana Prince','Female','Washington',2022,4,8.4),
(108,'Peter Parker','Male','Queens',2021,4,NULL),
(109,'Tony Stark','Male','Malibu',2019,1,9.8),
(110,'Wanda Maximoff','Female','Chicago',2022,5,7.2),
(111,'Barry Allen','Male',NULL,2023,5,6.5),
(112,NULL,'Female','Seattle',2023,NULL,NULL),
(113,'Scott Lang','Male','San Francisco',2021,NULL,5.8),
(114,'Jean Grey','Female','New York',2020,6,8.8),
(115,'Logan Howlett','Male','Denver',2022,7,7.7);

INSERT INTO Subject VALUES
(201,'Database Systems','CS301',3,4,1),
(202,'Operating Systems','CS302',3,4,2),
(203,'Machine Design','ME201',4,3,3),
(204,'Thermodynamics','ME202',4,4,4),
(205,'Digital Electronics','EC301',5,4,5),
(206,'Signals and Systems','EC302',5,3,6),
(207,'Structural Engineering','CV401',6,4,7),
(208,'Linear Algebra','MA101',1,3,9),
(209,NULL,'GEN999',2,2,NULL),
(210,'Artificial Intelligence','CS401',6,5,1);

INSERT INTO Mark VALUES
(101,201,'Mid',88,'2024-03-10'),
(101,201,'Final',91,'2024-05-10'),
(101,202,'Mid',75,'2024-03-11'),
(102,201,'Mid',95,'2024-03-10'),
(102,202,'Final',89,'2024-05-11'),
(103,203,'Mid',66,'2024-03-09'),
(103,204,'Final',72,'2024-05-12'),
(104,203,'Final',81,'2024-05-12'),
(105,205,'Mid',98,'2024-03-14'),
(105,206,'Final',94,'2024-05-14'),
(106,205,'Mid',54,'2024-03-14'),
(106,206,'Final',61,'2024-05-14'),
(107,207,'Mid',87,'2024-03-16'),
(108,207,'Final',NULL,'2024-05-16'),
(109,201,'Final',99,'2024-05-10'),
(109,210,'Mid',97,'2024-03-20'),
(110,208,'Mid',71,'2024-03-18'),
(111,208,'Final',65,'2024-05-18'),
(112,209,'Mid',NULL,'2024-03-21'),
(113,210,'Final',44,'2024-05-20'),
(114,208,'Mid',90,'2024-03-18'),
(115,209,'Final',73,'2024-05-22');


-- 26. find the city with the maximum number of students
select city, count(*) as student_count
from Student
where city is not null
group by city
order by student_count desc
limit 1;

-- 27. display all departments and their staff count including empty departments
select d.department_name, count(st.staff_id) as staff_count
from Department d
left join Staff st on d.department_id = st.department_id
group by d.department_id, d.department_name;

-- 28. find students who have failed in at least one subject (marks < 50)
select distinct s.student_name, m.marks
from Student s
join Mark m on s.student_id = m.student_id
where m.marks < 50;

-- 29. display staff hired before 2018
select staff_name, designation, hire_date
from Staff
where hire_date < '2018-01-01';

-- 30. find departments where no staff salary is recorded as null
select d.department_name
from Department d
join Staff st on d.department_id = st.department_id
group by d.department_id, d.department_name
having sum(case when st.salary is null then 1 else 0 end) = 0;


-- window functions

-- 31. assign a row number to students ordered by cgpa
select student_name, cgpa,
row_number() over (order by cgpa desc) as row_num
from Student
where cgpa is not null;

-- 32. rank students based on their cgpa
select student_name, cgpa,
rank() over (order by cgpa desc) as cgpa_rank
from Student
where cgpa is not null;

-- 33. display dense rank of staff salaries
select staff_name, salary,
dense_rank() over (order by salary desc) as salary_dense_rank
from Staff
where salary is not null;

-- 34. top 3 highest scoring students using window functions
select student_name, cgpa, cgpa_rank
from (
    select student_name, cgpa,
    rank() over (order by cgpa desc) as cgpa_rank
    from Student
    where cgpa is not null
) ranked
where cgpa_rank <= 3;

-- 35. running total of marks for each student
select s.student_name, m.exam_date, m.marks,
sum(m.marks) over (partition by m.student_id order by m.exam_date) as running_total
from Mark m
join Student s on m.student_id = s.student_id
where m.marks is not null;

-- 36. average marks for each subject using window functions
select distinct sub.subject_name,
avg(m.marks) over (partition by m.subject_id) as avg_marks
from Mark m
join Subject sub on m.subject_id = sub.subject_id
where m.marks is not null;

-- 37. previous exam marks for each student using lag()
select s.student_name, m.exam_date, m.marks,
lag(m.marks) over (partition by m.student_id order by m.exam_date) as prev_marks
from Mark m
join Student s on m.student_id = s.student_id;

-- 38. next exam marks for each student using lead()
select s.student_name, m.exam_date, m.marks,
lead(m.marks) over (partition by m.student_id order by m.exam_date) as next_marks
from Mark m
join Student s on m.student_id = s.student_id;

-- 39. highest marks within each subject using max() over()
select sub.subject_name, s.student_name, m.marks,
max(m.marks) over (partition by m.subject_id) as subject_highest
from Mark m
join Student s on m.student_id = s.student_id
join Subject sub on m.subject_id = sub.subject_id
where m.marks is not null;

-- 40. cumulative average marks ordered by exam date
select m.exam_date, m.marks,
round(avg(m.marks) over (order by m.exam_date rows between unbounded preceding and current row), 2) as cumulative_avg
from Mark m
where m.marks is not null;

-- 41. find the first student admitted in each department
select department_id, student_name, admission_year
from (
    select student_name, admission_year, department_id,
    row_number() over (partition by department_id order by admission_year asc) as rn
    from Student
    where department_id is not null
) ranked
where rn = 1;

-- 42. display the latest hired staff member in each department
select department_id, staff_name, hire_date
from (
    select staff_name, hire_date, department_id,
    row_number() over (partition by department_id order by hire_date desc) as rn
    from Staff
    where department_id is not null and hire_date is not null
) ranked
where rn = 1;

-- 43. divide students into 4 cgpa quartiles using ntile()
select student_name, cgpa,
ntile(4) over (order by cgpa desc) as cgpa_quartile
from Student
where cgpa is not null;

-- 44. find percentage rank of students based on cgpa
select student_name, cgpa,
round(percent_rank() over (order by cgpa) * 100, 2) as pct_rank
from Student
where cgpa is not null;

-- 45. display cumulative distribution of salaries
select staff_name, salary,
round(cume_dist() over (order by salary) * 100, 2) as cumulative_dist_pct
from Staff
where salary is not null;

-- 46. find subjects where a student marks are above the subject average
select s.student_name, sub.subject_name, m.marks, avg_marks
from Mark m
join Student s on m.student_id = s.student_id
join Subject sub on m.subject_id = sub.subject_id
join (
    select subject_id, avg(marks) as avg_marks
    from Mark
    group by subject_id
) avg_sub on m.subject_id = avg_sub.subject_id
where m.marks > avg_sub.avg_marks;

-- 47. find departments whose average staff salary is higher than overall average salary
select d.department_name, round(avg(st.salary), 2) as avg_salary
from Department d
join Staff st on d.department_id = st.department_id
group by d.department_id, d.department_name
having avg(st.salary) > (select avg(salary) from Staff where salary is not null);

-- display students who scored above department average marks
select s.student_name, d.department_name, round(avg(m.marks), 2) as student_avg,
round(dept_avg.avg_marks, 2) as dept_avg
from Student s
join Mark m on s.student_id = m.student_id
join Department d on s.department_id = d.department_id
join (
    select s2.department_id, avg(m2.marks) as avg_marks
    from Student s2
    join Mark m2 on s2.student_id = m2.student_id
    group by s2.department_id
) dept_avg on s.department_id = dept_avg.department_id
group by s.student_id, s.student_name, d.department_name, dept_avg.avg_marks
having avg(m.marks) > dept_avg.avg_marks;

-- find the 3rd highest mark using dense_rank()
select marks
from (
    select distinct marks,
    dense_rank() over (order by marks desc) as rnk
    from Mark
    where marks is not null
) ranked
where rnk = 3;

-- report: student name, department, subject, exam type, marks, dept average cgpa, overall rank
select s.student_name, d.department_name, sub.subject_name, m.exam_type, m.marks,
    round(avg(s.cgpa) over (partition by s.department_id), 2) as dept_avg_cgpa,
    rank() over (order by m.marks desc) as overall_rank
from Mark m
join Student s on m.student_id = s.student_id
join Department d on s.department_id = d.department_id
join Subject sub on m.subject_id = sub.subject_id
where m.marks is not null;