/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates the tables in the 'bronze' schema, dropping existing ones 
    if they already exist. 
     Run this script to re-define the DDL structure of 'bronze' tables.
===============================================================================
*/

IF OBJECT_ID('bronze.airlines', 'U') IS NOT NULL
    DROP TABLE bronze.airlines;
GO

CREATE TABLE bronze.airlines(
	IATA_CODE NVARCHAR(5),
	AIRLINE NVARCHAR(100)
);
GO

IF OBJECT_ID('bronze.airports', 'U') IS NOT NULL
    DROP TABLE bronze.airports;
GO
  
CREATE TABLE bronze.airports(
	IATA_CODE NVARCHAR(5),
	AIRPORT NVARCHAR(100),
	CITY NVARCHAR(50),
	STATE NVARCHAR(5),
	COUNTRY NVARCHAR(50),
	LATITUDE FLOAT,
	LONGITUDE FLOAT
);
GO

IF OBJECT_ID('bronze.flights', 'U') IS NOT NULL
    DROP TABLE bronze.flights;
GO
  
CREATE TABLE bronze.flights(
	YEAR INT,
	MONTH INT,	
	DAY INT,	
	DAY_OF_WEEK INT,	
	AIRLINE	NVARCHAR(5),
	FLIGHT_NUMBER INT,
	TAIL_NUMBER	NVARCHAR(20),
	ORIGIN_AIRPORT NVARCHAR(5),	
	DESTINATION_AIRPORT NVARCHAR(5),	
	SCHEDULED_DEPARTURE	INT,
	DEPARTURE_TIME INT, 
	DEPARTURE_DELAY	INT,
	TAXI_OUT INT,
	WHEELS_OFF INT,
	SCHEDULED_TIME INT,	
	ELAPSED_TIME INT,	
	AIR_TIME INT,	
	DISTANCE INT,	
	WHEELS_ON INT,	
	TAXI_IN	 INT,
	SCHEDULED_ARRIVAL INT,
	ARRIVAL_TIME INT,	
	ARRIVAL_DELAY INT,	
	DIVERTED INT,	
	CANCELLED INT,	
	CANCELLATION_REASON	CHAR(1),
	AIR_SYSTEM_DELAY INT,	
	SECURITY_DELAY INT,	
	AIRLINE_DELAY INT,	
	LATE_AIRCRAFT_DELAY INT,	
	WEATHER_DELAY INT,
);
GO
