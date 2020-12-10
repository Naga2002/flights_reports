# flights_reports
The project overview is Cloud_Data_Developer_-_Project_Challenge.pdf

In Databricks:
phDataFlightIngest.py - ingest airline, airport and flights csv files and store in Snowflake
phDataSnowflakeReports.html - read Snowflake report views and generate display visuals in notebook

In Snowflake:
create_tables.sql - creates table structures for CSV data
monthly_flights.sql - Total number of flights by airline and airport on a monthly basis
on_time_percent.sql - On time percentage of each airline for the year 2015
airline_flights_delayed.sql - Airlines with the largest number of delays
airport_cancel_reasons.sql - Cancellation reasons by airport
airport_delay_reasons.sql - Delay reasons by airport
unique_routes.sql - Airline with the most unique routes

In PowerBI:
FlightsDashboard.pbix - better visual options than Databricks
