

--Create dim_category

CREATE TABLE dim_category (
  category_id INT IDENTITY(1,1) PRIMARY KEY,
  category_name VARCHAR(100)
);

-- 2. Populate dim_category with DISTINCT categories

INSERT INTO dim_category (category_name)
SELECT DISTINCT category FROM dim_product;

--Create dim_brand

CREATE TABLE dim_brand (
  brand_id INT IDENTITY(1,1) PRIMARY KEY,
  brand_name VARCHAR(100)
);

INSERT INTO dim_brand (brand_name)
SELECT DISTINCT brand FROM dim_product;

-- 3. Creating a Snoflaked version of dim_product

CREATE TABLE dim_product_snowflake (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    brand_id INT,
    price DECIMAL(10,2),
    FOREIGN KEY (category_id) REFERENCES dim_category(category_id),
    FOREIGN KEY (brand_id) REFERENCES dim_brand(brand_id)
);



--4 . Populate dim_product_snowflake from dim_product using JOIN

INSERT INTO dim_product_snowflake (product_id, product_name, category_id, brand_id, price)
SELECT 
  p.product_id,
  p.product_name,
  c.category_id,
  b.brand_id,
  p.price
FROM dim_product p
JOIN dim_category c ON p.category = c.category_name
JOIN dim_brand b ON p.brand = b.brand_name;


select * from dim_product

select * from dim_product_snowflake

select * from dim_category



