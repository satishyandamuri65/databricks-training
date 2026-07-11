# Week 1 — Day 1

## Overview

Day 1 focused on building a strong foundation in SQL. Started by learning SQL basics through **W3Schools** and then reinforced the concepts by watching the first two videos from the YouTube playlist below before moving on to hands-on query practice.

**YouTube Playlist:** [SQL](https://youtube.com/playlist?list=PLrZbzHGc7iABQ60q4X5IJOYaBM-ULmrVe&si=DbIRRCKzWUF6j_3F)

All hands-on queries were written and tested on [db-fiddle.com](https://www.db-fiddle.com/) using a custom Employee-Department-Project schema provided by the trainer.

---

## Schema Used

Three tables were created for all practice queries throughout the training:

### Employee
| Column | Type | Description |
|--------|------|-------------|
| emp_id | INT (PK) | Unique employee ID |
| name | VARCHAR(100) | Employee full name |
| age | INT | Employee age |
| salary | DECIMAL(10,2) | Monthly salary |
| department_id | INT (FK) | References Department |
| hire_date | DATE | Date of joining |

### Department
| Column | Type | Description |
|--------|------|-------------|
| department_id | INT (PK) | Unique department ID |
| name | VARCHAR(50) | Department name (IT, HR, Finance, Marketing) |

### Project
| Column | Type | Description |
|--------|------|-------------|
| project_id | INT (PK) | Unique project ID |
| name | VARCHAR(100) | Project name |
| department_id | INT (FK) | References Department |

---

## Topics Covered

### 1. Basic Queries
Learned how to select all or specific columns from a table, filter rows using `WHERE`, and retrieve data based on known values.

**Key clauses:** `SELECT`, `FROM`, `WHERE`

---

### 2. String Matching Queries
Used the `LIKE` operator with wildcard characters to search and filter text data based on patterns.

**Key concepts:**
- `%` matches zero or more characters
- `_` matches exactly one character
- `LENGTH()` returns the number of characters in a string

---

### 3. Date Queries
Learned how to extract specific parts of a date and compare date values using built-in MySQL date functions.

**Key functions:** `YEAR()`, `MONTH()`, `DATE_SUB()`, `CURDATE()`

---

### 4. Aggregate Queries
Used aggregate functions to compute summary statistics — such as total, average, minimum, and count — across rows in a table.

**Key functions:** `SUM()`, `AVG()`, `MIN()`, `MAX()`, `COUNT()`

---

### 5. GROUP BY Queries
Learned to group rows by a column and apply aggregate functions to each group independently.

**Key concept:** Every non-aggregated column in `SELECT` must appear in `GROUP BY`.

---

### 6. HAVING Queries
Learned to filter groups after aggregation — `HAVING` is used where `WHERE` cannot be applied (i.e., on aggregate results).

**Key distinction:** `WHERE` filters rows before grouping → `HAVING` filters groups after aggregation.

---

## Key Learnings

- `WHERE` filters individual rows **before** grouping; `HAVING` filters groups **after** grouping
- `LIKE` with `%` and `_` wildcards enables flexible pattern matching on string columns
- `YEAR()`, `MONTH()`, and `DATE_SUB()` make it easy to filter date-based conditions dynamically
- Aggregate functions (`SUM`, `AVG`, `MIN`, `MAX`, `COUNT`) summarize data and are paired with `GROUP BY` when computing per-group statistics
- `ORDER BY ... DESC LIMIT 1` is a clean way to retrieve the top result from a grouped query

---

## Resources Used

| Resource | Purpose |
|----------|---------|
| [W3Schools SQL](https://www.w3schools.com/sql/) | Learning SQL syntax and concepts |
| [YouTube SQL Playlist](https://youtube.com/playlist?list=PLrZbzHGc7iABQ60q4X5IJOYaBM-ULmrVe&si=DbIRRCKzWUF6j_3F) | Video walkthroughs — watched first 2 videos |
| [db-fiddle.com](https://www.db-fiddle.com/) | Writing and testing SQL queries hands-on |

---

## Files in This Folder

| File | Description |
|------|-------------|
| `Question.txt` | All 30 SQL queries practised questions  |
| `Solutions.sql` | All 30 SQL queries practised solutions |
| `README.md` | This file — summary of Day 1 learnings |
