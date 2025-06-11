create schema gold --- first create schema for gold

-- Create or update the 'fact_sales' view in the 'gold' layer
CREATE OR ALTER VIEW gold.fact_sales AS
SELECT 
    -- Selecting the row identifier (unique per record)
    t.row_id,

    -- Customer-related columns
    t.customer_id,
    t.customer_name,
    t.segment,
    t.country,
    t.region,

    -- Order and product IDs
    t.order_id,
    t.product_id,

    -- Product information from the products dimension table
    p.product_names,
    p.category,
    p.sub_category,

    -- Order dates
    t.order_date,
    t.ship_date,

    -- Sales transaction metrics
    t.quantity,
    t.discount,
    t.sales,
    t.profit

FROM (
    -- Subquery joins order, customer, and order_items tables from silver layer
    SELECT
        oi.row_id,
        c.customer_id,
        c.customer_name,
        c.segment,
        c.country,
        c.region,
        o.order_id,
        oi.product_id,
        o.order_date,
        o.ship_date,
        oi.quantity,
        oi.discount,
        oi.sales,
        oi.profit
    FROM silver.orders AS o
    LEFT JOIN silver.customers AS c
        ON o.customer_id = c.customer_id   -- Join orders with customers
    LEFT JOIN silver.order_items AS oi
        ON oi.order_id = o.order_id        -- Join orders with their order items
) AS t
LEFT JOIN silver.products AS p
    ON p.product_id = t.product_id         -- Join with product details

