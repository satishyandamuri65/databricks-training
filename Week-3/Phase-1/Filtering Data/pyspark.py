# 1. Basic Filtering: Using filter() and where() Methods :

# Example of basic filtering
filtered_df = df.filter(df["age"] > 30)
# or
filtered_df = df.where("age > 30")

-----------------------------------------------------------------------------------------------------------

# 2. Combining Conditions with Logical Operators :

filtered_df = df.filter((df["age"] > 30) & (df["salary"] > 50000))
filtered_df = df.filter((df["age"] > 30) | (df["department"] == "HR"))
filtered_df = df.filter(~(df["department"] == "HR"))

------------------------------------------------------------------------------------------------------------

# 3. Filtering with String Conditions

filtered_df = df.filter("age > 30 AND department = 'HR'")

------------------------------------------------------------------------------------------------------------

# 4. Filtering with the isin() Method :

# Filtering where the department is either 'HR' or 'Finance'
filtered_df = df.filter(df["department"].isin("HR", "Finance"))


-------------------------------------------------------------------------------------------------------------

# 5. Filtering with startswith() :

# Filtering rows where the name starts with 'A'
filtered_df = df.filter(df["name"].startswith("A"))


--------------------------------------------------------------------------------------------------------------

# 6. Filtering with endswith() :

# Filtering rows where the name ends with 'son'
filtered_df = df.filter(df["name"].endswith("son"))


--------------------------------------------------------------------------------------------------------------
# 7. Filtering with like() and rlike() for Pattern Matching :

# Names starting with 'A'
filtered_df = df.filter(df["name"].like("A%"))

# Names containing 'son'
filtered_df = df.filter(df["name"].rlike("son"))

--------------------------------------------------------------------------------------------------------------

# 8. Null Handling: isNull() and isNotNull() :

# Filter rows where age is NULL
filtered_df = df.filter(df["age"].isNull())

# Filter rows where age is NOT NULL
filtered_df = df.filter(df["age"].isNotNull())

---------------------------------------------------------------------------------------------------------------
# 9. Filtering with SQL Queries (Using sql() Method) :

# Register the DataFrame as a temporary table
df.createOrReplaceTempView("employees")

# Use SQL query for filtering
filtered_df = spark.sql("SELECT * FROM employees WHERE age > 30")

---------------------------------------------------------------------------------------------------------------

