-- Gold Layer: Dimension Table - Orders

CREATE OR ALTER VIEW gold.dim_orders AS
SELECT DISTINCT
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id
FROM silver.orders;
