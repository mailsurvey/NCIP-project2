

--Create dim_loyalty

CREATE TABLE dim_loyalty (
  loyaltyTier_id INT IDENTITY(1,1) PRIMARY KEY,
  loyalty_status VARCHAR(100)
);

-- 2. Populate dim_loyalty with DISTINCT loyalty status

INSERT INTO dim_loyalty (loyalty_status)
SELECT DISTINCT loyalty_status FROM dim_customer;


-- 3. Creating a Snoflaked version of dim_customer

CREATE TABLE dim_customer_snowflake (
customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    loyaltyTier_id INT,    
    FOREIGN KEY (loyaltyTier_id) REFERENCES dim_loyalty(loyaltyTier_id)
  
);



--4 . Populate dim_customer_snowflake from dim_customer using JOIN

INSERT INTO dim_customer_snowflake (customer_id, first_name,last_name, email, phone,loyaltyTier_id)
SELECT 
  c.customer_id,
  c.first_name,
  c.last_name,
  c.email,
  c.phone,
  l.loyaltyTier_id
  
FROM dim_customer c
JOIN dim_loyalty l ON c.loyalty_status = l.loyalty_status



select * from dim_customer

select * from dim_customer_snowflake

select * from dim_loyalty



