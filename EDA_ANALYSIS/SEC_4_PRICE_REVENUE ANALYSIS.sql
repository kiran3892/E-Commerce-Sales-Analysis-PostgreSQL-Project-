-- SECTION 4: PRICE & REVENUE ANALYSIS

-- For each product, calculate total revenue = price × total yearly sales.
	SELECT
		PRODUCT_NAME,
		(PRICE * (sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12)) AS TOTAL_REVENUE
	FROM SALES;

-- Which product generates the highest revenue?
	SELECT
		PRODUCT_NAME,
		(PRICE * (sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12)) AS TOTAL_REVENUE
	FROM SALES
	ORDER BY 2 DESC
	LIMIT 1;

-- Which category generates the highest total revenue
	SELECT
		CATEGORY,
		SUM(PRICE * (sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12)) AS TOTAL_REVENUE
	FROM SALES
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 1;

-- Identify products where price is high but total sales are low (overpriced items).
WITH PRICE_REVENUE AS(
	SELECT
		PRODUCT_NAME,
		PRICE,
		SUM((sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12)) AS TOTAL_REVENUE
	FROM SALES
	GROUP BY 1,2
	),
	QUANTILES AS (
		SELECT
			PRODUCT_NAME,
			NTILE(4) OVER (ORDER BY PRICE ASC) AS PRICE_QUARTILE,
			NTILE(4) OVER (ORDER BY TOTAL_REVENUE ASC) AS REVENUE_QUARTILE
		FROM PRICE_REVENUE
	)
		SELECT
			PRODUCT_NAME,
			PRICE_QUARTILE,
			REVENUE_QUARTILE
		FROM QUANTILES
		WHERE PRICE_QUARTILE = 4 AND REVENUE_QUARTILE = 1;

-- Find products where price is low but sales are high (high-demand items)
WITH PRICE_REVENUE AS(
	SELECT
		PRODUCT_NAME,
		PRICE,
		SUM((sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12)) AS TOTAL_REVENUE
	FROM SALES
	GROUP BY 1,2
	),
	QUANTILES AS (
		SELECT
			PRODUCT_NAME,
			NTILE(4) OVER (ORDER BY PRICE ASC) AS PRICE_QUARTILE,
			NTILE(4) OVER (ORDER BY TOTAL_REVENUE ASC) AS REVENUE_QUARTILE
		FROM PRICE_REVENUE
	)
		SELECT
			PRODUCT_NAME,
			PRICE_QUARTILE,
			REVENUE_QUARTILE
		FROM QUANTILES
		WHERE PRICE_QUARTILE = 1 AND REVENUE_QUARTILE = 4;

-- Compare product price with review_score (does higher price → higher review?)
	SELECT
		PRODUCT_NAME,
		PRICE,
		REVIEW_SCORE
	FROM SALES
	ORDER BY 2 DESC,3 DESC;