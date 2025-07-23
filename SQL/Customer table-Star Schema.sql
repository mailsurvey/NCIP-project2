


CREATE TABLE dim_customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    loyalty_status VARCHAR(20)
);

WITH Numbers AS (
    SELECT TOP 100 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
)
INSERT INTO dim_customer
SELECT 
    n,
    'First' + CAST(n AS VARCHAR),
    'Last' + CAST(n AS VARCHAR),
    'user' + CAST(n AS VARCHAR) + '@example.com',
    '555-000' + RIGHT('000' + CAST(n AS VARCHAR), 3),
    CASE n % 3 WHEN 0 THEN 'Gold' WHEN 1 THEN 'Silver' ELSE 'Platinum' END
FROM Numbers;


select * from dim_customer