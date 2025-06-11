## 📘 Naming Conventions

To ensure clarity, consistency, and collaboration across the pipeline, I followed these SQL naming conventions throughout the project:

- ✅ **Schemas**
  - `bronze` – raw ingested data
  - `silver` – cleaned and validated data
  - `gold` – final analytics-ready views (fact/dim)

- ✅ **Tables and Views**
  - Tables are lowercase and snake_case: `order_items`, `dim_customers`
  - Views are prefixed with layer name: `gold.fact_sales`, `gold.dim_orders`

- ✅ **Columns**
  - All columns use snake_case, no spaces or camelCase
  - Primary key columns: usually `id`, like `order_id`, `customer_id`
  - Date fields end with `_date`: `order_date`, `ship_date`

- ✅ **Temporary Aliases**
  - Used short and meaningful aliases (e.g., `c` for customers, `o` for orders, `oi` for order_items)

These naming standards helped keep the project consistent and easy to debug or scale.
