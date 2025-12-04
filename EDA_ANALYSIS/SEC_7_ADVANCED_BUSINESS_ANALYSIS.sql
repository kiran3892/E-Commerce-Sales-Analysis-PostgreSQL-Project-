-- SECTION 7: ADVANCED BUSINESS ANALYSIS

-- Identify seasonal products (month with highest sales)
	-- Without Column Name containing the max value
		-- Approach 1 using Greatest() function
		SELECT
			PRODUCT_NAME,
			CATEGORY,
			GREATEST(sales_month_1 , sales_month_2 , sales_month_3 , sales_month_4 , 
			sales_month_5 , sales_month_6 , sales_month_7 , sales_month_8 , 
			sales_month_9 , sales_month_10 , sales_month_11 , sales_month_12) AS HIGHEST_SALE
		FROM SALES;

		-- Approach 2 using UNNEST(ARRAY[]) function
		SELECT
			PRODUCT_NAME,
			CATEGORY,
			(SELECT MAX(SALE)
			FROM UNNEST(ARRAY[sales_month_1, sales_month_2, sales_month_3, sales_month_4, 
			sales_month_5, sales_month_6, sales_month_7, sales_month_8, 
			sales_month_9, sales_month_10, sales_month_11, sales_month_12]) AS SALE) AS HIGHEST_SALE
		FROM SALES;

	-- With Column Name containing the max value
		-- Approach 1 using Greatest() , CASE functions
		SELECT
			PRODUCT_NAME,
			CATEGORY,
			GREATEST(sales_month_1, sales_month_2, sales_month_3, 
								sales_month_4, sales_month_5, sales_month_6, 
								sales_month_7, sales_month_8,	sales_month_9, 
								sales_month_10, sales_month_11, sales_month_12) AS HIGHEST_VALUE,
			CASE 
				GREATEST(sales_month_1, sales_month_2, sales_month_3, 
						sales_month_4, sales_month_5, sales_month_6, 
						sales_month_7, sales_month_8,	sales_month_9, 
						sales_month_10, sales_month_11, sales_month_12)
							WHEN sales_month_1 THEN 'JAN'
							WHEN sales_month_2 THEN 'FEB'
							WHEN sales_month_3 THEN 'MAR'
							WHEN sales_month_4 THEN 'APR'
							WHEN sales_month_5 THEN 'MAY'
							WHEN sales_month_6 THEN 'JUN'
							WHEN sales_month_7 THEN 'JUL'
							WHEN sales_month_8 THEN 'AUG'
							WHEN sales_month_9 THEN 'SEP'
							WHEN sales_month_10 THEN 'OCT'
							WHEN sales_month_11 THEN 'NOV'
							WHEN sales_month_12 THEN 'DEC'
						END AS MONTH_NAME
		FROM SALES;

-- Identify products with declining sales over time (month-by-month decrease).
	WITH PRODUCT_MONTHLY_SALES_ARRAY AS (
		SELECT
		PRODUCT_NAME,
		UNNEST(ARRAY[sales_month_1 , sales_month_2 , sales_month_3 , sales_month_4 , 
			sales_month_5 , sales_month_6 , sales_month_7 , sales_month_8 , 
			sales_month_9 , sales_month_10 , sales_month_11 , sales_month_12]) AS MONTHLY_SALES
		FROM SALES
		),
		PRODUCT_LAG_SALES AS (
		SELECT
			PRODUCT_NAME,
			MONTHLY_SALES,
			LAG(MONTHLY_SALES) OVER (PARTITION BY PRODUCT_NAME) AS LAG_COLUMN
		FROM PRODUCT_MONTHLY_SALES_ARRAY
		),
		TRENDS AS (
		SELECT
			PRODUCT_NAME,
			MONTHLY_SALES,
			LAG_COLUMN,
			CASE 
				WHEN LAG_COLUMN IS NOT NULL AND MONTHLY_SALES < LAG_COLUMN THEN 0
				ELSE 1
			END AS TREND
		FROM PRODUCT_LAG_SALES
		)
		SELECT PRODUCT_NAME
		FROM TRENDS
		GROUP BY PRODUCT_NAME
		HAVING COUNT(*) = SUM(TREND);
		

-- Identify products with increasing sales trend.
WITH PRODUCT_MONTHLY_SALES_ARRAY AS (
		SELECT
		PRODUCT_NAME,
		UNNEST(ARRAY[sales_month_1 , sales_month_2 , sales_month_3 , sales_month_4 , 
			sales_month_5 , sales_month_6 , sales_month_7 , sales_month_8 , 
			sales_month_9 , sales_month_10 , sales_month_11 , sales_month_12]) AS MONTHLY_SALES
		FROM SALES
		),
		PRODUCT_LAG_SALES AS (
		SELECT
			PRODUCT_NAME,
			MONTHLY_SALES,
			LAG(MONTHLY_SALES) OVER (PARTITION BY PRODUCT_NAME) AS LAG_COLUMN
		FROM PRODUCT_MONTHLY_SALES_ARRAY
		),
		TRENDS AS (
		SELECT
			PRODUCT_NAME,
			MONTHLY_SALES,
			LAG_COLUMN,
			CASE 
				WHEN LAG_COLUMN IS NOT NULL AND MONTHLY_SALES < LAG_COLUMN THEN 0
				ELSE 1
			END AS TREND
		FROM PRODUCT_LAG_SALES
		)
		SELECT PRODUCT_NAME
		FROM TRENDS
		GROUP BY PRODUCT_NAME
		HAVING COUNT(*) = SUM(TREND);


-- Compare Q1, Q2, Q3, Q4 sales for each product.
	WITH MONTHLY_SALES AS (
		SELECT
			PRODUCT_NAME,
			UNNEST(ARRAY[sales_month_1 , sales_month_2 , sales_month_3 , sales_month_4 , 
			sales_month_5 , sales_month_6 , sales_month_7 , sales_month_8 , 
			sales_month_9 , sales_month_10 , sales_month_11 , sales_month_12]) AS MONTHLY_SALES
		FROM SALES
		ORDER BY 1
		),
		SALES_QUARTILE AS (
			SELECT
				PRODUCT_NAME,
				MONTHLY_SALES,
				NTILE(4) OVER (PARTITION BY PRODUCT_NAME ORDER BY MONTHLY_SALES) AS SALES_QUARTILE
			FROM MONTHLY_SALES
		)
		SELECT * 
		FROM SALES_QUARTILE
		ORDER BY 1;
			
		
-- Identify which month has the highest total sales overall.
	SELECT
		GREATEST(SUM(sales_month_1), SUM(sales_month_2), SUM(sales_month_3), 
			SUM(sales_month_4), SUM(sales_month_5), SUM(sales_month_6), 
			SUM(sales_month_7), SUM(sales_month_8),	SUM(sales_month_9), 
			SUM(sales_month_10), SUM(sales_month_11), SUM(sales_month_12)) AS HIGHEST_VALUE,
		CASE 
			GREATEST(SUM(sales_month_1), SUM(sales_month_2), SUM(sales_month_3), 
							SUM(sales_month_4), SUM(sales_month_5), SUM(sales_month_6), 
							SUM(sales_month_7), SUM(sales_month_8),	SUM(sales_month_9), 
							SUM(sales_month_10), SUM(sales_month_11), SUM(sales_month_12)) 
							WHEN SUM(sales_month_1) THEN 'JAN'
							WHEN SUM(sales_month_2) THEN 'FEB'
							WHEN SUM(sales_month_3) THEN 'MAR'
							WHEN SUM(sales_month_4) THEN 'APR'
							WHEN SUM(sales_month_5) THEN 'MAY'
							WHEN SUM(sales_month_6) THEN 'JUN'
							WHEN SUM(sales_month_7) THEN 'JUL'
							WHEN SUM(sales_month_8) THEN 'AUG'
							WHEN SUM(sales_month_9) THEN 'SEP'
							WHEN SUM(sales_month_10) THEN 'OCT'
							WHEN SUM(sales_month_11) THEN 'NOV'
							WHEN SUM(sales_month_12) THEN 'DEC'
						END AS MONTH_NAME
		FROM SALES;

-- Identify categories that perform best in the holiday season (Nov–Dec)
		SELECT
			CATEGORY,
			SUM(sales_month_11),
			SUM(sales_month_12)
		FROM SALES
		GROUP BY 1
		ORDER BY 2 DESC, 3 DESC;
			

-- Identify the best-selling product for each month (Jan to Dec).
	WITH PRODUCT_MONTH_SALES AS (
		SELECT
			PRODUCT_ID,
			PRODUCT_NAME,
			CATEGORY,
			MONTH_SALE,
			MONTH_NUMBER
		FROM SALES
		CROSS JOIN LATERAL UNNEST(ARRAY[sales_month_1, sales_month_2, sales_month_3, sales_month_4, 
			sales_month_5, sales_month_6, sales_month_7, sales_month_8, 
			sales_month_9, sales_month_10, sales_month_11, sales_month_12]) WITH ORDINALITY AS M(MONTH_SALE, MONTH_NUMBER)
		),
		RANKING_MONTH_SALES AS (
			SELECT *,
				RANK() OVER (PARTITION BY PRODUCT_NAME ORDER BY MONTH_SALE DESC) AS SALES_RANK
			FROM PRODUCT_MONTH_SALES
		)
		SELECT 
			PRODUCT_ID,
			PRODUCT_NAME,
			CATEGORY,
			MONTH_NUMBER
		FROM RANKING_MONTH_SALES
		WHERE SALES_RANK = 1
		ORDER BY MONTH_NUMBER;
	














	