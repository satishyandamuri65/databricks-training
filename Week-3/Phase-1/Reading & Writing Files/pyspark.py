# Initialize SparkSession
from pytest import File

from pyspark.sql import SparkSession 
spark = SparkSession.builder\
                    .appName("MyPySparkApp")\
                    .getOrCreate()

# Read data from a file or folder using the specified file format and options
df = spark.read.format('file_formate')\
               .option('option_name', 'option_value')\
               .load('path_to_file_or_folder')

# Inspect data
df.show()                                         # print the stdout of te dataframe
display(df)                                       # print the dataframe in a tabular format in the notebook


# Reading a CSV  File :
df_csv = spark.read.format('csv')\
                 .option('header', 'true')\
                 .option('inferSchema', 'true')\
                 .option('mode', 'PERMISSIVE')\
                 .option('columnNameOfCorruptRecord', '_corrupt_record')\
                 .option('sep', ',')\
                 .option('quote', '"')\
                 .option('escape', '"')\
                 .option('multiLine', 'true')\
                 .load('path_to_csv_file')
df_csv.show()                                        
display(df_csv)                                     


# Reading a JSON File :
df_json = spark.read.format('json')\
                  .option('multiline', 'true')\
                  .option('inferSchema', 'true')\
                  .option('mode', 'PERMISSIVE')\
                  .option('columnNameOfCorruptRecord', '_corrupt_record')\
                  .load('path_to_json_file')
df_json.show()
display(df_json)


# Reading a Parquet File :
df_parquet = spark.read.format('parquet')\
                 .option('header', 'true')\
                 .option('inferSchema', 'true')\
                 .load('path_to_parquet_file')
df_parquet.show()
display(df_parquet)


# Reading a Hive table customers in default schema into a DataFrame :
df_hive = spark.read.table("default.customers")

df_hive.show()
df_hive.printSchema()


# Querying a Hive table with SQL :
df_hive_sql = spark.sql("SELECT id, name, email FROM default.customers WHERE country='US'")
df_hive_sql.show()


# Reading data from a PostgreSQL database into a DataFrame :
df = spark.read \
    .format("jdbc") \
    .option("url", "jdbc:postgresql://localhost:5432/mydb") \
    .option("dbtable", "public.customers") \
    .option("user", "postgres") \
    .option("password", "mypassword") \
    .load()


# Shortcut for Common Formats(csv, json, parquet) :
df_csv = spark.read.csv("path_to_csv_file", header=True, inferSchema=True)
df_json = spark.read.json("path_to_json_file", multiLine=True, inferSchema=True)
df_parquet = spark.read.parquet("path_to_parquet_file")



# Writing data to a file or folder using the specified file format and options

from pyspark.sql import SparkSession

# Initialize SparkSession
spark = SparkSession.builder \
                    .appName("Write File Example") \
                    .getOrCreate() 


# Write data
df.write \
    .format("<file_format>") \
    .option("<option_name>", "<option_value>") \
    .mode("<save_mode>") \
    .save("<path_to_output_file_or_folder>")

df.show()
display(df) 


# Writing a CSV File:
df_csv = df.write.formate("csv")\
                 .option("header", True)\
                 .option("inferSchema",True)\
                 .mode("overwrite")\
                 .mode("append")\
                 .mode("ignore")\
                 .mode("erroer")\
                 .save("path_to_output_csv_file")

df_csv.show()
display(df_csv)


# Writing a JSON File:
df_json = df.write.format("json")\
                    .option("multiline", True)\
                    .option("inferSchema",True)\
                    .mode("overwrite")\
                    .mode("append")\
                    .mode("ignore")\
                    .mode("error")\
                    .save("path_to_output_json_file")

df_json.show()
display(df_json)


# Writing a Parquet File:
df_parquet = df.write.format("parquet")\
                    .option("header", True)\
                    .option("inferSchema",True)\
                    .mode("overwrite")\
                    .mode("append")\
                    .mode("ignore")\
                    .mode("error")\
                    .save("path_to_output_parquet_file")
df_parquet.show()
display(df_parquet)


# Shortcut for common formats → for CSV, JSON, and Parquet:
df_csv.write.csv("path_to_output_csv_file", header=True, mode="overwrite")
df_json.write.json("path_to_output_json_file", mode="overwrite")
df_parquet.write.parquet("path_to_output_parquet_file", mode="overwrite")








