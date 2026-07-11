# Week 2 - Day 4

## Overview

Day 4 practiced SQL on previous year Cognizant hiring questions. The questions are based on three databases — Hostel, Food Delivery Hotel, and Movie Ticket Booking. Covered DDL operations, joins, aggregate functions, CASE statements, and date-based filtering.

---

## Database 0 — Hostel

**Tables:** STUDENT_DETAILS

### Topics Covered

- INSERT multiple student records
- ALTER TABLE to modify column datatype

---

## Database 3 — Food Delivery Hotel

**Tables:** customers, delivery_partners, hotel_details, orders

### Topics Covered

- COALESCE to handle missing address and email
- CONCAT for customer mail info display
- Filtering customers with Gmail id using LIKE
- Filtering delivery partners by rating using BETWEEN
- CONCAT to display hotel info
- Subquery with NOT IN to find hotels with no orders in a specific month
- DISTINCT with INNER JOIN to find hotels by order month
- COUNT with HAVING to find hotels with more than 5 orders
- ALTER TABLE to change column datatype
- ALTER TABLE to rename a column
- UPDATE records for a specific customer
- INNER JOIN across three tables for order details
- CASE statement to classify delivery partner rating as GOOD, AVERAGE, WORST
- SUM with GROUP BY to display total sales per day

---

## Database 4 — Movie Ticket Booking

**Tables:** discount_master, booking_details

### Topics Covered

- MIN and MAX aggregate functions on discount amount
- COUNT with GROUP BY to find tickets booked per user

---
