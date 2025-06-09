-- Drop the existing bronze.cust_info table if it exists
DROP TABLE IF EXISTS bronze.cust_info;
GO

-- Create bronze.cust_info table to hold raw, unprocessed data
CREATE TABLE bronze.cust_info (
    row_id INT,
    Order_id VARCHAR(50),
    Order_date DATE,
    ship_date DATE,
    Ship_mode VARCHAR(50),
    Customer_id VARCHAR(50),

    Customer_name VARCHAR(50),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state_ VARCHAR(50),
    postalcode INT,
    region VARCHAR(50),

    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_names VARCHAR(350),

    sales VARCHAR(MAX),      -- kept varchar for raw text data, can be converted later
    quantity VARCHAR(50),   -- same here
    discount VARCHAR(50),
    profit VARCHAR(50)
);
GO

