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
	IATA_CODE NVARCHAR(5),
	AIRLINE NVARCHAR(100),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.airports', 'U') IS NOT NULL
    DROP TABLE silver.airports;
GO
  
CREATE TABLE silver.airports(
	IATA_CODE NVARCHAR(5),
	AIRPORT NVARCHAR(100),
	CITY NVARCHAR(50),
	STATE NVARCHAR(5),
	COUNTRY NVARCHAR(50),
	LATITUDE FLOAT,
	LONGITUDE FLOAT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.flights', 'U') IS NOT NULL
    DROP TABLE silver.flights;
GO
  
CREATE TABLE silver.flights(
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
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO
