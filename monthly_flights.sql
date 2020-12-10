DROP VIEW IF EXISTS  vMonthlyFlightsByAA;

CREATE VIEW vMonthlyFlightsByAA AS
WITH cteOriginAirports AS
(
  SELECT flts.year, flts.month, alns.airline, apts.airport, count(*) AS OriginFlights
  FROM USER_NMOTT.public.flights flts
  JOIN USER_NMOTT.PUBLIC.airlines alns ON flts.airline = alns.iata_code
  JOIN USER_NMOTT.PUBLIC.airports apts ON flts.origin_airport = apts.iata_code
  WHERE flts.cancelled = 0
  GROUP BY flts.year, flts.month, alns.airline, apts.airport
)
,cteDestinationAirports AS
(
  SELECT flts.year, flts.month, alns.airline, apts.airport, count(*) AS DestFlights
  FROM USER_NMOTT.public.flights flts
  JOIN USER_NMOTT.PUBLIC.airlines alns ON flts.airline = alns.iata_code
  JOIN USER_NMOTT.PUBLIC.airports apts ON flts.destination_airport = apts.iata_code
  WHERE flts.cancelled = 0
  GROUP BY flts.year, flts.month, alns.airline, apts.airport
)
SELECT oa.year
    ,oa.month
    ,oa.airline
    ,oa.airport
    ,SUM(oa.OriginFlights + da.DestFlights) AS TotalFlights
FROM cteOriginAirports oa
JOIN cteDestinationAirports da ON oa.year=da.year
    AND oa.month=da.month
    AND oa.airline=da.airline
    AND oa.airport = da.airport
GROUP BY  oa.year
    ,oa.month
    ,oa.airline
    ,oa.airport;  
