DROP VIEW IF EXISTS vAirlineOnTimePercent;

CREATE VIEW vAirlineOnTimePercent AS
WITH cteBase AS
(
  SELECT alns.airline, flts.arrival_delay
  FROM USER_NMOTT.public.flights flts
  JOIN USER_NMOTT.PUBLIC.airlines alns ON flts.airline = alns.iata_code
  WHERE flts.cancelled = 0
  AND flts.year=2015
)
, cteOnTimeByAirline AS
(
SELECT airline, CAST(Count(*) AS NUMERIC(20,2)) AS OnTimeFlights
FROM cteBase
WHERE arrival_delay <=0
GROUP BY airline
)
,cteTotalByAirline AS (
  SELECT airline, CAST(Count(*) AS NUMERIC(20,2)) AS TotalFlights
  FROM cteBase
  GROUP BY airline
)
 SELECT ota.airline, ta.TotalFlights
    ,CAST((ota.OnTimeFlights / ta.TotalFlights)*100 AS Numeric(20,2)) AS PercentageOnTime
 FROM cteOnTimeByAirline ota
 JOIN cteTotalByAirline ta ON ota.airline=ta.airline
 