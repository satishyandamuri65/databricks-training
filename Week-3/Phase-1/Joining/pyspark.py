# Syntax and Parameters for join() :

DataFrame.join(other, on=None, how=None)


-----------------------------------------------------------------------------------------------------------
# 1. Inner Join (Default Join) :

df_inner = df1.join(df2 , on = "common_column" , how = "inner")  # or how = "inner" or how = "cross"

-----------------------------------------------------------------------------------------------------------

# 2. Left Outer Join:

df_left_outer = df1.join(df2 , on = "common_column" , how = "left_outer")  # or how = "left"

-----------------------------------------------------------------------------------------------------------

# 3. Left Anti Join:

df_left_anti = df1.join(df2 , on = "common_column" , how = "left_anti")  # or how = "leftanti"

-----------------------------------------------------------------------------------------------------------

# 4. Joining on Multiple Columns :

df_multi = df1.join(df2, on=["column1", "column2"], how="inner")

# Joining Without Specifying on :
##If the column names are the same in both DataFrames, you can omit the on parameter

result = df1.join(df2, how="inner")
result.show()

-----------------------------------------------------------------------------------------------------------

# 5. Using Conditions in Joins :

df_result = df1.join(df2, (df1["column1"] == df2["column1"]) & (df1["column2"] == df2["column2"]), how="inner")

-------------------------------------------------------------------------------------------------------------

# 6. Joining 2 Dataframes, Selecting all columns from the first and some columns from the second :

result_df = sales_df.join(customers_df, on = ["customer_id"], how="inner").select
(
    sales_df["*"],  # All columns from sales_df
    customers_df["name"].alias("customer_name")  # Specific column from customers_df
)

-------------------------------------------------------------------------------------------------------------


