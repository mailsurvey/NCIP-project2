CREATE TABLE fact_sales (
    sales_id INT PRIMARY KEY,
    date_id INT FOREIGN KEY REFERENCES dim_date(date_id),
    customer_id INT FOREIGN KEY REFERENCES dim_customer(customer_id),
    product_id INT FOREIGN KEY REFERENCES dim_product(product_id),
    store_id INT FOREIGN KEY REFERENCES dim_store(store_id),
    quantity_sold INT,
    discount DECIMAL(4,2),
    total_amount DECIMAL(10,2)
);

WITH Numbers AS (
    SELECT TOP 100 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
)
INSERT INTO fact_sales
SELECT
    n,
    ABS(CHECKSUM(NEWID())) % 30 + 1,   -- date_id
    ABS(CHECKSUM(NEWID())) % 10 + 1,   -- customer_id
    ABS(CHECKSUM(NEWID())) % 10 + 1,   -- product_id
    ABS(CHECKSUM(NEWID())) % 5 + 1,    -- store_id
    ABS(CHECKSUM(NEWID())) % 5 + 1,    -- quantity
    ROUND(RAND(CHECKSUM(NEWID())) * 0.3, 2), -- discount
    0.0
FROM Numbers;

-- Update total_amount using product price
UPDATE fs
SET total_amount = ROUND(dp.price * fs.quantity_sold * (1 - fs.discount), 2)
FROM fact_sales fs
JOIN dim_product dp ON fs.product_id = dp.product_id;

select * from fact_sales