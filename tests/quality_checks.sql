-- Check for duplicates and nulls in primary keys
-- Expectation: No results
SELECT
	IATA_CODE,
	COUNT(*)
FROM silver.airlines
GROUP BY IATA_CODE
HAVING COUNT(*) > 1 OR IATA_CODE IS NULL;

---

SELECT
	IATA_CODE,
	COUNT(*)
FROM silver.airports
GROUP BY IATA_CODE
HAVING COUNT(*) > 1 OR IATA_CODE IS NULL;

---

SELECT
	flight_date,
	airline,
	flight_number,
	origin_airport,
	destination_airport,
	COUNT(*)
FROM silver.flights
GROUP BY flight_date, airline, flight_number, origin_airport, destination_airport
HAVING COUNT(*) > 1 
	OR flight_date IS NULL
	OR airline IS NULL
	OR flight_number IS NULL 
	OR origin_airport IS NULL
	OR destination_airport IS NULL;


SELECT
	DATEFROMPARTS(YEAR, MONTH, DAY) AS flight_date,	
	AIRLINE,
	FLIGHT_NUMBER,
	ORIGIN_AIRPORT,
	DESTINATION_AIRPORT,
	COUNT(*)
FROM bronze.flights
GROUP BY DATEFROMPARTS(YEAR, MONTH, DAY), AIRLINE, FLIGHT_NUMBER, ORIGIN_AIRPORT, DESTINATION_AIRPORT
HAVING COUNT(*) > 1 
	OR YEAR IS NULL
	OR MONTH IS NULL
	OR DAY IS NULL
	OR AIRLINE IS NULL
	OR FLIGHT_NUMBER IS NULL 
	OR ORIGIN_AIRPORT IS NULL
	OR DESTINATION_AIRPORT IS NULL;

-- Check for leading and trailing spaces in strings
-- Expectation: No results
SELECT
	*
FROM silver.airlines
WHERE IATA_CODE != TRIM(IATA_CODE)
	OR AIRLINE != TRIM(AIRLINE)

---

SELECT
	*
FROM silver.airports
WHERE IATA_CODE != TRIM(IATA_CODE)
	OR AIRPORT != TRIM(AIRPORT)
	OR CITY != TRIM(CITY)
	OR STATE != TRIM(STATE)
	OR COUNTRY != TRIM(COUNTRY)

---

SELECT
	*
FROM silver.flights
WHERE AIRLINE != TRIM(AIRLINE)
	OR TAIL_NUMBER != TRIM(TAIL_NUMBER)
	OR ORIGIN_AIRPORT != TRIM(ORIGIN_AIRPORT)
	OR DESTINATION_AIRPORT != TRIM(DESTINATION_AIRPORT)
