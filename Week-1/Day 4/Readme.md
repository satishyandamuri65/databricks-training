# Week 1 - Day 4 - Window Functions

## Overview

Day 4 focused on SQL window functions. Practiced on [db-fiddle.com](https://www.db-fiddle.com/) using a retail sales dataset with employees, customers and orders.

---

## Topics Covered

- ROW_NUMBER() - assigns a unique row number to each row
- RANK() - ranks rows, skips numbers on ties
- DENSE_RANK() - ranks rows, no skipping on ties
- PARTITION BY - applies window function within groups
- Running totals using SUM() OVER()
- Cumulative sales per employee
- LAG() - access previous row value
- LEAD() - access next row value
- Moving average using ROWS BETWEEN
- NTILE() - divide rows into equal buckets

---

## Files in This Folder

| File | Description |
|------|-------------|
| `questions.txt` | window function based questions |
| `solutions.sql` | window function queries |
| `README.md` | This file |
