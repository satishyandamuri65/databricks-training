# Initialize Spark session
from pyspark.sql import SparkSession
spark = SparkSession.builder.appName('Spark Playground').getOrCreate()

# Creating Dataframe 
customers_data = [
    (101, "Alice", "Hyderabad"),
    (102, "Bob", "Bangalore"),
    (103, "Charlie", "Chennai"),
    (104, "David", "Hyderabad"),
    (105, "Eva", "Mumbai"),
    (106, "Frank", "Delhi"),
    (107, "Grace", "Pune"),
    (108, "Henry", "Kolkata"),
    (109, "Ivy", "Hyderabad"),
    (110, "Jack", "Bangalore"),
    (111, "Kevin", "Chennai"),
    (112, "Lily", "Mumbai"),
    (113, "Mason", "Delhi"),
    (114, "Nancy", "Pune"),
    (115, "Oliver", "Hyderabad"),
    (116, "Priya", "Chennai"),
    (117, "Queen", "Bangalore"),
    (118, "Ryan", "Mumbai"),
    (119, "Sophia", "Delhi"),
    (120, "Tom", "Hyderabad"),
    (121, "Uma", "Chennai"),
    (122, "Victor", "Bangalore"),
    (123, "William", "Pune"),
    (None, "Unknown", "Mumbai"),   # Missing customer_id
    (125, "Zara", "Hyderabad")
]

customers = spark.createDataFrame(
    customers_data,
    ["customer_id", "customer_name", "city"]
)

orders_data = [
    (1001,101,250.0),
    (1002,101,450.0),
    (1003,102,300.0),
    (1004,103,700.0),
    (1005,103,150.0),
    (1006,103,400.0),
    (1007,105,500.0),
    (1008,105,250.0),
    (1009,101,100.0),
    (1010,107,350.0),
    (1011,108,900.0),
    (1012,109,150.0),
    (1013,110,200.0),
    (1014,111,450.0),
    (1015,112,600.0),
    (1016,113,750.0),
    (1017,114,300.0),
    (1018,115,550.0),
    (1019,116,800.0),
    (1020,117,650.0),
    (1021,118,1000.0),
    (1022,119,450.0),
    (1023,120,300.0),
    (1024,107,220.0),
    (1025,108,480.0),
    (1026,109,510.0),
    (1027,110,620.0),
    (1028,111,280.0),
    (1029,112,900.0),
    (1030,113,430.0),
    (1031,114,210.0),
    (1032,115,340.0),
    (1033,116,470.0),
    (1034,117,530.0),
    (1035,118,610.0),
    (1036,119,720.0),
    (1037,120,810.0),
    (1038,101,390.0),
    (1039,102,560.0),
    (1040,103,430.0),
    (1041,105,270.0),
    (1042,107,640.0),
    (1043,108,510.0),
    (1044,111,320.0),
    (1045,115,450.0),
    (1046,116,280.0),
    (1047,118,700.0),
    (1048,120,520.0),
    (1049,119,360.0),
    (1050,117,410.0),
    (1051,121,650.0),
    (1052,121,700.0),
    (1053,122,420.0),
    (1054,123,550.0),
    (1055,None,800.0),     # Missing customer_id
    (1056,125,900.0),
    (1057,125,250.0),
    (1058,108,900.0),      # Duplicate business value
    (1058,108,900.0),      # Exact duplicate row
    (1059,115,620.0)
]

orders = spark.createDataFrame(
    orders_data,
    ["order_id", "customer_id", "order_amount"]
)

# Show the first few rows of the DataFrame
customers.show()             #Output-1 
orders.show()                #output-2

# Display the DataFrame using the display() function.
display(customers)          
display(orders)            


#Mini Cleaning Tasks :
#1.Remove rows with missing customer_id from both the dataframes

orders = orders.dropna(subset = ["customer_id"]).dropDuplicates().orderBy("order_id")
orders.show()
dispaly(orders)


df = customers.dropna(subset= ["customer_id"])
df.show()
display(df) 


#Exercise 1: Total order amount for each customer
from pyspark.sql import functions as F
df = orders.groupBy("customer_id").agg(F.sum("order_amount").alias("total_spend"))

df.show()             #ouput-3

#Exercise 2: Top 3 customers by total spend
order_df = orders.groupBy("customer_id")\
                 .agg(F.sum("order_amount").alias("total_spend"))\
                 .orderBy(F.desc("total_spend"))

order_df.show(3)     #ouput-4

#Exercise 3: Customers with no orders 
customer_df = customers.join(orders , "customer_id" , "left_anti")

customer_df.show()   #output-5

#Exercise 4: City-wise total revenue
df = customers.join(orders , "customer_id" ,  "inner")\
              .groupBy("city")\
              .agg(F.sum("order_amount").alias("total_spend"))

df.show()             #output-6


#Exercise 5: Average order amount per customer
df1 = orders.groupBy("customer_id").agg(F.avg("order_amount").alias("avg_spend"))

df1.show()            #output-7


#Exercise 6: Customers with more than one order
df2 = orders.groupBy("customer_id").agg(F.count("customer_id").alias("count"))

df2.show()            #output-8


#Exercise 7: Sort customers by total spend descending
df3 = orders.groupBy("customer_id").agg(F.sum("order_amount").alias("Total_spend")).orderBy(F.desc("Total_spend"))

df3.show()            #output-9


