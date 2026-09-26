/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'FlightDelaysAndCancellationsWarehouse'. 
    It also creates three schemas in the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'FlightDelaysAndCancellationsWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution and ensure you have a backup 
    of the database before running this script.
*/

USE master;
GO

-- Drop and recreate the 'FlightDelaysAndCancellationsWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'FlightDelaysAndCancellationsWarehouse')
BEGIN
    ALTER DATABASE FlightDelaysAndCancellationsWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE FlightDelaysAndCancellationsWarehouse;
END;
GO

-- Create the 'FlightDelaysAndCancellationsWarehouse' database
CREATE DATABASE FlightDelaysAndCancellationsWarehouse;
GO

USE FlightDelaysAndCancellationsWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
