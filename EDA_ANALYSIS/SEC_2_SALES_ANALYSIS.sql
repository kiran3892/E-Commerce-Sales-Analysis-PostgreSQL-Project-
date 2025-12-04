-- SECTION 2: SALES ANALYSIS QUESTIONS

-- Calculate total yearly sales for each product (sum of 12 months)
SELECT
	PRODUCT_ID,
	PRODUCT_NAME,
	CATEGORY,
	(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
	sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
	sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12) AS TOTAL_SALES
FROM SALES;


-- Which products have the highest total yearly sales
SELECT
	PRODUCT_ID,
	PRODUCT_NAME,
	CATEGORY,
	(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
	sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
	sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12) AS TOTAL_SALES
FROM SALES
ORDER BY 4 DESC
LIMIT 100;


-- Calculate total sales for each product category.
SELECT
	CATEGORY,
	SUM(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
	sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
	sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12) AS TOTAL_SALES
FROM SALES
GROUP BY 1;


-- Identify the overall monthly sales (Jan to Dec) for the entire company.
SELECT
	SUM(sales_month_1),
	SUM(sales_month_2), 
	SUM(sales_month_3), 
	SUM(sales_month_4),
	SUM(sales_month_5), 
	SUM(sales_month_6), 
	SUM(sales_month_7), 
	SUM(sales_month_8), 
	SUM(sales_month_9), 
	SUM(sales_month_10), 
	SUM(sales_month_11),
	SUM(sales_month_12)
FROM SALES;


-- Which category generated the highest annual sales
SELECT
	CATEGORY,
	SUM(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
	sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
	sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12) AS TOTAL_SALES
FROM SALES
GROUP BY 1
ORDER BY 2 DESC;

-- List the top 10 products by annual sales.
SELECT
	PRODUCT_NAME,
	SUM(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
	sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
	sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12) AS TOTAL_ANNUAL_SALES
FROM SALES
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- Find products where sales are consistently low in all 12 months.
SELECT
	PRODUCT_NAME,
	SUM(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
	sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
	sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12) AS TOTAL_ANNUAL_SALES
FROM SALES
GROUP BY 1
ORDER BY 2 ASC
LIMIT 10;
