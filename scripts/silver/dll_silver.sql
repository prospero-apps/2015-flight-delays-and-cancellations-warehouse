/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates the tables in the 'silver' schema, dropping existing ones 
    if they already exist. 
    Run this script to re-define the DDL structure of 'silver' tables.
===============================================================================
*/

IF OBJECT_ID('silver.airlines', 'U') IS NOT NULL
    DROP TABLE silver.airlines;
GO

CREATE TABLE silver.airlines(
	iata_code NVARCHAR(5),
	airline NVARCHAR(100),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.airports', 'U') IS NOT NULL
    DROP TABLE silver.airports;
GO
  
CREATE TABLE silver.airports(
	iata_code NVARCHAR(5),
	airport NVARCHAR(100),
	city NVARCHAR(50),
	state NVARCHAR(5),
	country NVARCHAR(50),
	latitude FLOAT,
	longitude FLOAT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.flights', 'U') IS NOT NULL
    DROP TABLE silver.flights;
GO
  
CREATE TABLE silver.flights(
	flight_date DATE,	
	day_of_week VARCHAR(3),	
	airline	NVARCHAR(5),
	flight_number INT,
	tail_number	NVARCHAR(20),
	origin_airport NVARCHAR(5),	
	destination_airport NVARCHAR(5),	
	scheduled_departure	INT,
	departure_time INT, 
	departure_delay	INT,
	taxi_out INT,
	wheels_off INT,
	scheduled_time INT,	
	elapsed_time INT,	
	air_time INT,	
	distance INT,	
	wheels_on INT,	
	taxi_in	 INT,
	scheduled_arrival INT,
	arrival_time INT,	
	arrival_delay INT,	
	diverted INT,	
	cancelled INT,	
	cancellation_reason	CHAR(1),
	air_system_delay INT,	
	security_delay INT,	
	airline_delay INT,	
	late_aircraft_delay INT,	
	weather_delay INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO
