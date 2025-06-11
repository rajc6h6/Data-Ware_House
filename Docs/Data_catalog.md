## 📖 Data Catalog

This section documents each major entity in the pipeline and the key fields used in analysis.

---

### 🔸 Bronze Layer
> `bronze.cust_info`  
- Raw CSV file ingested directly using `BULK INSERT`
- Contains all fields: customer, order, product, and sales data
- Minimal cleaning; serves as landing zone

---

### 🔸 Silver Layer

> `silver.customers`  
- Contains unique customers  
- Filtered for valid postal codes and segments  
- Fields: `customer_id`, `customer_name`, `segment`, `country`, `city`, `region`, etc.

> `silver.products`  
- Deduplicated by product_id  
- Trimmed and cleaned product names  
- Fields: `product_id`, `product_names`, `category`, `sub_category`

> `silver.orders`  
- One record per `order_id`, validated order and ship dates  
- Linked to `customers` table  
- Fields: `order_id`, `order_date`, `ship_date`, `customer_id`, `ship_mode`

> `silver.order_items`  
- Fact-like data: sales, quantity, discounts, profit  
- Linked to `orders` and `products`  
- All numeric fields cast and cleaned  

---

### 🔸 Gold Layer

> `gold.fact_sales`  
- Final analytical table  
- Combines data from all silver tables  
- Fields: `customer_id`, `order_id`, `product_id`, `sales`, `profit`, etc.

> `gold.dim_orders`, `gold.dim_customers`, `gold.dim_products`  
- Dimensional breakdown of the fact table  
- Built using `DISTINCT` from silver tables  
- Used for BI/analytics use cases


