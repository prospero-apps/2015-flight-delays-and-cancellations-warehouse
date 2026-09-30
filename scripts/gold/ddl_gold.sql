/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views in the 'gold' schema. The gold schema represents
    the final dimension and fact tables (Star Schema).
    These views can be queried directly for analytics and reporting.
===============================================================================
*/

IF OBJECT_ID('gold.dim_airlines', 'U') IS NOT NULL
    DROP VIEW gold.dim_airlines;
GO
  
CREATE VIEW gold.dim_airlines AS
SELECT
	ROW_NUMBER() OVER(ORDER BY iata_code) AS airline_key,
	iata_code,
	airline
FROM silver.airlines
GO

IF OBJECT_ID('gold.dim_airports', 'U') IS NOT NULL
    DROP VIEW gold.dim_airports;
GO
  
CREATE VIEW gold.dim_airports AS
SELECT
	ROW_NUMBER() OVER(ORDER BY iata_code) AS airport_key,
	iata_code,
	airport,
	city,
	state,
	country,
	latitude,
	longitude
FROM silver.airports
GO

IF OBJECT_ID('gold.fact_flights', 'U') IS NOT NULL
    DROP VIEW gold.fact_flights;
GO
  
CREATE VIEW gold.fact_flights AS
SELECT 
	al.airline_key,
	ap1.airport_key AS origin_airport_key,
	ap2.airport_key AS destination_airport_key,
	f.flight_date,
	f.day_of_week,	
	f.flight_number,
	f.tail_number,	
	f.scheduled_departure,
	f.departure_time,
	f.departure_delay,
	f.taxi_out,
	f.wheels_off,
	f.scheduled_time,
	f.elapsed_time,
	f.air_time,
	f.distance,
	f.wheels_on,
	f.taxi_in,
	f.scheduled_arrival,
	f.arrival_time,
	f.arrival_delay,
	f.diverted,
	f.cancelled,
	f.cancellation_reason,
	f.air_system_delay,
	f.security_delay,
	f.airline_delay,
	f.late_aircraft_delay,
	f.weather_delay
FROM silver.flights f
LEFT JOIN gold.dim_airlines al
ON f.airline = al.iata_code
LEFT JOIN gold.dim_airports ap1
ON f.origin_airport = ap1.iata_code
LEFT JOIN gold.dim_airports ap2
ON f.destination_airport = ap2.iata_code
GO
