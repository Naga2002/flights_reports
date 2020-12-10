DROP VIEW IF EXISTS  vAirportDelayReasons;

CREATE VIEW vAirportDelayReasons AS
WITH cteDelayReasons AS
(
SELECT apts.airport
    ,arrival_delay
    ,air_system_delay
    ,security_delay
    ,airline_delay
    ,late_aircraft_delay
    ,weather_delay
    --if one reason is null, the rest will be too
    ,IFF(air_system_delay IS NULL,arrival_delay, 0) AS no_reason_delay
FROM USER_NMOTT.public.flights flts
  JOIN USER_NMOTT.PUBLIC.airports apts ON flts.origin_airport = apts.iata_code
WHERE arrival_delay > 0
)
, cteSums AS
(SELECT airport
    ,SUM(arrival_delay) AS total_minutes_delay
    ,SUM(air_system_delay) AS air_system_delay
    ,SUM(security_delay) AS security_delay
    ,SUM(airline_delay) AS airline_delay
    ,SUM(late_aircraft_delay) AS late_aircraft_delay
    ,SUM(weather_delay) AS weather_delay
    ,SUM(no_reason_delay) AS no_reason_delay
FROM cteDelayReasons
GROUP BY airport
 )
SELECT airport
    ,total_minutes_delay
    ,CAST((air_system_delay/total_minutes_delay)*100 AS Numeric(20,2)) AS air_system_percent
    ,CAST((security_delay/total_minutes_delay)*100 AS Numeric(20,2)) AS security_percent
    ,CAST((airline_delay/total_minutes_delay)*100 AS Numeric(20,2)) AS airline_percent
    ,CAST((late_aircraft_delay/total_minutes_delay)*100 AS Numeric(20,2)) AS late_aircraft_percent
    ,CAST((weather_delay/total_minutes_delay)*100 AS Numeric(20,2)) AS weather_percent
    ,CAST((no_reason_delay/total_minutes_delay)*100 AS Numeric(20,2)) AS no_reason_percent
FROM cteSums

