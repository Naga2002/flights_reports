# flights_reports
The project overview is <b>Cloud_Data_Developer_-_Project_Challenge.pdf</b>

In Databricks:

<b>phDataFlightIngest.py</b> - ingest airline, airport and flights csv files and store in Snowflake<br>
<b>phDataSnowflakeReports.html</b> - read Snowflake report views and generate display visuals in notebook<br>

In Snowflake:

<b>create_tables.sql</b> - creates table structures for CSV data<br>
<b>monthly_flights.sql</b> - Total number of flights by airline and airport on a monthly basis<br>
<b>on_time_percent.sql</b> - On time percentage of each airline for the year 2015<br>
<b>airline_flights_delayed.sql</b> - Airlines with the largest number of delays<br>
<b>airport_cancel_reasons.sql</b> - Cancellation reasons by airport<br>
<b>airport_delay_reasons.sql</b> - Delay reasons by airport<br>
<b>unique_routes.sql</b> - Airline with the most unique routes<br>

In PowerBI:

<b>FlightsDashboard.pbix</b> - better visual options than Databricks
