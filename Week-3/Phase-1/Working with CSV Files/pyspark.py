# Import the SparkSession class from the pyspark.sql module
from pyspark.sql import SparkSession

# Initialize SparkSession
spark = SparkSession.builder \
                    .appName("Working with CSV Files") \
                    .getOrCreate()

# Read a CSV file into a DataFrame
df = spark.read \
    .format("csv") \
    .option("header", True)\                 # Specify that the first row contains column names
    .option("inferSchema" , True)\           # Infer the schema of the data
    .load("/samples/sales.csv")

df.show()                 
display(df)               




# Write data to a CSV file
df_csv = df.write.format("csv")\
                    .option("header", True)\                 # Include column names in the output file
                    .option("inferSchema",True)\              # Infer the schema of the data
                    .mode("overwrite")\                       # Overwrite existing files
                    .mode("append")\                          # Append to existing files
                    .mode("ignore")\                          # Ignore if the file already exists
                    .mode("error")\                           # Raise an error if the file already exists
                    .save("/samples/output_sales.csv")

df_csv.show()       # Output at Screenshot1              
display(df_csv)     # Output at Screenshot2      


# Common format for reading and writing files in csv:
df_csv = spark.read.csv("/samples/sales.csv", header=True, inferSchema=True)      
df_csv.write.csv("/samples/output_sales.csv", header=True, mode="overwrite")


