CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    brand VARCHAR(50),
    price DECIMAL(10,2)
);

WITH Numbers AS (
    SELECT TOP 100 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
)
INSERT INTO dim_product
SELECT
    n,
    'Product ' + CAST(n AS VARCHAR),
    CASE WHEN n % 2 = 0 THEN 'Electronics' ELSE 'Apparel' END,
    CASE WHEN n % 3 = 0 THEN 'BrandX' ELSE 'BrandY' END,
    ROUND(RAND(CHECKSUM(NEWID())) * 100 + 10, 2)
FROM Numbers;


select * from dim_product



