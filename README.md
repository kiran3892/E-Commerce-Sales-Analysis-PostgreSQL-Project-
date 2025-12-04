# E-Commerce-Sales-Analysis-PostgreSQL-Project-
This project focuses on analyzing a comprehensive E-Commerce Sales dataset. Using advanced SQL techniques, the project uncovers key business insights such as monthly revenue trends, top-performing products, category-wise performance, customer popularity through review metrics, and product profitability.

The analysis involves applying real-world SQL functions including window functions, ranking, rollups, CTEs, aggregates, UNNEST for monthly arrays, and time-series calculations. These queries replicate the tasks of a data analyst working in an e-commerce business—optimizing product inventory, identifying top sellers, and understanding customer engagement.

The project is designed to demonstrate strong practical SQL expertise and the ability to translate raw data into actionable insights, suitable for analytics portfolios and data analyst roles.

# 🗂️ **Dataset Description**

The dataset contains the following columns:

- `product_id` — Unique product identifier  
- `product_name` — Name of the product  
- `category` — Category of the product  
- `price` — Product price  
- `review_score` — Rating (1–5 scale)  
- `review_count` — Number of reviews  
- `sales_month_1` to `sales_month_12` — Monthly unit sales  
# 🛠️ **Technologies Used**

- **SQL (PostgreSQL)**  
- **UNNEST + WITH ORDINALITY** for month unpivoting  
- **Window Functions** (LAG, LEAD, RANK, NTILE)  
- **Aggregations** (SUM, AVG, COUNT)  
- **CTEs** for clean analysis  
- **Correlation (CORR)** for statistical relationships 
