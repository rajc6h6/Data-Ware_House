-- Gold Layer: Dimension Table - Customers

CREATE OR ALTER VIEW gold.dim_customers AS
SELECT DISTINCT
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state_,
    postalcode,
    region
FROM silver.customers;
