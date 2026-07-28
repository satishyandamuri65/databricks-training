# SQL to PySpark – Phase 2 Bridge Pack

## 📌 Project Overview

This project contains solutions for the **SQL to PySpark – Phase 2 Bridge Pack**. The objective is to strengthen SQL concepts by implementing equivalent solutions in PySpark while working with realistic customer and order datasets.

The project focuses on data cleaning, joins, aggregations, sorting, and filtering—core skills required in Data Engineering and Data Analytics.

---

## 🛠️ Technologies Used

* Python
* PySpark
* Apache Spark
* SQL

---

## 📂 Dataset

Two DataFrames were created for practice:

### Customers

Contains customer information:

* customer_id
* customer_name
* city

### Orders

Contains order details:

* order_id
* customer_id
* order_amount

The datasets were intentionally designed with:

* Multiple customers
* Multiple orders per customer
* Customers without orders
* Duplicate records
* Missing values (`NULL`)
* Multiple cities

This helps simulate real-world ETL scenarios.

---

## 🧹 Data Cleaning Performed

Before solving the exercises, the following cleaning operations were performed:

* Removed rows with missing `customer_id`
* Removed duplicate records
* Verified schema using `printSchema()`
* Displayed data using `show()`
* Casted numeric columns where required

Example:

```python
customers = customers.dropna(subset=["customer_id"])
orders = orders.dropna(subset=["customer_id"])
orders = orders.dropDuplicates()
```

---

## 📚 Exercises Completed

### Exercise 1

**Total order amount for each customer**

* SQL
* PySpark (`groupBy`, `sum`)

---

### Exercise 2

**Top 3 customers by total spend**

* Aggregation using `SUM`
* Sorting using `orderBy(desc())`
* Displaying top records

---

### Exercise 3

**Customers with no orders**

Implemented using:

* SQL `LEFT JOIN`
* PySpark `LEFT ANTI JOIN`

---

### Exercise 4

**City-wise total revenue**

Performed:

* Inner Join
* Group By
* Sum Aggregation

---

### Exercise 5

**Average order amount per customer**

Implemented using:

* SQL `AVG()`
* PySpark `avg()`

---

## 🔑 PySpark Concepts Practiced

* DataFrame Operations
* groupBy()
* agg()
* sum()
* avg()
* orderBy()
* desc()
* join()
* left_anti join
* dropna()
* dropDuplicates()
* alias()
* show()
* printSchema()

---

## 📖 Key Learnings

Through this project, I learned how to:

* Translate SQL queries into PySpark transformations.
* Clean datasets before performing analysis.
* Work with joins and aggregations efficiently.
* Use PySpark DataFrame APIs for data processing.
* Solve real-world data engineering tasks using Spark.

---

## 🚀 Future Improvements

* Add window functions
* Practice advanced joins
* Implement ranking functions
* Work with larger datasets
* Explore Spark SQL optimization techniques

---

## 📁 Repository Structure

```
SQL-to-PySpark-Bridge-Pack/
│
├── pyspark.py
├── Outputs
└── README.md
```

---

## 👨‍💻 Author

**Satish Yandamuri**

Aspiring Data Analyst | Data Engineering Enthusiast | Generative AI Learner

GitHub: https://github.com/satishyandamuri65

---