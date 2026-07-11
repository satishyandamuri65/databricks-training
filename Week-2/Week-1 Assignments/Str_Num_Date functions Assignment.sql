-- QUESTION 1: Employee Compensation Classification
DROP TABLE IF EXISTS employee_payments;
CREATE TABLE employee_payments (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    base_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    joining_date DATE
);
INSERT INTO employee_payments VALUES
(1,'karthik','Data',75000.75,5000.50,'2019-03-15'),
(2,'veena','HR',65000.40,4000.25,'2021-06-20'),
(3,'ravi','Data',85000.90,6000.75,'2016-01-10'),
(4,'anil','Finance',70000.10,NULL,'2020-09-01'),
(5,'suresh','HR',60000.55,3000.30,'2022-11-25');

SELECT
    CONCAT(UPPER(LEFT(emp_name, 1)), LOWER(SUBSTRING(emp_name, 2))) AS emp_name,
    ROUND(base_salary + COALESCE(bonus, 0)) AS total_income,
    YEAR(joining_date) AS joining_year,
    CASE
        WHEN TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) > 7 THEN 'Senior'
        WHEN TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) BETWEEN 4 AND 7 THEN 'Mid'
        ELSE 'Junior'
    END AS experience_level
FROM employee_payments;


-- QUESTION 2: Order Delivery Delay Analysis
DROP TABLE IF EXISTS orders_delivery;
CREATE TABLE orders_delivery (
    order_id INT,
    customer_name VARCHAR(50),
    order_date DATE,
    delivery_date DATE,
    order_amount DECIMAL(10,2)
);
INSERT INTO orders_delivery VALUES
(101,'rajesh','2025-01-01','2025-01-05',12500.75),
(102,'meena','2025-01-10','2025-01-10',8400.40),
(103,'arun','2025-01-15','2025-01-20',15600.90),
(104,'pooja','2025-01-18',NULL,9200.10);

SELECT
    UPPER(customer_name) AS customer_name,
    DATEDIFF(COALESCE(delivery_date, CURDATE()), order_date) AS delivery_days,
    TRUNCATE(order_amount, 1) AS order_amount,
    CASE
        WHEN delivery_date IS NULL THEN 'Pending'
        WHEN DATEDIFF(delivery_date, order_date) = 0 THEN 'Same-day'
        WHEN DATEDIFF(delivery_date, order_date) > 3 THEN 'Delayed'
        ELSE 'On Time'
    END AS delivery_status
FROM orders_delivery;


-- QUESTION 3: Customer Spending Pattern
DROP TABLE IF EXISTS customer_spending;
CREATE TABLE customer_spending (
    cust_id INT,
    cust_name VARCHAR(50),
    city VARCHAR(30),
    purchase_amount DECIMAL(10,2),
    purchase_date DATE
);
INSERT INTO customer_spending VALUES
(1,'amit','mumbai',12000.75,'2024-12-01'),
(2,'neha','delhi',8500.40,'2024-12-15'),
(3,'rohit','mumbai',15500.90,'2024-11-20'),
(4,'kavya','chennai',6000.10,'2024-10-05');

SELECT
    CONCAT(UPPER(LEFT(cust_name, 1)), LOWER(SUBSTRING(cust_name, 2))) AS cust_name,
    MONTHNAME(purchase_date) AS purchase_month,
    ROUND(purchase_amount) AS purchase_amount,
    ABS(purchase_amount) AS abs_amount,
    CASE
        WHEN purchase_amount > 15000 THEN 'High Spender'
        WHEN purchase_amount BETWEEN 8000 AND 15000 THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS spending_category
FROM customer_spending;


-- QUESTION 4: Subscription Validity Check
DROP TABLE IF EXISTS subscriptions;
CREATE TABLE subscriptions (
    user_id INT,
    user_email VARCHAR(100),
    start_date DATE,
    end_date DATE,
    subscription_fee DECIMAL(10,2)
);
INSERT INTO subscriptions VALUES
(1,'karthik@gmail.com','2024-01-01','2025-01-01',12000.50),
(2,'veena@yahoo.com','2024-06-15','2024-12-15',8500.75),
(3,'ravi@hotmail.com','2023-03-01','2024-03-01',15000.90);

SELECT
    SUBSTRING_INDEX(user_email, '@', -1) AS email_domain,
    TIMESTAMPDIFF(MONTH, start_date, end_date) AS duration_months,
    FORMAT(subscription_fee, 2) AS fee_formatted,
    DATEDIFF(end_date, CURDATE()) AS remaining_days,
    CASE
        WHEN DATEDIFF(end_date, CURDATE()) < 0 THEN 'Expired'
        WHEN DATEDIFF(end_date, CURDATE()) <= 30 THEN 'Expiring Soon'
        ELSE 'Active'
    END AS status
FROM subscriptions;


-- QUESTION 5: Loan EMI Risk Categorization
DROP TABLE IF EXISTS loan_details;
CREATE TABLE loan_details (
    loan_id INT,
    customer_name VARCHAR(50),
    loan_amount DECIMAL(12,2),
    interest_rate DECIMAL(5,2),
    loan_start DATE
);
INSERT INTO loan_details VALUES
(201,'suresh',500000.75,8.5,'2022-01-10'),
(202,'mahesh',750000.40,9.2,'2021-05-20'),
(203,'anita',300000.90,7.8,'2023-07-01');

SELECT
    UPPER(customer_name) AS customer_name,
    ROUND(loan_amount * POWER(1 + interest_rate / 1200, 12)) AS monthly_interest,
    TIMESTAMPDIFF(YEAR, loan_start, CURDATE()) AS years_since_start,
    CASE
        WHEN interest_rate > 9 THEN 'High Risk'
        WHEN interest_rate BETWEEN 8 AND 9 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_category
FROM loan_details;


-- QUESTION 6: Employee Attendance Evaluation
DROP TABLE IF EXISTS attendance;
CREATE TABLE attendance (
    emp_id INT,
    emp_name VARCHAR(50),
    total_days INT,
    present_days INT,
    record_date DATE
);
INSERT INTO attendance VALUES
(1,'karthik',30,28,'2025-01-31'),
(2,'veena',30,22,'2025-01-31'),
(3,'ravi',30,18,'2025-01-31');

SELECT
    LOWER(emp_name) AS emp_name,
    MONTHNAME(record_date) AS month_name,
    ROUND(present_days / total_days * 100) AS attendance_pct,
    total_days - present_days AS absent_days,
    CASE
        WHEN ROUND(present_days / total_days * 100) >= 90 THEN 'Excellent'
        WHEN ROUND(present_days / total_days * 100) BETWEEN 75 AND 89 THEN 'Average'
        ELSE 'Poor'
    END AS attendance_status
FROM attendance;


-- QUESTION 7: Product Discount Validation
DROP TABLE IF EXISTS product_sales;
CREATE TABLE product_sales (
    product_id INT,
    product_name VARCHAR(50),
    mrp DECIMAL(10,2),
    selling_price DECIMAL(10,2),
    sale_date DATE
);
INSERT INTO product_sales VALUES
(1,'Laptop',75000.75,68000.50,'2025-01-10'),
(2,'Mobile',35000.40,33000.25,'2025-01-12'),
(3,'Tablet',25000.90,26000.75,'2025-01-15');

SELECT
    CONCAT(UPPER(LEFT(product_name, 1)), LOWER(SUBSTRING(product_name, 2))) AS product_name,
    ABS(mrp - selling_price) AS discount_amount,
    ROUND(ABS(mrp - selling_price) / mrp * 100, 2) AS discount_pct,
    DAYNAME(sale_date) AS sale_day,
    CASE
        WHEN selling_price > mrp THEN 'Overpriced'
        WHEN mrp = selling_price THEN 'No Discount'
        ELSE 'Valid Discount'
    END AS discount_status
FROM product_sales;


-- QUESTION 8: Insurance Policy Aging
DROP TABLE IF EXISTS insurance_policies;
CREATE TABLE insurance_policies (
    policy_id INT,
    holder_name VARCHAR(50),
    premium_amount DECIMAL(10,2),
    policy_start DATE,
    policy_end DATE
);
INSERT INTO insurance_policies VALUES
(301,'arjun',12000.50,'2023-01-01','2026-01-01'),
(302,'megha',8500.75,'2022-06-15','2025-06-15'),
(303,'vinod',15000.90,'2021-03-01','2024-03-01');

SELECT
    UPPER(holder_name) AS holder_name,
    TIMESTAMPDIFF(YEAR, policy_start, policy_end) AS duration_years,
    DATEDIFF(policy_end, CURDATE()) AS remaining_days,
    ROUND(premium_amount) AS premium_amount,
    CASE
        WHEN CURDATE() > policy_end THEN 'Expired'
        WHEN TIMESTAMPDIFF(YEAR, policy_start, policy_end) >= 3 THEN 'Long Term'
        ELSE 'Mid Term'
    END AS policy_status
FROM insurance_policies;


-- QUESTION 9: Salary Increment Simulation
DROP TABLE IF EXISTS salary_revision;
CREATE TABLE salary_revision (
    emp_id INT,
    emp_name VARCHAR(50),
    current_salary DECIMAL(10,2),
    rating INT,
    last_hike DATE
);
INSERT INTO salary_revision VALUES
(1,'karthik',75000.75,5,'2023-01-01'),
(2,'veena',65000.40,4,'2024-01-01'),
(3,'ravi',85000.90,3,'2022-01-01');

SELECT
    LOWER(emp_name) AS emp_name,
    TIMESTAMPDIFF(YEAR, last_hike, CURDATE()) AS years_since_hike,
    CASE
        WHEN rating = 5 THEN ROUND(current_salary * 1.20)
        WHEN rating = 4 THEN ROUND(current_salary * 1.10)
        WHEN rating = 3 THEN ROUND(current_salary * 1.05)
        ELSE ROUND(current_salary)
    END AS new_salary,
    CASE
        WHEN rating = 5 THEN 'High Increment'
        WHEN rating >= 3 THEN 'Moderate'
        ELSE 'No Increment'
    END AS increment_category
FROM salary_revision;


-- QUESTION 10: Customer Account Status Evaluation
DROP TABLE IF EXISTS bank_accounts;
CREATE TABLE bank_accounts (
    account_id INT,
    customer_name VARCHAR(50),
    balance DECIMAL(12,2),
    last_transaction DATE,
    branch VARCHAR(30)
);
INSERT INTO bank_accounts VALUES
(501,'ramesh',125000.75,'2024-12-20','hyderabad'),
(502,'sita',8500.40,'2023-06-15','delhi'),
(503,'manoj',-2500.90,'2025-01-05','mumbai');

SELECT
    CONCAT(UPPER(LEFT(branch, 1)), LOWER(SUBSTRING(branch, 2))) AS branch,
    customer_name,
    ABS(balance) AS abs_balance,
    DATEDIFF(CURDATE(), last_transaction) AS days_since_transaction,
    SIGN(balance) AS balance_sign,
    CASE
        WHEN balance < 0 THEN 'Overdrawn'
        WHEN DATEDIFF(CURDATE(), last_transaction) > 365 THEN 'Dormant'
        ELSE 'Active'
    END AS account_status
FROM bank_accounts;


-- Level-1
-- QUESTION 1: Salary Risk Flagging Based on Tax Shock
DROP TABLE IF EXISTS salary_audit;
CREATE TABLE salary_audit (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    tax_percent DECIMAL(5,2),
    last_revision DATE
);
INSERT INTO salary_audit VALUES
(1,'karthik',75000.75,10.5,'2022-01-15'),
(2,'veena',65000.40,18.0,'2023-06-01'),
(3,'ravi',85000.90,25.0,'2020-11-20');

SELECT
    LOWER(emp_name) AS emp_name,
    ROUND(salary - (salary * tax_percent / 100)) AS net_salary,
    YEAR(last_revision) AS revision_year,
    TIMESTAMPDIFF(MONTH, last_revision, CURDATE()) AS months_since_revision,
    CASE
        WHEN tax_percent > 20 AND TIMESTAMPDIFF(MONTH, last_revision, CURDATE()) > 24 THEN 'Tax Shock'
        WHEN tax_percent BETWEEN 15 AND 20 THEN 'Review Needed'
        ELSE 'Stable'
    END AS flag_status
FROM salary_audit;


-- QUESTION 2: Bonus Abuse Detection
DROP TABLE IF EXISTS bonus_monitor;
CREATE TABLE bonus_monitor (
    emp_code INT,
    emp_name VARCHAR(50),
    base_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    bonus_date DATE
);
INSERT INTO bonus_monitor VALUES
(101,'Anil',70000.10,30000.00,'2025-01-10'),
(102,'Suresh',60000.55,3000.30,'2024-03-15'),
(103,'Ravi',85000.90,15000.75,'2023-12-01');

SELECT
    CONCAT(UPPER(LEFT(emp_name, 1)), LOWER(SUBSTRING(emp_name, 2))) AS emp_name,
    ROUND(bonus / base_salary * 100) AS bonus_pct,
    DAYNAME(bonus_date) AS bonus_day,
    ABS(base_salary - bonus) AS salary_bonus_diff,
    CASE
        WHEN ROUND(bonus / base_salary * 100) > 30
             AND DAYOFWEEK(bonus_date) IN (1, 7) THEN 'Suspicious'
        WHEN ROUND(bonus / base_salary * 100) <= 20 THEN 'Normal'
        ELSE 'Audit'
    END AS status
FROM bonus_monitor;


-- QUESTION 3: Experience Parity Validation
DROP TABLE IF EXISTS employee_experience;
CREATE TABLE employee_experience (
    emp_id INT,
    emp_name VARCHAR(50),
    joining_date DATE,
    declared_experience INT,
    salary DECIMAL(10,2)
);
INSERT INTO employee_experience VALUES
(1,'Veena','2018-07-01',4,65000.40),
(2,'Ravi','2014-01-10',12,85000.90),
(3,'Anil','2020-09-01',3,70000.10);

SELECT
    UPPER(emp_name) AS emp_name,
    TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) AS actual_experience,
    declared_experience - TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) AS experience_diff,
    FLOOR(salary) AS salary,
    CASE
        WHEN declared_experience > TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) THEN 'Overstated'
        WHEN declared_experience < TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) THEN 'Understated'
        ELSE 'Matched'
    END AS parity_status
FROM employee_experience;


-- QUESTION 4: Salary Digit Pattern Analysis
DROP TABLE IF EXISTS salary_digits;
CREATE TABLE salary_digits (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    credit_date DATE
);
INSERT INTO salary_digits VALUES
(1,'Karthik',75000.75,'2025-01-01'),
(2,'Veena',65000.40,'2025-01-02'),
(3,'Suresh',60000.55,'2025-01-03');

SELECT
    RIGHT(emp_name, 2) AS last_two_chars,
    DAY(credit_date) AS day_of_month,
    TRUNCATE(salary, 0) AS salary_truncated,
    MOD(TRUNCATE(salary, 0), 10) AS salary_mod,
    CASE
        WHEN MOD(TRUNCATE(salary, 0), 10) = DAY(credit_date) THEN 'Pattern Match'
        ELSE 'No Match'
    END AS pattern_status
FROM salary_digits;


-- QUESTION 5: Odd-Even Salary Compliance
DROP TABLE IF EXISTS payroll_control;
CREATE TABLE payroll_control (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    payment_date DATE
);
INSERT INTO payroll_control VALUES
(1,'Ravi',85000.90,'2025-01-15'),
(2,'Anil',70000.10,'2025-01-16'),
(3,'Veena',65000.40,'2025-01-17');

SELECT
    LOWER(emp_name) AS emp_name,
    DAYNAME(payment_date) AS weekday_name,
    ROUND(salary) AS salary_rounded,
    MOD(ROUND(salary), 2) AS salary_mod,
    CASE
        WHEN MOD(ROUND(salary), 2) = 0
             AND MOD(DAYOFWEEK(payment_date), 2) = 1 THEN 'Violation'
        ELSE 'Compliant'
    END AS compliance_status
FROM payroll_control;


-- QUESTION 6: Salary Inflation Drift
DROP TABLE IF EXISTS inflation_watch;
CREATE TABLE inflation_watch (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    last_hike DATE
);
INSERT INTO inflation_watch VALUES
(1,'Karthik',75000.75,'2019-01-01'),
(2,'Veena',65000.40,'2022-01-01'),
(3,'Ravi',85000.90,'2017-01-01');

SELECT
    CONCAT(UPPER(LEFT(emp_name, 1)), LOWER(SUBSTRING(emp_name, 2))) AS emp_name,
    TIMESTAMPDIFF(YEAR, last_hike, CURDATE()) AS years_since_hike,
    ROUND(salary * POWER(1.06, TIMESTAMPDIFF(YEAR, last_hike, CURDATE()))) AS salary_impact,
    CASE
        WHEN TIMESTAMPDIFF(YEAR, last_hike, CURDATE()) > 5 THEN 'High Inflation Risk'
        WHEN TIMESTAMPDIFF(YEAR, last_hike, CURDATE()) BETWEEN 3 AND 5 THEN 'Moderate'
        ELSE 'Low'
    END AS inflation_risk
FROM inflation_watch;


-- QUESTION 7: Salary Sign Integrity Check
DROP TABLE IF EXISTS salary_integrity;
CREATE TABLE salary_integrity (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    record_date DATE
);
INSERT INTO salary_integrity VALUES
(1,'Anil',-70000.10,'2025-01-10'),
(2,'Veena',65000.40,'2025-01-10'),
(3,'Ravi',0.00,'2025-01-10');

SELECT
    UPPER(emp_name) AS emp_name,
    YEAR(record_date) AS record_year,
    SIGN(salary) AS salary_sign,
    ABS(salary) AS abs_salary,
    CASE
        WHEN SIGN(salary) = -1 THEN 'Negative Error'
        WHEN SIGN(salary) = 0 THEN 'Zero Salary'
        ELSE 'Valid'
    END AS integrity_status
FROM salary_integrity;


-- QUESTION 8: Name Length vs Salary Correlation
DROP TABLE IF EXISTS name_salary;
CREATE TABLE name_salary (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    join_date DATE
);
INSERT INTO name_salary VALUES
(1,'Karthik',75000.75,'2019-03-15'),
(2,'Veena',65000.40,'2021-06-20'),
(3,'Ravi',85000.90,'2016-01-10');

SELECT
    emp_name,
    LENGTH(emp_name) AS name_length,
    TIMESTAMPDIFF(YEAR, join_date, CURDATE()) AS years_of_service,
    ROUND(salary) AS salary,
    CASE
        WHEN LENGTH(emp_name) > TIMESTAMPDIFF(YEAR, join_date, CURDATE()) THEN 'Name Bias'
        ELSE 'Neutral'
    END AS correlation_status
FROM name_salary;


-- QUESTION 9: Salary Spike Detection by Month
DROP TABLE IF EXISTS salary_monthly;
CREATE TABLE salary_monthly (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    paid_date DATE
);
INSERT INTO salary_monthly VALUES
(1,'Karthik',75000.75,'2025-01-31'),
(2,'Veena',65000.40,'2025-02-28'),
(3,'Ravi',85000.90,'2025-03-31');

SELECT
    emp_name,
    MONTHNAME(paid_date) AS month_name,
    CEIL(salary) AS salary_ceil,
    DAY(LAST_DAY(paid_date)) AS last_day_of_month,
    CASE
        WHEN DAY(paid_date) = DAY(LAST_DAY(paid_date)) THEN 'End Month Spike'
        ELSE 'Regular'
    END AS spike_status
FROM salary_monthly;


-- QUESTION 10: Salary Digit Sum Audit
DROP TABLE IF EXISTS digit_audit;
CREATE TABLE digit_audit (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    audit_date DATE
);
INSERT INTO digit_audit VALUES
(1,'Anil',70000.10,'2025-01-01'),
(2,'Veena',65000.40,'2025-01-02');

SELECT
    LEFT(emp_name, 1) AS first_char,
    TRUNCATE(salary, 0) AS salary_truncated,
    DAY(audit_date) AS audit_day,
    (
        MOD(FLOOR(TRUNCATE(salary, 0) / 10000), 10) +
        MOD(FLOOR(TRUNCATE(salary, 0) / 1000), 10) +
        MOD(FLOOR(TRUNCATE(salary, 0) / 100), 10) +
        MOD(FLOOR(TRUNCATE(salary, 0) / 10), 10) +
        MOD(TRUNCATE(salary, 0), 10)
    ) AS digit_sum,
    CASE
        WHEN MOD(
            MOD(FLOOR(TRUNCATE(salary, 0) / 10000), 10) +
            MOD(FLOOR(TRUNCATE(salary, 0) / 1000), 10) +
            MOD(FLOOR(TRUNCATE(salary, 0) / 100), 10) +
            MOD(FLOOR(TRUNCATE(salary, 0) / 10), 10) +
            MOD(TRUNCATE(salary, 0), 10), 2) = 0 THEN 'Digit Alert'
        ELSE 'Normal'
    END AS audit_status
FROM digit_audit;

-- QUESTION 11: Weekend Salary Credit Fraud Detection
DROP TABLE IF EXISTS salary_credit_audit;
CREATE TABLE salary_credit_audit (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    credit_date DATE,
    bank_code VARCHAR(10)
);
INSERT INTO salary_credit_audit VALUES
(1,'Karthik',75000.75,'2025-01-04','HDFC01'),
(2,'Veena',65000.40,'2025-01-06','ICIC02'),
(3,'Ravi',85000.90,'2025-01-05','SBIN03'),
(4,'Anil',70000.10,'2025-01-07','AXIS04'),
(5,'Suresh',60000.55,'2025-01-11','HDFC01');

SELECT
    emp_name,
    LEFT(bank_code, 4) AS bank_prefix,
    DAYNAME(credit_date) AS weekday_name,
    ROUND(salary) AS salary_rounded,
    MOD(ROUND(salary), 5) AS salary_mod,
    CASE
        WHEN DAYOFWEEK(credit_date) IN (1, 7) AND MOD(ROUND(salary), 5) = 0 THEN 'Weekend Fraud'
        WHEN LEFT(bank_code, 4) = 'HDFC' THEN 'Bank Review'
        ELSE 'Normal'
    END AS fraud_status
FROM salary_credit_audit;


-- QUESTION 12: Salary Credit Time Drift Analysis
DROP TABLE IF EXISTS salary_time_drift;
CREATE TABLE salary_time_drift (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    credit_ts DATETIME
);
INSERT INTO salary_time_drift VALUES
(1,'Karthik',75000.75,'2025-01-10 23:45:00'),
(2,'Veena',65000.40,'2025-01-10 09:15:00'),
(3,'Ravi',85000.90,'2025-01-11 00:10:00'),
(4,'Anil',70000.10,'2025-01-09 18:30:00'),
(5,'Suresh',60000.55,'2025-01-10 02:50:00');

SELECT
    LOWER(emp_name) AS emp_name,
    HOUR(credit_ts) AS credit_hour,
    FLOOR(salary) AS salary_floor,
    FLOOR(salary) - HOUR(credit_ts) AS salary_hour_diff,
    CASE
        WHEN HOUR(credit_ts) BETWEEN 0 AND 3 THEN 'Midnight Drift'
        WHEN HOUR(credit_ts) > 18 THEN 'After Hours'
        ELSE 'Business Hours'
    END AS drift_status
FROM salary_time_drift;


-- QUESTION 13: Salary Decimal Precision Audit
DROP TABLE IF EXISTS salary_precision;
CREATE TABLE salary_precision (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,4),
    record_date DATE
);
INSERT INTO salary_precision VALUES
(1,'Karthik',75000.7567,'2025-01-01'),
(2,'Veena',65000.4044,'2025-01-02'),
(3,'Ravi',85000.9099,'2025-01-03'),
(4,'Anil',70000.1001,'2025-01-04'),
(5,'Suresh',60000.5555,'2025-01-05');

SELECT
    emp_name,
    TRUNCATE(salary, 2) AS salary_truncated,
    ROUND(ROUND(salary, 2) - TRUNCATE(salary, 2), 4) AS precision_diff,
    DAYNAME(record_date) AS day_name,
    LENGTH(emp_name) AS name_length,
    CASE
        WHEN ROUND(ROUND(salary, 2) - TRUNCATE(salary, 2), 4) > 0.01 THEN 'Precision Loss'
        ELSE 'Safe'
    END AS precision_status
FROM salary_precision;


-- QUESTION 14: Salary Growth Power Index
DROP TABLE IF EXISTS salary_growth;
CREATE TABLE salary_growth (
    emp_id INT,
    emp_name VARCHAR(50),
    base_salary DECIMAL(10,2),
    growth_rate DECIMAL(5,2),
    last_hike DATE
);
INSERT INTO salary_growth VALUES
(1,'Karthik',75000.75,1.08,'2019-01-01'),
(2,'Veena',65000.40,1.05,'2021-01-01'),
(3,'Ravi',85000.90,1.12,'2017-01-01'),
(4,'Anil',70000.10,1.03,'2022-01-01'),
(5,'Suresh',60000.55,1.06,'2020-01-01');

SELECT
    UPPER(emp_name) AS emp_name,
    TIMESTAMPDIFF(YEAR, last_hike, CURDATE()) AS years_since_hike,
    ROUND(base_salary * POWER(growth_rate, TIMESTAMPDIFF(YEAR, last_hike, CURDATE()))) AS projected_salary,
    CASE
        WHEN ROUND(base_salary * POWER(growth_rate, TIMESTAMPDIFF(YEAR, last_hike, CURDATE()))) > 150000 THEN 'Explosive Growth'
        WHEN ROUND(base_salary * POWER(growth_rate, TIMESTAMPDIFF(YEAR, last_hike, CURDATE()))) BETWEEN 80000 AND 150000 THEN 'Controlled'
        ELSE 'Stagnant'
    END AS growth_status
FROM salary_growth;


-- QUESTION 15: Salary Symmetry Check
DROP TABLE IF EXISTS salary_symmetry;
CREATE TABLE salary_symmetry (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    processed_date DATE
);
INSERT INTO salary_symmetry VALUES
(1,'Karthik',75557.75,'2025-01-15'),
(2,'Veena',64446.40,'2025-01-16'),
(3,'Ravi',85858.90,'2025-01-17'),
(4,'Anil',70007.10,'2025-01-18'),
(5,'Suresh',60000.55,'2025-01-19');

SELECT
    CONCAT(UPPER(LEFT(emp_name, 1)), LOWER(SUBSTRING(emp_name, 2))) AS emp_name,
    FLOOR(salary) AS salary_no_decimal,
    REVERSE(CAST(FLOOR(salary) AS CHAR)) AS reversed_salary,
    DAYNAME(processed_date) AS weekday_name,
    CASE
        WHEN CAST(FLOOR(salary) AS CHAR) = REVERSE(CAST(FLOOR(salary) AS CHAR)) THEN 'Symmetric Pay'
        ELSE 'Asymmetric'
    END AS symmetry_status
FROM salary_symmetry;


-- QUESTION 16: Leap Year Salary Adjustment Audit
DROP TABLE IF EXISTS leap_salary;
CREATE TABLE leap_salary (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    credit_date DATE
);
INSERT INTO leap_salary VALUES
(1,'Karthik',75000.75,'2024-02-29'),
(2,'Veena',65000.40,'2025-02-28'),
(3,'Ravi',85000.90,'2020-02-29'),
(4,'Anil',70000.10,'2023-02-28'),
(5,'Suresh',60000.55,'2024-02-28');

SELECT
    emp_name,
    YEAR(credit_date) AS credit_year,
    CEIL(salary) AS salary_ceil,
    DAYOFYEAR(credit_date) AS day_of_year,
    CASE
        WHEN MONTH(credit_date) = 2 AND DAY(credit_date) = 29 THEN 'Leap Credit'
        ELSE 'Non-Leap Credit'
    END AS leap_status
FROM leap_salary;


-- QUESTION 17: Fiscal Year Boundary Salary Check
DROP TABLE IF EXISTS fiscal_salary;
CREATE TABLE fiscal_salary (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    credit_date DATE
);
INSERT INTO fiscal_salary VALUES
(1,'Karthik',75000.75,'2025-03-31'),
(2,'Veena',65000.40,'2025-04-01'),
(3,'Ravi',85000.90,'2024-03-30'),
(4,'Anil',70000.10,'2024-04-02'),
(5,'Suresh',60000.55,'2025-03-29');

SELECT
    LOWER(emp_name) AS emp_name,
    CASE
        WHEN MONTH(credit_date) >= 4 THEN YEAR(credit_date)
        ELSE YEAR(credit_date) - 1
    END AS fiscal_year,
    MONTH(credit_date) AS credit_month,
    FORMAT(salary, 2) AS salary_formatted,
    CASE
        WHEN MONTH(credit_date) = 3 AND DAY(credit_date) = 31 THEN 'Year End Credit'
        WHEN MONTH(credit_date) = 4 AND DAY(credit_date) = 1 THEN 'Year Start Credit'
        ELSE 'Mid Year'
    END AS fiscal_status
FROM fiscal_salary;


-- QUESTION 18: Salary Random Sampling for Audit
DROP TABLE IF EXISTS salary_sampling;
CREATE TABLE salary_sampling (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    record_date DATE
);
INSERT INTO salary_sampling VALUES
(1,'Karthik',75000.75,'2025-01-01'),
(2,'Veena',65000.40,'2025-01-02'),
(3,'Ravi',85000.90,'2025-01-03'),
(4,'Anil',70000.10,'2025-01-04'),
(5,'Suresh',60000.55,'2025-01-05'),
(6,'Amit',72000.60,'2025-01-06'),
(7,'Neha',68000.80,'2025-01-07');

SELECT
    emp_name,
    LEFT(emp_name, 1) AS first_char,
    ROUND(salary) AS salary_rounded,
    DAYNAME(record_date) AS day_name,
    ROUND(RAND(), 4) AS random_value,
    CASE
        WHEN RAND() > 0.7 THEN 'Sampled'
        ELSE 'Skipped'
    END AS sample_status
FROM salary_sampling;


-- QUESTION 19: Salary ASCII Integrity Check
DROP TABLE IF EXISTS salary_ascii;
CREATE TABLE salary_ascii (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    join_date DATE
);
INSERT INTO salary_ascii VALUES
(1,'Karthik',75000.75,'2019-03-15'),
(2,'Veena',65000.40,'2021-06-20'),
(3,'Ravi',85000.90,'2016-01-10'),
(4,'Anil',70000.10,'2020-09-01'),
(5,'Suresh',60000.55,'2022-11-25');

SELECT
    emp_name,
    ASCII(LEFT(emp_name, 1)) AS ascii_value,
    TIMESTAMPDIFF(YEAR, join_date, CURDATE()) AS years_since_joining,
    FLOOR(salary) AS salary_floor,
    CASE
        WHEN ASCII(LEFT(emp_name, 1)) > TIMESTAMPDIFF(YEAR, join_date, CURDATE()) THEN 'Name Dominates'
        ELSE 'Experience Dominates'
    END AS dominance_status
FROM salary_ascii;


-- QUESTION 20: Salary vs Calendar Symmetry Logic
DROP TABLE IF EXISTS salary_calendar;
CREATE TABLE salary_calendar (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    credit_date DATE
);
INSERT INTO salary_calendar VALUES
(1,'Karthik',75000.75,'2025-01-15'),
(2,'Veena',65000.40,'2025-02-14'),
(3,'Ravi',85000.90,'2025-03-31'),
(4,'Anil',70000.10,'2025-04-04'),
(5,'Suresh',60000.55,'2025-05-05');

SELECT
    UPPER(emp_name) AS emp_name,
    DAY(credit_date) AS credit_day,
    MONTH(credit_date) AS credit_month,
    ABS(DAY(credit_date) - MONTH(credit_date)) AS day_month_diff,
    MOD(FLOOR(salary), 100) AS last_two_digits,
    CASE
        WHEN DAY(credit_date) = MONTH(credit_date)
             OR MOD(FLOOR(salary), 100) = DAY(credit_date) THEN 'Calendar Match'
        ELSE 'Calendar Drift'
    END AS calendar_status
FROM salary_calendar;

-- String, Date and Number Functions Assignment - Level 2
-- Platform: db-fiddle.com (MySQL 8.0)


-- QUESTION 1: Employee Login Discipline & Performance Classification
DROP TABLE IF EXISTS employee_login;
CREATE TABLE employee_login (
    emp_id INT,
    emp_name VARCHAR(50),
    login_time DATETIME,
    logout_time DATETIME
);
INSERT INTO employee_login VALUES
(1,'Karthik','2025-01-15 09:05:00','2025-01-15 18:10:00'),
(2,'Veena','2025-01-14 10:30:00','2025-01-14 16:00:00'),
(3,'Ravi','2025-01-13 09:00:00','2025-01-13 20:00:00'),
(4,'Anil','2025-01-12 11:00:00','2025-01-12 14:00:00'),
(5,'Suresh','2025-01-11 09:15:00','2025-01-11 17:00:00');

SELECT
    CONCAT(UPPER(LEFT(emp_name, 1)), LOWER(SUBSTRING(emp_name, 2))) AS emp_name,
    DAYNAME(DATE(login_time)) AS login_day,
    CASE
        WHEN DAYOFWEEK(DATE(login_time)) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    ROUND(TIMESTAMPDIFF(MINUTE, login_time, logout_time) / 60, 2) AS working_hours,
    CASE
        WHEN DAYOFWEEK(DATE(login_time)) NOT IN (1, 7)
             AND ROUND(TIMESTAMPDIFF(MINUTE, login_time, logout_time) / 60, 2) >= 8 THEN 'Good Performer'
        WHEN DAYOFWEEK(DATE(login_time)) NOT IN (1, 7)
             AND ROUND(TIMESTAMPDIFF(MINUTE, login_time, logout_time) / 60, 2) < 6 THEN 'Bad Performer'
        ELSE 'Weekend Login'
    END AS performance_status
FROM employee_login;


-- QUESTION 2: Past 7 Days Attendance & Productivity Check
DROP TABLE IF EXISTS attendance_log;
CREATE TABLE attendance_log (
    emp_id INT,
    emp_name VARCHAR(50),
    login_date DATE,
    login_time TIME,
    logout_time TIME
);
INSERT INTO attendance_log VALUES
(1,'Karthik','2025-01-14','09:00:00','18:00:00'),
(2,'Karthik','2025-01-13','09:15:00','17:30:00'),
(3,'Veena','2025-01-12','10:00:00','15:00:00'),
(4,'Ravi','2025-01-10','09:00:00','19:00:00'),
(5,'Anil','2025-01-08','11:00:00','14:00:00');

SELECT
    UPPER(emp_name) AS emp_name,
    login_date,
    CASE
        WHEN login_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) THEN 'Last 7 Days'
        ELSE 'Older'
    END AS date_range,
    CASE
        WHEN DAYOFWEEK(login_date) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    ROUND(TIME_TO_SEC(TIMEDIFF(logout_time, login_time)) / 3600, 2) AS working_hours,
    CASE
        WHEN login_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
             AND ROUND(TIME_TO_SEC(TIMEDIFF(logout_time, login_time)) / 3600, 2) >= 8 THEN 'Active & Productive'
        WHEN login_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
             AND ROUND(TIME_TO_SEC(TIMEDIFF(logout_time, login_time)) / 3600, 2) < 8 THEN 'Active but Low Hours'
        ELSE 'Absent from Last 7 Days'
    END AS productivity_status
FROM attendance_log;


-- QUESTION 3: Weekend Work Abuse Detection
DROP TABLE IF EXISTS weekend_monitor;
CREATE TABLE weekend_monitor (
    emp_id INT,
    emp_name VARCHAR(50),
    work_date DATE,
    login_time TIME,
    logout_time TIME
);
INSERT INTO weekend_monitor VALUES
(1,'Ravi','2025-01-11','09:00:00','21:00:00'),
(2,'Veena','2025-01-12','10:00:00','13:00:00'),
(3,'Karthik','2025-01-10','09:00:00','18:00:00'),
(4,'Anil','2025-01-09','11:00:00','14:00:00');

SELECT
    LOWER(emp_name) AS emp_name,
    DAYNAME(work_date) AS day_name,
    CEIL(TIME_TO_SEC(TIMEDIFF(logout_time, login_time)) / 3600) AS working_hours_ceil,
    CASE
        WHEN DAYOFWEEK(work_date) IN (1, 7)
             AND CEIL(TIME_TO_SEC(TIMEDIFF(logout_time, login_time)) / 3600) >= 8 THEN 'Weekend Overtime'
        WHEN DAYOFWEEK(work_date) IN (1, 7)
             AND CEIL(TIME_TO_SEC(TIMEDIFF(logout_time, login_time)) / 3600) < 4 THEN 'Suspicious Login'
        ELSE 'Normal Working Day'
    END AS abuse_status
FROM weekend_monitor;


-- QUESTION 4: Login Time Deviation & Discipline Score
DROP TABLE IF EXISTS login_discipline;
CREATE TABLE login_discipline (
    emp_id INT,
    emp_name VARCHAR(50),
    login_datetime DATETIME,
    logout_datetime DATETIME
);
INSERT INTO login_discipline VALUES
(1,'Karthik','2025-01-15 08:55:00','2025-01-15 18:10:00'),
(2,'Veena','2025-01-15 10:45:00','2025-01-15 16:00:00'),
(3,'Ravi','2025-01-15 09:00:00','2025-01-15 20:30:00'),
(4,'Anil','2025-01-15 11:30:00','2025-01-15 14:00:00');

SELECT
    emp_name,
    HOUR(login_datetime) AS login_hour,
    TRUNCATE(TIMESTAMPDIFF(MINUTE, login_datetime, logout_datetime) / 60, 1) AS working_hours,
    DAYNAME(DATE(login_datetime)) AS weekday_name,
    CASE
        WHEN DAYOFWEEK(DATE(login_datetime)) NOT IN (1, 7)
             AND HOUR(login_datetime) < 9
             AND TRUNCATE(TIMESTAMPDIFF(MINUTE, login_datetime, logout_datetime) / 60, 1) >= 8 THEN 'Disciplined'
        WHEN DAYOFWEEK(DATE(login_datetime)) NOT IN (1, 7)
             AND HOUR(login_datetime) > 10 THEN 'Late Comer'
        ELSE 'Poor Discipline'
    END AS discipline_score
FROM login_discipline;


-- QUESTION 5: Absenteeism vs Performance Correlation
DROP TABLE IF EXISTS performance_tracker;
CREATE TABLE performance_tracker (
    emp_id INT,
    emp_name VARCHAR(50),
    work_date DATE,
    login_time TIME,
    logout_time TIME
);
INSERT INTO performance_tracker VALUES
(1,'Karthik','2025-01-09','09:00:00','18:00:00'),
(2,'Karthik','2025-01-10','09:10:00','17:50:00'),
(3,'Veena','2025-01-05','10:00:00','15:00:00'),
(4,'Ravi','2025-01-14','09:00:00','19:00:00'),
(5,'Anil','2025-01-03','11:00:00','14:00:00');

SELECT
    emp_name,
    work_date,
    CASE
        WHEN work_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) THEN 'Last 7 Days'
        ELSE 'Older'
    END AS date_range,
    CASE
        WHEN DAYOFWEEK(work_date) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    FLOOR(TIME_TO_SEC(TIMEDIFF(logout_time, login_time)) / 3600) AS working_hours,
    CASE
        WHEN work_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
             AND DAYOFWEEK(work_date) NOT IN (1, 7)
             AND FLOOR(TIME_TO_SEC(TIMEDIFF(logout_time, login_time)) / 3600) >= 8 THEN 'Consistent Performer'
        WHEN FLOOR(TIME_TO_SEC(TIMEDIFF(logout_time, login_time)) / 3600) < 6 THEN 'Irregular Performer'
        ELSE 'Absent / Old Record'
    END AS performance_status
FROM performance_tracker;
