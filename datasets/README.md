# Datasets

The raw datasets are **not included in this repository** because of their file size.

## 2015 Flight Delays and Cancellations

**Source:** [Kaggle](https://www.kaggle.com/)

**Dataset:** [2015 Flight Delays and Cancellations](https://www.kaggle.com/datasets/usdot/flight-delays)

The dataset contains information about flights, airlines, and airports in the United States in 2015.

### Download

Download the dataset from Kaggle and place the following three files in the `datasets` directory:

```text
airlines.csv
airports.csv
flights.csv
```

By default, the project expects the files to be located at:

```text
D:\Projects\DATA PROJECTS\SQLWarehouseProject\datasets\
```

Resulting in:

```text
D:\Projects\DATA PROJECTS\SQLWarehouseProject\datasets\airlines.csv
D:\Projects\DATA PROJECTS\SQLWarehouseProject\datasets\airports.csv
D:\Projects\DATA PROJECTS\SQLWarehouseProject\datasets\flights.csv
```

### Custom Dataset Location

You can store the datasets in any location on your computer. If you choose a different location, update the file paths in:

```text
bronze.proc_load_bronze.sql
```

Specifically, modify the paths used in the `BULK INSERT` statements so that they point to the location of your downloaded CSV files.

> **Note:** The dataset files are intentionally excluded from this repository due to their size. You must download them separately before running the data-loading procedures.
