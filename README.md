# 2015-flight-delays-and-cancellations-warehouse
a modern warehouse built with SQL Server with ETL, data modeling and analytics

This project contains a comprehensive data warehousing solution with elements of analytics. 

# 🏗️ Data Architecture
The projects follows the Medallion Architecture pattern with the **Bronze**, **Silver**, and **Gold** layers:
<img width="1221" height="677" alt="image" src="https://github.com/user-attachments/assets/fab5f9fc-b6cd-4c43-a68e-aa16532cfe18" />

The layers can be characterized like this:
**Bronze**: Stores raw data extracted from the source (CSV files) into the SQL Server database as-is. 
**Silver**: Includes data cleansing, standardization, and normalization.
**Gold**: Contains business-ready data modeled into a star schema required for reporting and analytics.
