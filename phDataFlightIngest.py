# Databricks notebook source
from pyspark.sql import SparkSession
from pyspark.sql.types import *
import os

spark = SparkSession \
    .builder \
    .appName("Flight data to Snowflake") \
    .getOrCreate()

#define paths to files
airlines_path = '/FileStore/tables/phData/flight-data/airlines.csv'
airports_path = '/FileStore/tables/phData/flight-data/airports.csv'
flights_path = '/FileStore/tables/phData/flight-data/flights_tar.gz'

# COMMAND ----------

#create structs to define schema as given in project file
airlines_struct = StructType([ \
  StructField('iata_code', StringType(), False), \
  StructField('airline', StringType(), True) \
  ])
airports_struct = StructType([ \
  StructField('iata_code', StringType(), False), \
  StructField('airport', StringType(), True), \
  StructField('city', StringType(), True), \
  StructField('state', StringType(), True), \
  StructField('country', StringType(), True), \
  StructField('latitude', DoubleType(), True), \
  StructField('longitude', DoubleType(), True) \
  ])
flights_struct = StructType([ \
  StructField('year', IntegerType(), False), \
  StructField('month', IntegerType(), True), \
  StructField('day', IntegerType(), True), \
  StructField('day_of_week', IntegerType(), True), \
  StructField('airline', StringType(), True), \
  StructField('flight_number', StringType(), True), \
  StructField('tail_number', StringType(), True), \
  StructField('origin_airport', StringType(), True), \
  StructField('destination_airport', StringType(), True), \
  StructField('scheduled_departure', StringType(), True), \
  StructField('departure_time', IntegerType(), True), \
  StructField('departure_delay', IntegerType(), True), \
  StructField('taxi_out', StringType(), True), \
  StructField('wheels_off', IntegerType(), True), \
  StructField('scheduled_time', IntegerType(), True), \
  StructField('elapsed_time', IntegerType(), True), \
  StructField('air_time', IntegerType(), True), \
  StructField('distance', IntegerType(), True), \
  StructField('wheels_on', IntegerType(), True), \
  StructField('taxi_in', IntegerType(), True), \
  StructField('scheduled_arrival', StringType(), True), \
  StructField('arrival_time', StringType(), True), \
  StructField('arrival_delay', IntegerType(), True), \
  StructField('diverted', IntegerType(), True), \
  StructField('cancelled', IntegerType(), True), \
  StructField('cancellation_reason', StringType(), True), \
  StructField('air_system_delay', IntegerType(), True), \
  StructField('security_delay', IntegerType(), True), \
  StructField('airline_delay', IntegerType(), True), \
  StructField('late_aircraft_delay', IntegerType(), True), \
  StructField('weather_delay', IntegerType(), True) \
  ])

# COMMAND ----------

#define a dataframe for each set of files
airlines_df = spark.read \
               .format('csv') \
               .schema(airlines_struct) \
               .option('header', 'true') \
               .load(airlines_path)
airports_df = spark.read \
               .format('csv') \
               .schema(airports_struct) \
               .option('header', 'true') \
               .load(airports_path)
flights_df = spark.read \
               .format('csv') \
               .schema(flights_struct) \
               .option('header', 'true') \
               .load(flights_path)

# COMMAND ----------

#flights_df.printSchema()

# COMMAND ----------

#get snowflake credentials from environment vairables
# NOTE: I tried to use Databricks' Secrets API, but could not get it to work in Community Edition
user = os.environ.get('SNOWFLAKE_USER')
pwd = os.environ.get('SNOWFLAKE_PWD')

# COMMAND ----------

# snowflake connection options
options = {
  "sfUrl": "https://zg87399.us-east-2.aws.snowflakecomputing.com/",
  "sfUser": user,
  "sfPassword": pwd,
  "sfDatabase": "USER_NMOTT",
  "sfSchema": "PUBLIC",
  "sfWarehouse": "INTERVIEW_WH"
}

# COMMAND ----------

#write the data to the corresponding table in snowflake
airlines_df.write \
  .format("snowflake") \
  .options(**options) \
  .option("dbtable", "PUBLIC.airlines") \
  .mode("overwrite") \
  .save()

# COMMAND ----------

airports_df.write \
  .format("snowflake") \
  .options(**options) \
  .option("dbtable", "PUBLIC.airports") \
  .mode("overwrite") \
  .save()

# COMMAND ----------

flights_df.write \
  .format("snowflake") \
  .options(**options) \
  .option("dbtable", "PUBLIC.flights") \
  .mode("overwrite") \
  .save()
