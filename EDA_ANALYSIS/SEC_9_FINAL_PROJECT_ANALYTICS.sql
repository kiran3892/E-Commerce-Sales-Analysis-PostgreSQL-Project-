-- SECTION 9: FINAL PROJECT QUESTIONS (INTERVIEW LEVEL)

-- Generate a complete performance summary for each product (price, reviews, sales).
	SELECT
		PRODUCT_ID,
		PRODUCT_NAME,
		CATEGORY,
		PRICE,
		REVIEW_SCORE,
		sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12 AS TOTAL_ANNUAL_SALES
	FROM SALES
	GROUP BY 1,2
	ORDER BY 1 ASC;

-- Generate a category performance dashboard using SQL.
	SELECT
		CATEGORY,
		ROUND(AVG(PRICE),2) AS AVG_PRICE,
		ROUND(AVG(REVIEW_SCORE),2) AS AVG_REVIEW_SCORE,
		ROUND(AVG(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12),2) AS AVG_ANNUAL_SALES
	FROM SALES
	GROUP BY 1
	ORDER BY 4 DESC;

-- Identify the top 3 products contributing to 80% of category revenue (Pareto).
	WITH PRODUCT_ANNUAL_SALES AS (
		SELECT
			CATEGORY,
			PRODUCT_NAME,
			sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
			sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
			sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12 AS PRODUCT_ANNUAL_SALES
		FROM SALES
		GROUP BY 1,2,3
		),
		CUMULATIVE_PAS AS (
			SELECT
				CATEGORY,
				PRODUCT_NAME,
				PRODUCT_ANNUAL_SALES,
				SUM(PRODUCT_ANNUAL_SALES) OVER (PARTITION BY CATEGORY ORDER BY PRODUCT_ANNUAL_SALES DESC)*100/
				SUM(PRODUCT_ANNUAL_SALES) OVER (PARTITION BY CATEGORY) AS PERCENT_CONTRIBUTION
			FROM PRODUCT_ANNUAL_SALES
			GROUP BY 1,2,3
		),		
		PARETO AS (
		SELECT
			CATEGORY,
			PRODUCT_NAME,
			PRODUCT_ANNUAL_SALES,
			PERCENT_CONTRIBUTION,
			CASE 
				WHEN PERCENT_CONTRIBUTION <= 80 THEN '80% CONTRIBUTOR'
				ELSE '20% CONTRIBUTOR'
			END AS PARETO
		FROM CUMULATIVE_PAS
		)
		SELECT * FROM PARETO
		WHERE PARETO = '80% CONTRIBUTOR';


-- Identify slow-moving items (low yearly sales).
	SELECT
		PRODUCT_NAME,
		sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12 AS PRODUCT_ANNUAL_SALES
	FROM SALES
	ORDER BY 2
	LIMIT 10;
		

-- Identify fast-moving items (high yearly sales).
	SELECT
		PRODUCT_NAME,
		sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12 AS PRODUCT_ANNUAL_SALES
	FROM SALES
	ORDER BY 2 DESC
	LIMIT 10;

-- Provide business recommendations based on price, reviews, and sales.
	SELECT
		PRODUCT_NAME,
		PRICE,
		sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12 AS PRODUCT_ANNUAL_SALES
	FROM SALES;