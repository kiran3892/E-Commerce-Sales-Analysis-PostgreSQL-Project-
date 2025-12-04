<img width="1536" height="1024" alt="GitHub Logo" src="https://github.com/user-attachments/assets/41ea74d6-8386-423e-9b9c-54815bd69e83" />

# E-Commerce-Sales-Analysis-PostgreSQL-Project-
This project focuses on analyzing a comprehensive E-Commerce Sales dataset. Using advanced SQL techniques, the project uncovers key business insights such as monthly revenue trends, top-performing products, category-wise performance, customer popularity through review metrics, and product profitability.

The analysis involves applying real-world SQL functions including window functions, ranking, rollups, CTEs, aggregates, UNNEST for monthly arrays, and time-series calculations. These queries replicate the tasks of a data analyst working in an e-commerce business—optimizing product inventory, identifying top sellers, and understanding customer engagement.

The project is designed to demonstrate strong practical SQL expertise and the ability to translate raw data into actionable insights, suitable for analytics portfolios and data analyst roles.

# 🗂️ **Dataset Description**

# The dataset contains the following columns:

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

# ✅ SQL QUESTIONS FOR DATASET

# 🟦 SECTION 1: BASIC QUESTIONS
- Show the first 10 rows of the products table.
- How many total products are available?
- List all unique product categories.
- Find products that have missing or NULL price.
- Which are the top 10 most expensive products?
- What is the average product price?
- What is the average review score across all products?
- Find products with 0 review_count.

# 🟩 SECTION 2: SALES ANALYSIS QUESTIONS
- Calculate total yearly sales for each product (sum of 12 months).
- Which products have the highest total yearly sales?
- Calculate total sales for each product category.
- Identify the overall monthly sales (Jan to Dec) for the entire company.
- Which category generated the highest annual sales?
- List the top 10 products by annual sales.
- Find products where sales are consistently low in all 12 months.

# 🟨 SECTION 3: REVIEW ANALYSIS
- Which products have the highest review scores?
- Find all products with review_count > 50 and sort by highest review_score.
- What is the average review score per category?
- Identify products with low review_score (below 2).
- Which category has the highest average review rating?

# 🟧 SECTION 4: PRICE & REVENUE ANALYSIS
- For each product, calculate total revenue = price × total yearly sales.
- Which product generates the highest revenue?
- Which category generates the highest total revenue?
- Identify products where price is high but total sales are low (overpriced items).
- Find products where price is low but sales are high (high-demand items).
- Compare product price with review_score (does higher price → higher review?).

# 🟥 SECTION 5: INTERMEDIATE (GROUP BY, CONDITIONS)
- Find category-wise average price.
- Show products priced above the category average.
- Find category-wise total yearly units sold.
- Which category has the most products?
- Find the monthly average sales per product.
- List products whose price is below the overall average price.
- List products with review_count above average review_count.
- Identify categories where average review_score > 4.0.

# 🟪 SECTION 6: ADVANCED (WINDOW FUNCTIONS)
- Rank all products by yearly sales (RANK / DENSE_RANK).
- Rank products within each category by yearly sales.
- Compare product sales with category average sales (window AVG).
- Compute running total of price over all products (ORDER BY price).
- Compute percentage contribution of each product to category sales.
- Identify top 5 products in each category using ROW_NUMBER().

# 🟫 SECTION 7: ADVANCED BUSINESS ANALYSIS
- Identify seasonal products (month with highest sales).
- Identify products with declining sales over time (month-by-month decrease).
- Identify products with increasing sales trend.
- Identify products with highest month-on-month growth.
- Compare Q1, Q2, Q3, Q4 sales for each product.
- Identify which month has the highest total sales overall.
- Identify categories that perform best in the holiday season (Nov–Dec).
- Identify the best-selling product for each month (Jan to Dec).

# 🟦 SECTION 8: CORRELATION & INSIGHTS
- Does a higher review_count correlate with higher sales?
- Does a higher review_score correlate with higher price?
- Which category has the strongest link between price and sales?
- Identify products with high reviews but low sales (marketing opportunity).
- Identify products with low reviews but high sales (quality issue indicator).
- What is the relationship between price and yearly revenue?

# 🟩 SECTION 9: FINAL PROJECT QUESTIONS 
- Generate a complete performance summary for each product (price, reviews, sales).
- Generate a category performance dashboard using SQL.
- Identify the top 3 products contributing to 80% of category revenue (Pareto).
- Identify slow-moving items (low yearly sales).
- Identify fast-moving items (high yearly sales).
- Provide business recommendations based on price, reviews, and sales.
  
# Clone the repo
git clone (https://github.com/kiran3892/E-Commerce-Sales-Analysis-PostgreSQL-Project-)
