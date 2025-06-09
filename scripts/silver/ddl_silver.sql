-- CTE to rank customers by most recent order_date per customer_id
WITH ranked_customers AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY order_date DESC
           ) AS rn
    FROM bronze.supermarket_data
    WHERE TRY_CAST(postalcode AS INT) IS NOT NULL  -- Only consider rows with valid postalcode as INT
) 

-- Insert latest valid customer records into silver.customers table
INSERT INTO silver.customers (
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state_,
    postalcode,
    region
)
SELECT 
    customer_id,
    TRIM(customer_name) AS customer_name,
    segment,
    country,
    city,
    state_,
    postalcode,
    region
FROM ranked_customers
WHERE customer_id IS NOT NULL
  AND customer_name IS NOT NULL
  AND segment IN ('Consumer', 'Corporate', 'Home Office')  -- Filter valid customer segments
  AND region IN ('East', 'West', 'Central', 'South')       -- Filter valid regions
  AND TRY_CAST(postalcode AS INT) IS NOT NULL              -- Ensure postalcode is numeric
  AND rn = 1;                                              -- Only take the latest record per customer


-- CTE to rank products by most recent order_date per product_id
WITH ranked_products AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY product_id
               ORDER BY order_date DESC
           ) AS pn
    FROM bronze.supermarket_data
) 

-- Insert latest product info into silver.products table
INSERT INTO silver.products (
    product_id,
    category,
    sub_category,
    product_names
)
SELECT
    product_id,
    category,
    sub_category,
    TRIM(REPLACE(REPLACE(REPLACE(product_names, '"', ''), '""', ''), ',', '')) AS product_names -- Clean product names by removing quotes and commas
FROM ranked_products
WHERE product_id IS NOT NULL
  AND product_names IS NOT NULL
  AND pn = 1;  -- Take latest record per product


-- CTE to rank orders by most recent order_date per order_id
WITH ranked_order_id AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY order_id
               ORDER BY order_date DESC
           ) AS oi
    FROM bronze.supermarket_data
) 

-- Insert latest valid order records into silver.orders table
INSERT INTO silver.orders (
    row_id,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id
)
SELECT
    row_id,
    order_id,
    CASE 
        WHEN order_date > GETDATE() THEN NULL  -- Nullify future order dates
        ELSE order_date
    END AS order_date,
    CASE
        WHEN ship_date > GETDATE() THEN NULL  -- Nullify future ship dates
        ELSE ship_date
    END AS ship_date,
    ship_mode,
    customer_id
FROM ranked_order_id
WHERE row_id IS NOT NULL
  AND order_id IS NOT NULL
  AND order_date <= ship_date                -- Ensure logical dates (order_date <= ship_date)
  AND oi = 1;                               -- Take latest record per order


-- Insert order item details with numeric validation and cleaning
INSERT INTO silver.order_items (
    row_id,
    order_id,
    product_id,
    sales,
    quantity,
    discount,
    profit
)
SELECT
    row_id,
    order_id,
    product_id,
    CASE
        WHEN TRY_CAST(sales AS FLOAT) IS NULL THEN NULL  -- Set sales to NULL if not numeric
        ELSE sales
    END AS sales,
    CASE 
        WHEN TRY_CAST(REPLACE(REPLACE(REPLACE(REPLACE(quantity, '"', ''), '""', ''), ',', ''), '.') AS FLOAT) IS NULL THEN NULL
        ELSE REPLACE(REPLACE(REPLACE(REPLACE(quantity, '"', ''), '""', ''), ',', ''), '.')  -- Clean quantity of quotes, commas, dots
    END AS quantity,
    CASE
        WHEN TRY_CAST(discount AS FLOAT) IS NULL THEN NULL  -- Validate discount as numeric
        ELSE discount
    END AS discount,
    CASE
        WHEN TRY_CAST(profit AS FLOAT) IS NULL THEN NULL    -- Validate profit as numeric
        ELSE profit
    END AS profit
FROM bronze.supermarket_data;

