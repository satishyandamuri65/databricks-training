from pyspark.sql import SparkSession

# Initialize the SparkSession
spark = SparkSession.builder \
    .appName("JSON Handling in PySpark") \
    .getOrCreate()

# Reading a JSON File:
df_json = spark.read.format("json")\
                    .option("multiline", True)\                
                    .option("inferSchema",True)\                 
                    .load("path_to_input_json_file") 

# Write data to a JSON file:
df_json = df.write.format("json")\
                    .option("multiline", True)\                
                    .option("inferSchema",True)\                 
                    .mode("overwrite")\                       
                    .mode("append")\                          
                    .mode("ignore")\                          
                    .mode("error")\                           
                    .save("path_to_output_json_file")

df_json.show()       # Output at Screenshot1
display(df_json)     # Output at Screenshot2


