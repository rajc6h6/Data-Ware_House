-- Gold Layer: Dimension Table - Products

CREATE OR ALTER VIEW gold.dim_products AS
SELECT DISTINCT
    product_id,
    product_names,
    category,
    sub_category
FROM silver.products;


