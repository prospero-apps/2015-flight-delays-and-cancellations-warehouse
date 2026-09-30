/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema with data
	for June 2015.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC silver.load_silver;
===============================================================================
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '================================================';
        PRINT 'Loading Silver Layer';
        PRINT '================================================';

		-- Loading silver.airlines
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.airlines';
		TRUNCATE TABLE silver.airlines;
		PRINT '>> Inserting Data Into: silver.airlines';
		INSERT INTO silver.airlines(
			iata_code,
			airline
		)
		SELECT
			TRIM(IATA_CODE) AS iata_code,
			TRIM(AIRLINE) AS airline
		FROM bronze.airlines
		WHERE IATA_CODE IS NOT NULL
		SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

		-- Loading silver.airports
        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.airports';
		TRUNCATE TABLE silver.airports;
		PRINT '>> Inserting Data Into: silver.airports';
		INSERT INTO silver.airports(
			iata_code,
			airport,
			city,
			state,
			country,
			latitude,
			longitude
		)
		SELECT
			TRIM(IATA_CODE) AS iata_code,
			TRIM(AIRPORT) AS airport,
			TRIM(CITY) AS city,
			TRIM(STATE) AS state,
			TRIM(COUNTRY) AS country,
			LATITUDE as latitude,
			LONGITUDE as logitude
		FROM bronze.airports
		WHERE IATA_CODE IS NOT NULL
		SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

        -- Loading silver.flights
        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.flights';
		TRUNCATE TABLE silver.flights;
		PRINT '>> Inserting Data Into: silver.flights';
		INSERT INTO silver.flights(
			flight_date,	
			day_of_week,	
			airline,
			flight_number,
			tail_number,
			origin_airport,	
			destination_airport,	
			scheduled_departure,
			departure_time, 
			departure_delay,
			taxi_out,
			wheels_off,
			scheduled_time,	
			elapsed_time,	
			air_time,	
			distance,	
			wheels_on,	
			taxi_in,
			scheduled_arrival,
			arrival_time,	
			arrival_delay,	
			diverted,	
			cancelled,	
			cancellation_reason,
			air_system_delay,	
			security_delay,	
			airline_delay,	
			late_aircraft_delay,	
			weather_delay
		)
		
		SELECT
			t1.flight_date,
			LEFT(DATENAME(WEEKDAY, t1.flight_date), 3) AS day_of_week,
			TRIM(UPPER(AIRLINE)) AS airline,
			FLIGHT_NUMBER AS flight_number,
			TRIM(UPPER(TAIL_NUMBER)) AS tail_number,
			TRIM(UPPER(ORIGIN_AIRPORT)) AS origin_airport,
			TRIM(UPPER(DESTINATION_AIRPORT)) AS destination_airport,
			t2.scheduled_departure,
			t2.departure_time,
			DATEDIFF(minute, t2.scheduled_departure, t2.departure_time) AS departure_delay,
			TAXI_OUT AS taxi_out,
			t1.wheels_off,
			SCHEDULED_TIME AS scheduled_time,
			AIR_TIME + TAXI_IN + TAXI_OUT AS elapsed_time,
			AIR_TIME AS air_time,
			DISTANCE AS distance,	
			t1.wheels_on,
			TAXI_IN as taxi_in,
			t2.scheduled_arrival,
			t2.arrival_time,
			DATEDIFF(minute, t2.scheduled_arrival, t2.arrival_time) AS arrival_delay,
			DIVERTED as diverted,
			CANCELLED as cancelled,
			CASE
				WHEN UPPER(CANCELLATION_REASON) = 'A' THEN 'Airline/Carrier'
				WHEN UPPER(CANCELLATION_REASON) = 'B' THEN 'Weather'
				WHEN UPPER(CANCELLATION_REASON) = 'C' THEN 'National Air System'
				WHEN UPPER(CANCELLATION_REASON) = 'D' THEN 'Security'
				ELSE 'n/a'
			END AS cancellation_reason,
			AIR_SYSTEM_DELAY AS air_system_delay,
			SECURITY_DELAY AS security_delay,
			AIRLINE_DELAY AS airline_delay,
			LATE_AIRCRAFT_DELAY AS late_aircraft_delay,
			WEATHER_DELAY AS weather_delay
		FROM bronze.flights

		CROSS APPLY
		(
			SELECT 
				DATEFROMPARTS(YEAR, MONTH, DAY) AS flight_date,
				CASE
					WHEN WHEELS_OFF = 2400 THEN DATEADD(day, 1, DATETIMEFROMPARTS(YEAR, MONTH, DAY, 0, 0, 0, 0))
					ELSE DATETIME2FROMPARTS(YEAR, MONTH, DAY, WHEELS_OFF / 100, WHEELS_OFF % 100, 0, 0, 0)
				END AS wheels_off,
				CASE
					WHEN WHEELS_ON = 2400 THEN DATEADD(day, 1, DATETIMEFROMPARTS(YEAR, MONTH, DAY, 0, 0, 0, 0))
					ELSE DATETIME2FROMPARTS(YEAR, MONTH, DAY, WHEELS_ON / 100, WHEELS_ON % 100, 0, 0, 0)
				END AS wheels_on
		) AS t1

		CROSS APPLY
		(
			SELECT 
				CASE
					WHEN SCHEDULED_DEPARTURE = 2400 THEN DATEADD(day, 1, DATETIMEFROMPARTS(YEAR, MONTH, DAY, 0, 0, 0, 0))
					ELSE DATETIME2FROMPARTS(YEAR, MONTH, DAY, SCHEDULED_DEPARTURE / 100, SCHEDULED_DEPARTURE % 100, 0, 0, 0)
				END AS scheduled_departure,
				DATEADD(minute, -TAXI_OUT, t1.wheels_off) AS departure_time,   -- WHEELS_OFF - TAXI_OUT
				CASE
					WHEN SCHEDULED_ARRIVAL = 2400 THEN DATEADD(day, 1, DATETIMEFROMPARTS(YEAR, MONTH, DAY, 0, 0, 0, 0))
					ELSE DATETIME2FROMPARTS(YEAR, MONTH, DAY, SCHEDULED_ARRIVAL / 100, SCHEDULED_ARRIVAL % 100, 0, 0, 0)
				END AS scheduled_arrival,
				DATEADD(minute, TAXI_IN, t1.wheels_on) AS arrival_time   -- WHEELS_IN + TAXI_IN
		) AS t2

		WHERE YEAR IS NOT NULL
			AND MONTH = 6
			AND DAY IS NOT NULL
			AND AIRLINE IS NOT NULL
			AND FLIGHT_NUMBER IS NOT NULL 
			AND ORIGIN_AIRPORT IS NOT NULL
			AND DESTINATION_AIRPORT IS NOT NULL
			AND t1.wheels_off IS NOT NULL
			AND t1.wheels_on IS NOT NULL
			AND TAXI_OUT IS NOT NULL
			AND TAXI_IN IS NOT NULL
			AND t2.scheduled_departure IS NOT NULL
			AND t2.scheduled_arrival IS NOT NULL;

		SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';
		SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Silver Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
		
	END TRY
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END
