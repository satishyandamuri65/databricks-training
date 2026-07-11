# Grouping Data with groupBy() :

# Example: Grouping by a single column
grouped_df = df.groupBy("department")

# Example: Grouping by multiple columns
grouped_df = df.groupBy("department", "location")


-----------------------------------------------------------------------------------------------------------

# Using F as Functions for Aggregations :

#Aggregation basics
from pyspark.sql import functions as F

# Performing a single aggregation
grouped_sum = df.groupBy("department").sum("salary")

# Using F for aggregation and renaming the aggregate column
aggregated_df = df.groupBy("department").agg(F.sum("salary").alias("total_salary"))

#Performing multiple aggregations
aggregated_df = df.groupBy("department").agg(
    F.sum("salary").alias("total_salary"),
    F.avg("salary").alias("average_salary"),
    F.count("*").alias("employee_count")
)

------------------------------------------------------------------------------------------------------------

# Common Aggregation Functions :
count(): Counts the number of rows in each group.

# Counting rows per department
grouped_count = df.groupBy("department").count()
sum(): Calculates the total of a numeric column.

# Summing salaries in each department
grouped_sum = df.groupBy("department").sum("salary")
avg(): Computes the average of a numeric column.

# Average salary per department
grouped_avg = df.groupBy("department").avg("salary")
min() and max(): Finds the minimum or maximum value for each group.

# Minimum and maximum salary per department
grouped_min_max = df.groupBy("department").min("salary").max("salary")
countDistinct(): Counts the distinct values in a column for each group.

# Counting distinct job roles per department
distinct_count = df.groupBy("department").agg(F.countDistinct("job_role").alias("unique_roles"))
