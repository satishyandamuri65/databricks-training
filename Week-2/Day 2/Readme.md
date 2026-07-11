# Week 2 - Day 2 - College Management System (Advanced)

## Overview

Day 2 of Week 2 continued with the College Management System dataset, moving into advanced SQL — window functions applied to student and staff data, subqueries for department-level comparisons, and a final combined report query.

---

## Topics Covered

- Group By with filtering using Having and CASE inside aggregate
- Left Join for empty departments
- ROW_NUMBER, RANK, DENSE_RANK on student CGPA and staff salary
- Running total of marks using SUM() OVER()
- Subject-wise average using AVG() OVER(PARTITION BY)
- LAG() and LEAD() for previous and next exam marks
- MAX() OVER(PARTITION BY) for subject highest marks
- Cumulative average using ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
- First admitted student and latest hired staff per department using ROW_NUMBER
- NTILE(4) for CGPA quartiles
- PERCENT_RANK() for percentage ranking
- CUME_DIST() for cumulative salary distribution
- Correlated subqueries for department average comparisons
- Combined report using multiple window functions in one query

---

## Files in This Folder

| File | Description |
|------|-------------|
| `Questions.txt` | Questions on the CMS dataset |
| `solutions.sql` | solution queries of the questions |
| `README.md` | This file |