from pyspark.sql import SparkSession
spark = SparkSession.builder.appName("Spark playground").getOrCreate()

#Creating the customers dataframe

customers_data = [
    (101,"Alice",25,"Hyderabad"),
    (102,"Bob",30,"Bangalore"),
    (103,"Charlie",None,"Hyderabad"),
    (104,"David",-5,"Chennai"),
    (105,"Eva",28,None),
    (106,"Frank",35,"Bangalore"),
    (107,"Grace",40,"Hyderabad"),
    (108,"Henry",None,"Chennai"),
    (109,"Ivy",22,"Delhi"),
    (110,"Jack",29,"Mumbai"),
    (111,"Kevin",31,"Pune"),
    (112,"Lily",26,"Hyderabad"),
    (113,"Mason",33,"Bangalore"),
    (114,"Nina",45,"Delhi"),
    (115,"Oscar",38,"Mumbai"),
    (116,"Peter",27,"Chennai"),
    (117,"Queen",None,"Hyderabad"),
    (118,"Ryan",-2,"Pune"),
    (119,"Sophia",24,"Bangalore"),
    (120,"Tom",36,"Delhi"),
    (121,"Uma",29,"Hyderabad"),
    (122,"Victor",41,"Mumbai"),
    (123,"William",34,"Pune"),
    (124,"Xavier",None,"Chennai"),
    (125,"Yash",21,"Hyderabad"),
    (126,"Zara",32,"Bangalore"),
    (127,"Aarav",39,"Delhi"),
    (128,"Bhavya",23,None),
    (129,"Catherine",37,"Mumbai"),
    (130,"Deepak",28,"Hyderabad")
]

customers_df = spark.createDataFrame(
    customers_data,
    ["customer_id","name","age","city"]
)

# Creating orders dataframe

orders_data = [
(1,101,"2026-07-01",1500),
(2,102,"2026-07-01",2000),
(3,101,"2026-07-02",1000),
(4,103,"2026-07-02",None),
(5,104,"2026-07-03",3000),
(6,105,"2026-07-03",2500),
(7,101,"2026-07-03",1200),
(8,106,"2026-07-04",4000),
(9,107,"2026-07-04",1800),
(10,102,"2026-07-05",2200),
(11,106,"2026-07-05",1500),
(12,106,"2026-07-06",1800),
(13,108,"2026-07-06",900),
(14,109,"2026-07-07",1200),
(15,110,"2026-07-07",3500),
(16,111,"2026-07-08",4100),
(17,112,"2026-07-08",2800),
(18,113,"2026-07-08",3300),
(19,114,"2026-07-09",2700),
(20,115,"2026-07-09",3900),
(21,116,"2026-07-10",1100),
(22,117,"2026-07-10",None),
(23,118,"2026-07-10",1400),
(24,119,"2026-07-11",2200),
(25,120,"2026-07-11",3100),
(26,121,"2026-07-11",1800),
(27,122,"2026-07-12",2900),
(28,123,"2026-07-12",4100),
(29,124,"2026-07-13",2000),
(30,125,"2026-07-13",900),
(31,126,"2026-07-13",1500),
(32,127,"2026-07-14",2600),
(33,128,"2026-07-14",3500),
(34,129,"2026-07-14",4200),
(35,130,"2026-07-15",1700),
(36,101,"2026-07-15",2100),
(37,102,"2026-07-15",3200),
(38,103,"2026-07-16",2500),
(39,104,"2026-07-16",1800),
(40,105,"2026-07-16",1200),
(41,106,"2026-07-17",2300),
(42,107,"2026-07-17",2600),
(43,108,"2026-07-17",3100),
(44,109,"2026-07-18",2900),
(45,110,"2026-07-18",1500),
(46,111,"2026-07-18",1800),
(47,112,"2026-07-19",2700),
(48,113,"2026-07-19",3300),
(49,114,"2026-07-20",2100),
(50,115,"2026-07-20",2400),
(51,116,"2026-07-20",1200),
(52,117,"2026-07-21",2000),
(53,118,"2026-07-21",1700),
(54,119,"2026-07-22",3100),
(55,120,"2026-07-22",4500),
(56,121,"2026-07-22",1900),
(57,122,"2026-07-23",2600),
(58,123,"2026-07-23",3700),
(59,124,"2026-07-24",1400),
(60,125,"2026-07-24",2200)
]

orders_df = spark.createDataFrame(
    orders_data,
    ["order_id","customer_id","order_date","amount"]
)

# Creating Sales dataframe 

sales_data = [
("2026-07-01","Laptop",2,50000),
("2026-07-01","Mouse",5,5000),
("2026-07-01","Keyboard",4,12000),
("2026-07-02","Monitor",1,None),
("2026-07-02","Laptop",3,75000),
("2026-07-02","Mouse",7,7000),
("2026-07-03","Keyboard",2,6000),
("2026-07-03","Monitor",2,30000),
("2026-07-03","Laptop",1,25000),
("2026-07-04","Mouse",8,8000),
("2026-07-04","Keyboard",5,15000),
("2026-07-04","Laptop",2,50000),
("2026-07-05","Monitor",3,45000),
("2026-07-05","Laptop",1,25000),
("2026-07-05","Mouse",6,6000),
("2026-07-06","Keyboard",4,12000),
("2026-07-06","Monitor",2,30000),
("2026-07-07","Laptop",3,75000),
("2026-07-07","Mouse",5,5000),
("2026-07-07","Keyboard",6,18000),
("2026-07-08","Monitor",1,15000),
("2026-07-08","Laptop",2,50000),
("2026-07-09","Mouse",4,4000),
("2026-07-09","Keyboard",3,9000),
("2026-07-10","Laptop",1,25000),
("2026-07-10","Monitor",2,30000),
("2026-07-11","Mouse",7,7000),
("2026-07-11","Keyboard",5,15000),
("2026-07-12","Laptop",4,100000),
("2026-07-12","Monitor",3,45000),
("2026-07-13","Mouse",8,8000),
("2026-07-13","Keyboard",4,12000),
("2026-07-14","Laptop",2,50000),
("2026-07-14","Monitor",2,30000),
("2026-07-15","Mouse",5,5000),
("2026-07-15","Keyboard",6,18000),
("2026-07-16","Laptop",3,75000),
("2026-07-16","Monitor",1,15000),
("2026-07-17","Mouse",4,4000),
("2026-07-17","Keyboard",5,15000)
]

sales_df = spark.createDataFrame(
    sales_data,
    ["sale_date","product","quantity","amount"]
)

# Business Pipeline Exercise 1
# Daily Sales

from pyspark.sql.functions import *
daily_sales = sales_df.groupBy("sale_date").agg(sum("amount").alias("total_sales"))
daily_sales.show()             #Output 1

#Business Pipeline Exercise 2
#City-wise Revenue

df1  = customers_df.join(orders_df , "customer_id" , "inner").groupBy("city").agg(sum("amount").alias("total_revenue"))
df1.show()                     #Output 2           

# Business Pipeline Exercise 3
#Find Repeat Customers (>2 Orders)

df2 = orders_df.groupBy("customer_id").agg(count("order_id").alias("total_orders")).filter(col("total_orders")>2)
df2.show()                     #Output 3


#Business Pipeline Exercise 4
#Highest Spending Customer in Each City


df= customers_df.dropna(subset = ["city"])
df.show()                      #Output 4

from pyspark.sql.functions import * 
from pyspark.sql.window import Window
customer_spend = df.join(orders_df, "customer_id","inner")\
                  .groupBy("customer_id","city","name")\
                  .agg(sum("amount").alias("total_spend"))


window = Window.partitionBy("city")\
                .orderBy(col("total_spend").desc())

Highest_spender = customer_spend.withColumn("rank" , row_number().over(window)).filter(col("rank")==1)

Highest_spender.show()         #Output 5

# Business Pipeline Exercise 5
#Final Reporting Table

report = customers_df.join(orders_df,"customer_id" , "inner")\
                    .groupBy("city","name","customer_id")\
                    .agg(sum("amount").alias("total_spend"),
                         count("order_id").alias("count"))

report.show()                  #Output 6                                                      
                  