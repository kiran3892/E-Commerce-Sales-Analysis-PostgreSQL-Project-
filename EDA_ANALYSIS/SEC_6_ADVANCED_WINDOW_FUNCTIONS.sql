-- SECTION 6: ADVANCED (WINDOW FUNCTIONS)

-- Rank all products by yearly sales (RANK / DENSE_RANK).
WITH PRODUCTS_SALES AS (
	SELECT
		PRODUCT_NAME,
		(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12) as YEARLY_SALE
	FROM SALES
	)
	SELECT
		PRODUCT_NAME,
		YEARLY_SALE,
		dense_RANK() OVER (ORDER BY YEARLY_SALE DESC) AS RANKING
	FROM PRODUCTS_SALES;

-- Rank products within each category by yearly sales.
WITH PRODUCTS_SALES AS (
	SELECT
		PRODUCT_NAME,
		CATEGORY,
		(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12) as YEARLY_SALE
	FROM SALES
	)
	SELECT
		PRODUCT_NAME,
		CATEGORY,
		YEARLY_SALE,
		DENSE_RANK() OVER (PARTITION BY CATEGORY ORDER BY YEARLY_SALE DESC) AS RANKING
	FROM PRODUCTS_SALES;


-- Compare product sales with category average sales (window AVG)
	SELECT
	    PRODUCT_ID,
		PRODUCT_NAME,
		CATEGORY,
		(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12) AS PRODUCT_ANNUAL_SALE,
		ROUND(AVG(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12) OVER (PARTITION BY CATEGORY),0) AS AVG_CATEGORY_SALE
	FROM SALES;


-- Compute running total of price over all products (ORDER BY price).
	SELECT
		PRODUCT_NAME,
		PRICE,
		SUM(PRICE) OVER (ORDER BY PRICE) AS RUNNING_TOTTAL_PRICE
	FROM SALES;


-- Compute percentage contribution of each product to category sales.
	SELECT
		PRODUCT_ID,
		PRODUCT_NAME,
		(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12) AS PRODUCT_ANNUAL_SALE,
		CATEGORY,
		SUM(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12) OVER (PARTITION BY CATEGORY) AS CATEGORY_ANNUAL_SALE,
		(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12) /
		(SUM(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12) OVER (PARTITION BY CATEGORY))::DECIMAL(10,2) * 100 AS PERCENT_CONTRIBUTION
	FROM SALES
	GROUP BY 1,2,3;
		

-- Identify top 5 products in each category using ROW_NUMBER()

WITH PRODUCT_SALES AS(
	SELECT
		CATEGORY,
		PRODUCT_NAME,
		(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12) AS PRODUCT_ANNUAL_SALE
	FROM SALES
	)
	SELECT
		CATEGORY,
		PRODUCT_NAME,
		PRODUCT_ANNUAL_SALE,
		ROW_NUMBER() OVER (PARTITION BY CATEGORY ORDER BY PRODUCT_ANNUAL_SALE DESC) AS ROW_NUMBERING
	FROM PRODUCT_SALES;
		
