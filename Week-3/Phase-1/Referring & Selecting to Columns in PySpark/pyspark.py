# 1. Column Names as Strings :

# Selecting columns by name
df_selectt = df.select("name", "age")

# Filtering based on a column condition
df_filter = df.filter("age > 30")


----------------------------------------------------------------------------------------------------------
# 2. DataFrame Column Notation (df.colName) :

# Selecting columns using dot notation
df_select = df.select(df.name, df.age)

# Filtering rows based on column conditions
df_filter = df.filter(df.age > 30)


-----------------------------------------------------------------------------------------------------------
# 3. Using col() Function :

from pyspark.sql.functions import col

# Selecting columns using col()
df_select = df.select(col("name"), col("age"))

# Filtering rows using col() for flexibility
age_column = "age"
df_filter = df.filter(col(age_column) > 30)


-----------------------------------------------------------------------------------------------------------
# 4. Bracket Notation (df["colName"]) :

# Selecting columns
df_select = df.select(df["name"], df["age"])

# Filtering with expressions
df_filter = df.filter(df["age"] > 30)

# Applying transformations
df_transform = df.select((df["age"] + 10).alias("age_plus_10"))


-----------------------------------------------------------------------------------------------------------
# 5. Using lit() for Constant Values :

from pyspark.sql.functions import lit

# Adding a constant column
df.select(df.name, lit(25).alias("constant_age"))

# Filtering based on a constant
df.filter(df.age > lit(30))


------------------------------------------------------------------------------------------------------------
# 6. Adding Columns with withColumn() :

from pyspark.sql.functions import col

# Adding a new column with a static value
df_with_constant = df.withColumn("status", lit("active"))

# Adding a new column based on an existing one
df_with_computed = df.withColumn("age_plus_5", col("age") + 5)


-------------------------------------------------------------------------------------------------------------
# 7. Renaming Columns with alias() :

# Renaming columns
selected_df = df.select(col("name").alias("employee_name"), col("age"))


--------------------------------------------------------------------------------------------------------------

# 8.Renaming Columns with withColumnRenamed()

# Renaming a single column
df_renamed = df.withColumnRenamed("name", "employee_name")

# Renaming multiple columns (chained)
df_renamed = df.withColumnRenamed("name", "employee_name") \
               .withColumnRenamed("age", "employee_age")

--------------------------------------------------------------------------------------------------------------

# 9 Selecting with Expressions:
from pyspark.sql.functions import expr

# Selecting with expressions
selected_df = df.select(expr("age + 1 AS next_year_age"), "department")


--------------------------------------------------------------------------------------------------------------

# 10. Selecting All Columns and Dropping Unwanted Ones :

# Selecting all columns except 'salary'
selected_df = df.select("*").drop("salary")


--------------------------------------------------------------------------------------------------------------

# 11. Using SQL Syntax :

# Registering the DataFrame as a temporary view
df.createOrReplaceTempView("employees")

# Using SQL to select columns
selected_df = spark.sql("SELECT name, age FROM employees")


-------------------------------------------------------------------------------------------------------------

# 12.Selecting Columns Dynamically :

# List of columns to select
columns_to_select = ["name", "age"]

# Dynamically selecting columns
selected_df = df.select(*columns_to_select)


--------------------------------------------------------------------------------------------------------------

# 13. Using drop() to Exclude Columns :

# Keeping all columns except 'salary' and 'address'
selected_df = df.drop("salary", "address")


----------------------------------------------------------------------------------------------------------------

# 14. Working with Nested Structures:

# Assuming `address` is a struct column with `city` and `state`
selected_df = df.select("name", "address.city", "address.state")
