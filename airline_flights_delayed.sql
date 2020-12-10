DROP VIEW IF EXISTS  vAirlineFlightsDelayed;

CREATE VIEW vAirlineFlightsDelayed AS
WITH cteDelayBinary AS
(
    SELECT flts.airline, flts.airport
    ,IFF(flts.arrival_delay > 0 OR flts.departure_delay > 0, 1, 0) AS DelayedBinary
    FROM USER_NMOTT.public.flights flts
)
SELECT alns.airline, SUM(DelayedBinary) AS FlightsDelayed
FROM cteDelayBinary db
JOIN USER_NMOTT.PUBLIC.airlines alns ON db.airline = alns.iata_code
GROUP BY alns.airline;