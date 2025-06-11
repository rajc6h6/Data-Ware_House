# 🛒 Superstore Data Pipeline Project

This is a personal data engineering project I built using the Superstore dataset. The goal was to clean, transform, and model raw CSV data into structured tables and views, using the industry-standard **Bronze → Silver → Gold** layered architecture.

I handled everything from setting up the schema to writing transformation logic, creating fact and dimension views, and uploading it to GitHub — completely on my own.

---

## 🔧 Tech Stack

- **SQL Server** for data handling
- **T-SQL** for queries and transformations
- **Git + GitHub** for version control and project sharing
- **SSMS (SQL Server Management Studio)** as the IDE

---

## 🗂️ Project Layers

### 🔹 Bronze Layer (Raw Data)
- Table: `bronze.cust_info`
- Loaded directly from the original CSV using `BULK INSERT`
- No cleaning or transformation at this level — just raw data storage

### 🔸 Silver Layer (Cleaned & Structured)
This is where the actual transformation happens. I removed incorrect data, converted types (especially floats and strings), removed invalid rows, and ensured referential integrity.

#### Silver Tables:
- `silver.customers`
- `silver.products`
- `silver.orders`
- `silver.order_items`

Highlights:
- Used `ROW_NUMBER()` to deduplicate based on latest `order_date`
- Removed future dates and ensured valid `order_date <= ship_date`
- Used `TRY_CAST()` to handle bad type values
- Built foreign key relationships properly

### 🟡 Gold Layer (Analytics-ready Views)
Instead of creating tables, I followed the standard practice of using **views** in the Gold layer.

#### Views Created:
- `gold.fact_sales`: The main transactional fact table combining customer, order, product, and sales data
- `gold.dim_orders`: Dimension view for order info
- `gold.dim_customers`: Dimension view for customer info
- `gold.dim_products`: Dimension view for product info

The structure is based on a **star schema**: a central fact table (`fact_sales`) connected to surrounding dimension views.

---

## 📁 Folder Structure

📦 Superstore-Data-Pipeline
├── bronze/ -- Raw table (cust_info) + insert logic
├── silver/ -- Cleaned, structured tables (customers, orders, etc.)
├── gold/ -- Views using fact/dim modeling
├── schema/ -- Table creation scripts
├── views/ -- View definitions for gold layer
└── README.md -- This file


---

## 🧠 Learnings & Notes

- I got hands-on experience with the data warehouse lifecycle — from ingestion to modeling
- Learned how to handle dirty data (especially type inconsistencies)
- Followed best practices like splitting transformations by layers, using CTEs, and writing clean SQL
- I was inspired by industry-standard projects (like Baraa's 30-hr SQL Data Engineer course) but created this project entirely from scratch using a different dataset

**Important Note**: In `fact_sales`, customers may appear more than once — this is expected behavior because it’s a transactional fact table (each row = one product in one order).

---

## ✅ Status

- [x] Data Loaded (Bronze)
- [x] Cleaned & Structured (Silver)
- [x] Fact and Dimension Views Built (Gold)
- [x] Uploaded on GitHub

---

## 📌 Final Thoughts

This project helped me understand real-world SQL pipelines much better. Every transformation, validation, and join was done by me — not copied from anywhere. I also made sure the logic made sense from both a business and technical point of view.

