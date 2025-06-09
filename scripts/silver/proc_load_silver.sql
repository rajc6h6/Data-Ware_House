-- Create 'silver' schema and drop existing tables if they exist
CREATE SCHEMA silver;

IF OBJECT_ID('silver.order_items', 'U') IS NOT NULL
    DROP TABLE silver.order_items;
GO

IF OBJECT_ID('silver.orders', 'U') IS NOT NULL
    DROP TABLE silver.orders;
GO

IF OBJECT_ID('silver.products', 'U') IS NOT NULL
    DROP TABLE silver.products;
GO

IF OBJECT_ID('silver.customers', 'U') IS NOT NULL
    DROP TABLE silver.customers;
GO

-- Create customers table
CREATE TABLE silver.customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state_ VARCHAR(50),
    postalcode INT,
    region VARCHAR(50)
);
GO

-- Create products table
CREATE TABLE silver.products (
    product_id VARCHAR(50) PRIMARY KEY,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_names VARCHAR(350)
);
GO

-- Create orders table
CREATE TABLE silver.orders (
    row_id INT PRIMARY KEY,
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES silver.customers(customer_id)
);
GO

-- Create order_items table
CREATE TABLE silver.order_items (
    row_id INT PRIMARY KEY,
    order_id VARCHAR(50),
    product_id VARCHAR(50),
    sales FLOAT,
    quantity INT,
    discount FLOAT,
    profit FLOAT,
    FOREIGN KEY (order_id) REFERENCES silver.orders(order_id),
    FOREIGN KEY (product_id) REFERENCES silver.products(product_id)
);
GO

-- Optional: Enforce uniqueness on order_id + product_id combination in order_items
ALTER TABLE silver.order_items
ADD CONSTRAINT UQ_order_product UNIQUE (order_id, product_id);
GO

