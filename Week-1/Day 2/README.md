# Week 1 — Day 2

## Overview

Day 2 continued SQL practice from Day 1, focusing on advanced querying techniques — specifically ORDER BY, all types of JOINs, nested/correlated subqueries, and combined moderate-difficulty queries. All queries were written and tested on [db-fiddle.com](https://www.db-fiddle.com/) using the same Employee-Department-Project schema.

---

## Schema Used

Same three-table schema as Day 1 — Employee, Department, and Project. Refer to the [Day 1 README](../day1/README.md) for the full schema breakdown.

---

## Topics Covered

### 7. ORDER BY Queries
Learned how to sort query results by one or multiple columns in ascending or descending order. Also combined `ORDER BY` with `GROUP BY` to sort aggregated results.

**Key clauses:** `ORDER BY`, `ASC`, `DESC`

**Key concept:** Multiple columns can be chained in `ORDER BY` — rows are sorted by the first column, then ties are broken by the second column.

---

### 8. JOIN Queries
Learned how to combine data from multiple tables using different types of JOINs. Practiced retrieving related records across Employee, Department, and Project tables.

**Key JOIN types:**

| JOIN Type | What it returns |
|-----------|----------------|
| `INNER JOIN` | Only rows with a match in both tables |
| `LEFT JOIN` | All rows from the left table, NULLs where no match on the right |
| Self JOIN | Joining a table to itself to compare rows within the same table |

**Key concept:** `LEFT JOIN` combined with `WHERE column IS NULL` is a powerful pattern to find records that have *no* match in another table (e.g., employees without a department, departments without employees).

---

### 9. Nested and Correlated Queries
Learned to write subqueries — queries nested inside another query. Also practiced correlated subqueries where the inner query references values from the outer query row by row.

**Key concepts:**
- A **scalar subquery** returns a single value used in `WHERE` (e.g., `WHERE salary = (SELECT MAX(...))`)
- A **correlated subquery** references the outer query's current row — runs once per row
- `LIMIT 1 OFFSET n` can be used to get the nth highest value
- `IN (subquery)` filters rows based on a list returned by a subquery

---

### 10. Combined Moderate Difficulty Queries
Applied multiple SQL concepts together in a single query — combining `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`, `JOIN`, and subqueries to solve more realistic data questions.

**Key concept:** Real-world SQL queries often chain multiple clauses. The logical order of execution is: `FROM` → `JOIN` → `WHERE` → `GROUP BY` → `HAVING` → `SELECT` → `ORDER BY` → `LIMIT`.

---

## Key Learnings

- `ORDER BY` can sort by multiple columns — useful for tie-breaking within groups
- `INNER JOIN` returns only matched rows; `LEFT JOIN` preserves all rows from the left table with NULLs for unmatched rows
- A **self-join** lets you compare rows within the same table (e.g., finding colleagues in the same department)
- **Correlated subqueries** reference the outer query row — useful for per-row comparisons like "salary above their own department's average"
- `LIMIT 1 OFFSET n-1` retrieves the nth highest value without window functions
- `HAVING` can combine multiple aggregate conditions using `AND` / `OR`
- The SQL clause execution order matters — `WHERE` runs before grouping, `HAVING` runs after

---

## Resources Used

| Resource | Purpose |
|----------|---------|
| [W3Schools SQL](https://www.w3schools.com/sql/) | Reference for JOIN types and subquery syntax |
| [YouTube SQL Playlist](https://youtube.com/playlist?list=PLrZbzHGc7iABQ60q4X5IJOYaBM-ULmrVe&si=DbIRRCKzWUF6j_3F) | Video walkthroughs for advanced SQL concepts |
| [db-fiddle.com](https://www.db-fiddle.com/) | Writing and testing SQL queries hands-on |

---

## Files in This Folder

| File | Description |
|------|-------------|
| `Questions.txt` | All 35 SQL questions practised today |
| `Solutions.sql` | All 35 SQL queries solutions today |
| `README.md` | This file — summary of Day 2 learnings |
