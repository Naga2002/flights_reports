USE DATABASE USER_NMOTT;

DROP TABLE IF EXISTS USER_NMOTT.public.airlines;

CREATE TABLE IF NOT EXISTS USER_NMOTT.public.airlines (
  iata_code string() NOT NULL
  ,airline string
);

DROP TABLE IF EXISTS USER_NMOTT.public.airports;

CREATE TABLE IF NOT EXISTS USER_NMOTT.public.airports(
   iata_code String NOT NULL
  ,airport String
  ,city String
  ,state String
  ,country String
  ,latitude Number
  ,longitude Number
  );


DROP TABLE IF EXISTS USER_NMOTT.public.flights;

CREATE TABLE IF NOT EXISTS USER_NMOTT.public.flights(
   year Number
  ,month Number
  ,day Number
  ,day_of_week Number
  ,airline String
  ,flight_number String
  ,tail_number String
  ,origin_airport String
  ,destination_airport String
  ,scheduled_departure String
  ,departure_time String
  ,departure_delay Number
  ,taxi_out Number
  ,wheels_off String
  ,scheduled_time Number
  ,elapsed_time Number
  ,air_time Number
  ,distance Number
  ,wheels_on Number
  ,taxi_in Number
  ,scheduled_arrival Number
  ,arrival_time String
  ,arrival_delay String
  ,diverted Number
  ,cancelled Number
  ,cancellation_reason String
  ,air_system_delay Number
  ,security_delay Number
  ,airline_delay Number
  ,late_aircraft_delay Number
  ,weather_delay Number
  )