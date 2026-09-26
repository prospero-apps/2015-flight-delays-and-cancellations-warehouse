# 2015-flight-delays-and-cancellations-warehouse
*a modern warehouse built with SQL Server with ETL, data modeling and analytics*

This project contains a comprehensive data warehousing solution with elements of analytics. 

# 🏗️ Data Architecture
The projects follows the Medallion Architecture pattern with the **Bronze**, **Silver**, and **Gold** layers:
<img width="1221" height="677" alt="image" src="https://github.com/user-attachments/assets/fab5f9fc-b6cd-4c43-a68e-aa16532cfe18" />

The layers can be characterized like this:
-  **Bronze**: Stores raw data extracted from the source (CSV files) into the SQL Server database as-is. 
-  **Silver**: Includes data cleansing, standardization, and normalization.
-  **Gold**: Contains business-ready data modeled into a star schema required for reporting and analytics.

# 📖 Project Overview
The major elements of the project are:

-  Data Architecture: data warehouse (Medallion Architecture)
-  ETL Pipelines: extracting, transforming, and loading data
-  Data Modeling: fact and dimension tables optimized for analytical queries
-  Analytics & Reporting: SQL-based reports and dashboards for actionable insights
  
# 🚀 Project Requirements

## Building the Data Warehouse (Data Engineering)

**Objective**
Develop a modern data warehouse using SQL Server for the 2015 flight delays and cancellations dataset from Kaggle.

-  **Specifications**
-  **Data Sources**: Import data from the source folder containing CSV files.
-  **Data Quality**: Cleanse the data and improve data quality prior to analysis.
-  **Integration**: Combine data from source files into a single, user-friendly data model designed for analytical queries.
-  **Scope**: Focus on the 2015 dataset only, no historization required.
-  **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.

## BI: Analytics & Reporting (Data Analysis)

**Objective**
Develop SQL-based analytics.

# 📂 Repository Structure
```
2015-flight-delays-and-cancellations-warehouse/
│
├── datasets/                           # Raw datasets used for the project (in CSV format)
│
├── docs/                               # Project documentation 
│   ├── data_architecture.drawio        # Draw.io scheme of the project's architecture
│   ├── data_catalog.md                 # Catalog of datasets with field descriptions and metadata
│   ├── data_flow.drawio                # Draw.io data flow diagram
│   ├── data_models.drawio              # Draw.io file for data models (star schema)
│   ├── naming-conventions.md           # Consistent naming guidelines for tables, columns, and files
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleansing and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│
├── tests/                              # Test scripts 
│
├── README.md                           # Project overview and instructions
├── LICENSE                             # License information for the repository
├── .gitignore                          # Files and directories to be ignored by Git
└── requirements.txt                    # Dependencies and requirements for the project
```

# 🛡️ License
This project is licensed under the MIT License. You are free to use, modify, and share this project with proper attribution.
