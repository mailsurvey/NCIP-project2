CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    city VARCHAR(50),
    region VARCHAR(20),
    store_manager VARCHAR(50)
);

  
WITH Numbers AS (
    SELECT TOP 100 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
)
INSERT INTO dim_store
SELECT
    n,
    'Store ' + CAST(n AS VARCHAR),
    'City ' + CAST(n AS VARCHAR),
    CASE n % 4 WHEN 0 THEN 'North' WHEN 1 THEN 'South' WHEN 2 THEN 'East' ELSE 'West' END,
    'Manager ' + CAST(n AS VARCHAR)
FROM Numbers


select * from dim_store
