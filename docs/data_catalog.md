# Gold Layer – Data Catalog

The Gold layer contains business-ready dimension and fact tables designed for analytical and reporting purposes. The model follows a star-schema structure, with `fact_flights` as the central fact table connected to the `dim_airlines` and `dim_airports` dimension tables.

---

## `gold.dim_airlines`

### Table Description

The `dim_airlines` table contains information about airlines operating the flights in the dataset. It serves as an airline dimension for the `fact_flights` fact table. Each airline is identified by a surrogate key, which is referenced by the `airline_key` foreign key in `fact_flights`.

| Column | Data Type | Description |
|---|---|---|
| `airline_key` | INT | Surrogate key uniquely identifying an airline. Used as a foreign key in `fact_flights`. |
| `iata_code` | NVARCHAR(5) | IATA code identifying the airline. |
| `airline` | NVARCHAR(100) | Name or identifier of the airline. |

---

## `gold.dim_airports`

### Table Description

The `dim_airports` table contains information about airports included in the flight dataset. It provides descriptive and geographic information about airports and is referenced twice by `fact_flights`: once for the origin airport and once for the destination airport.

| Column | Data Type | Description |
|---|---|---|
| `airport_key` | INT | Surrogate key uniquely identifying an airport. Used as a foreign key in `fact_flights`. |
| `iata_code` | NVARCHAR(5) | IATA code identifying the airport. |
| `airport` | NVARCHAR(100) | Name of the airport. |
| `city` | NVARCHAR(50) | City in which the airport is located. |
| `state` | NVARCHAR(5) | State or administrative region in which the airport is located. |
| `country` | NVARCHAR(50) | Country in which the airport is located. |
| `latitude` | FLOAT | Geographic latitude of the airport in decimal degrees. |
| `longitude` | FLOAT | Geographic longitude of the airport in decimal degrees. |

---

## `gold.fact_flights`

### Table Description

The `fact_flights` table contains individual flight records and the operational measures associated with each flight. It combines flight identifiers, scheduled and actual flight times, delays, duration, distance, cancellation information, and delay components.

The table uses foreign keys to connect each flight to an airline in `dim_airlines` and to the corresponding origin and destination airports in `dim_airports`.

| Column | Data Type | Description |
|---|---|---|
| `airline_key` | INT | Foreign key referencing `dim_airlines.airline_key` and identifying the airline operating the flight. |
| `origin_airport_key` | INT | Foreign key referencing `dim_airports.airport_key` and identifying the airport from which the flight departs. |
| `destination_airport_key` | INT | Foreign key referencing `dim_airports.airport_key` and identifying the airport at which the flight is scheduled to arrive. |
| `flight_date` | DATE | Calendar date on which the flight is scheduled to depart. |
| `day_of_week` | VARCHAR(3) | Three-letter abbreviation of the day of the week on which the flight departs, such as `Mon`, `Tue`, or `Wed`. |
| `flight_number` | INT | Numeric flight number assigned to the flight by the airline. |
| `tail_number` | NVARCHAR(20) | Aircraft tail number identifying the specific aircraft operating the flight. |
| `scheduled_departure` | DATETIME2 | Scheduled departure date and time of the flight. |
| `departure_time` | DATETIME2 | Actual departure date and time, calculated from the wheels-off time and taxi-out duration. |
| `departure_delay` | INT | Departure delay in minutes, calculated as the difference between the actual and scheduled departure times. |
| `taxi_out` | INT | Number of minutes between the aircraft leaving the gate and taking off. |
| `wheels_off` | DATETIME2 | Actual date and time when the aircraft takes off. |
| `scheduled_time` | INT | Scheduled flight duration in minutes. |
| `elapsed_time` | INT | Total elapsed flight time in minutes, calculated as air time plus taxi-out and taxi-in time. |
| `air_time` | INT | Time in minutes that the aircraft spends in the air between takeoff and landing. |
| `distance` | INT | Flight distance between the origin and destination airports, measured in miles. |
| `wheels_on` | DATETIME2 | Actual date and time when the aircraft lands. |
| `taxi_in` | INT | Number of minutes between the aircraft landing and reaching the gate. |
| `scheduled_arrival` | DATETIME2 | Scheduled arrival date and time of the flight. |
| `arrival_time` | DATETIME2 | Actual arrival date and time, calculated from the wheels-on time and taxi-in duration. |
| `arrival_delay` | INT | Arrival delay in minutes, calculated as the difference between the actual and scheduled arrival times. |
| `diverted` | INT | Indicates whether the flight was diverted. A value of `1` indicates a diverted flight and `0` indicates that the flight was not diverted. |
| `cancelled` | INT | Indicates whether the flight was cancelled. A value of `1` indicates a cancelled flight and `0` indicates that the flight was not cancelled. |
| `cancellation_reason` | NVARCHAR(20) | Reason for flight cancellation, such as airline/carrier, weather, national air system, or security. |
| `air_system_delay` | INT | Delay in minutes caused by the national air system. |
| `security_delay` | INT | Delay in minutes caused by security-related issues. |
| `airline_delay` | INT | Delay in minutes caused by the airline or carrier. |
| `late_aircraft_delay` | INT | Delay in minutes caused by a previous flight using the same aircraft arriving late. |
| `weather_delay` | INT | Delay in minutes caused by weather conditions. |

---

## Relationships

The Gold layer follows a star-schema structure centered on `gold.fact_flights`.

- `fact_flights.airline_key` → `dim_airlines.airline_key`
- `fact_flights.origin_airport_key` → `dim_airports.airport_key`
- `fact_flights.destination_airport_key` → `dim_airports.airport_key`

The `dim_airports` table is therefore referenced twice by the fact table. The same airport dimension provides information about both the origin and destination airports.

### Derived Calculations

Several columns in `fact_flights` are derived from other flight attributes:

| Column | Calculation |
|---|---|
| `departure_time` | `wheels_off - taxi_out` |
| `departure_delay` | `departure_time - scheduled_departure` |
| `elapsed_time` | `air_time + taxi_out + taxi_in` |
| `arrival_time` | `wheels_on + taxi_in` |
| `arrival_delay` | `arrival_time - scheduled_arrival` |

These calculations transform the raw flight data into business-ready analytical measures suitable for reporting and analysis.
