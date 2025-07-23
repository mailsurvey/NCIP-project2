CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE,
    day INT,
    month INT,
    year INT,
    weekday VARCHAR(10)
);

WITH Numbers AS (
    SELECT TOP 100 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
)
INSERT INTO dim_date
SELECT
    n,
    DATEADD(DAY, n, '2023-01-01'),
    DAY(DATEADD(DAY, n, '2023-01-01')),
    MONTH(DATEADD(DAY, n, '2023-01-01')),
    YEAR(DATEADD(DAY, n, '2023-01-01')),
    DATENAME(WEEKDAY, DATEADD(DAY, n, '2023-01-01'))
FROM Numbers;


select * from dim_date