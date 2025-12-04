-- SECTION 8: CORRELATION & INSIGHTS

-- Does a higher review_count correlate with higher sales?
	WITH REVIEW_SALES AS(
		SELECT
			CATEGORY,
			REVIEW_COUNT,
			sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
			sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
			sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12 AS TOTAL_ANNUAL_SALES
		FROM SALES
		ORDER BY 2 DESC, 3 DESC
		)
		SELECT 
			CATEGORY,
			CORR(REVIEW_COUNT,TOTAL_ANNUAL_SALES) AS CORRELATION_VALUE
		FROM REVIEW_SALES
		GROUP BY CATEGORY;

		-- THE CORRELATION (PEARSON CORRELATION) VALUE IS -0.06
		-- INDICATED BOTH review_count AND higher sales ARE NEGATIVELY CORRELATED
		-- INDICATING WHEN HIGHER THE SALES, LOWER THE REVIEW_COUNT
			

-- Does a higher review_score correlate with higher price?
	WITH REVIEW_SCORE_PRICE AS(
		SELECT
			REVIEW_SCORE,
			PRICE 
		FROM SALES
		ORDER BY 1 DESC, 2 DESC
		)
		SELECT 
			CORR(REVIEW_SCORE,PRICE) AS CORRELATION_VALUE
		FROM REVIEW_SCORE_PRICE;

		-- THE CORRELATION (PEARSON CORRELATION) VALUE IS 0.02
		-- INDICATED BOTH review_count AND higher sales ARE VERY SLIGHLY CORRELATED
		-- INDICATING WHEN REVIEW_SCORE CHANGES, THERE IS VERY LESS CHANCES OF APRREARING CHANGES IN PRICE 


-- Which category has the strongest link between price and sales
	WITH PRICE_SALES AS(
		SELECT
			CATEGORY,
			PRICE,
			sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
			sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
			sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12 AS TOTAL_ANNUAL_SALES
		FROM SALES
		ORDER BY 2 DESC, 3 DESC
		)
		SELECT 
			CATEGORY,
			CORR(PRICE,TOTAL_ANNUAL_SALES) AS CORRELATION_VALUE
		FROM PRICE_SALES
		GROUP BY CATEGORY
		ORDER BY 1 ASC;

		-- THE CORRELATION (PEARSON CORRELATION) VALUE FOR ALL CATERGORY EXCEPT BOOKS (0.03) IS SHOWING NEGATIVE VALUES
		-- INDICATED BOTH PRICE AND sales ARE VERY SLIGHLY CORRELATED
		-- INDICATING WHEN PRICE CHANGES, THERE IS VERY LESS CHANCES OF APRREARING CHANGES IN SALES 

-- Identify products with high reviews but low sales (marketing opportunity).
	WITH ANNUAL_SALES AS (
		SELECT
			PRODUCT_NAME,
			REVIEW_SCORE,
			sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
			sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
			sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12 AS TOTAL_ANNUAL_SALES
		FROM SALES
		),
		QUARTILES AS (
			SELECT 
				PRODUCT_NAME,
				REVIEW_SCORE,
				NTILE(4) OVER (ORDER BY REVIEW_SCORE DESC) AS REVIEW_QUARTILE,
				TOTAL_ANNUAL_SALES,
				NTILE(4) OVER (ORDER BY TOTAL_ANNUAL_SALES DESC) AS SALES_QUARTILE
			FROM ANNUAL_SALES
		)
		SELECT
			PRODUCT_NAME,
			REVIEW_QUARTILE,
			SALES_QUARTILE
		FROM QUARTILES
		WHERE REVIEW_QUARTILE = 4 AND SALES_QUARTILE = 1;
		

-- Identify products with low reviews but high sales (quality issue indicator).
	WITH ANNUAL_SALES AS (
		SELECT
			PRODUCT_NAME,
			REVIEW_SCORE,
			sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
			sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
			sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12 AS TOTAL_ANNUAL_SALES
		FROM SALES
		),
		QUARTILES AS (
			SELECT 
				PRODUCT_NAME,
				REVIEW_SCORE,
				NTILE(4) OVER (ORDER BY REVIEW_SCORE DESC) AS REVIEW_QUARTILE,
				TOTAL_ANNUAL_SALES,
				NTILE(4) OVER (ORDER BY TOTAL_ANNUAL_SALES DESC) AS SALES_QUARTILE
			FROM ANNUAL_SALES
		)
		SELECT
			PRODUCT_NAME,
			REVIEW_QUARTILE,
			SALES_QUARTILE
		FROM QUARTILES
		WHERE REVIEW_QUARTILE = 1 AND SALES_QUARTILE = 4;

-- What is the relationship between price and yearly revenue?
	WITH PRICE_REVENUE AS(
		SELECT
			PRICE,
			sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
			sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
			sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12 AS YEARLY_REVENUE
		FROM SALES
		ORDER BY 1 DESC, 2 DESC
		)
		SELECT 
			CORR(PRICE,YEARLY_REVENUE) AS CORRELATION_VALUE
		FROM PRICE_REVENUE;

		-- THE CORRELATION (PEARSON CORRELATION) VALUE IS -0.0159 SHOWING NEGATIVE VALUES
		-- INDICATED BOTH PRICE AND REVENUE ARE VERY SLIGHLY NEGATIVELY CORRELATED
		-- INDICATING WHEN PRICE INCREASES, THERE IS VERY LESS CHANCES OF DECREASING REVENUE 
	