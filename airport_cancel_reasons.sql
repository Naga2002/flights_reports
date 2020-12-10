DROP VIEW IF EXISTS  vAirportCancelReasons;

CREATE VIEW vAirportCancelReasons AS
/*CANCELLATION_REASON String Reason for Cancellation of flight: A -
Airline/Carrier; B - Weather; C - National Air
System; D - Security
*/
SELECT apts.airport
        ,CASE flts.cancellation_reason
            WHEN 'A' THEN 'Airline/Carrier'
            WHEN 'B' THEN 'Weather'
            WHEN 'C' THEN 'National Air System'
            WHEN 'D' THEN 'Security'
            ELSE 'Unknown' END AS cancellation_reason
FROM USER_NMOTT.public.flights flts
JOIN USER_NMOTT.public.airports apts ON flts.origin_airport = apts.iata_code
WHERE flts.Cancelled = 1;

