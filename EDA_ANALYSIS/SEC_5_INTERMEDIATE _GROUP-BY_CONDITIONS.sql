-- SECTION 5: INTERMEDIATE (GROUP BY, CONDITIONS)


-- Find category-wise average price.
	SELECT
		CATEGORY,
		ROUND(AVG(PRICE),0)
	FROM SALES
	GROUP BY 1;


-- Show products priced above the category average.
	SELECT
		PRODUCT_NAME,
		PRICE
	FROM SALES
	WHERE PRICE > (SELECT AVG(PRICE) FROM SALES);


-- Find category-wise total yearly units sold
	SELECT
		CATEGORY,
		ROUND(SUM((sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12)/PRICE),0) AS UNITS_SOLD
	FROM SALES
	GROUP BY 1;


-- Which category has the most products?
	SELECT
		CATEGORY,
		ROUND(SUM((sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + 
		sales_month_5 + sales_month_6 + sales_month_7 + sales_month_8 + 
		sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12)/PRICE),0) AS UNITS_SOLD
	FROM SALES
	GROUP BY 1
	ORDER BY 2 DESC;


-- Find the monthly average sales per product.
	SELECT PRODUCT_NAME,
		ROUND(AVG(SALES_MONTH_1),0) AS JAN,
		ROUND(AVG(SALES_MONTH_2),0) AS FEB,
		ROUND(AVG(SALES_MONTH_3),0) AS MAR,
		ROUND(AVG(SALES_MONTH_4),0) AS APR,
		ROUND(AVG(SALES_MONTH_5),0) AS MAY,
		ROUND(AVG(SALES_MONTH_6),0) AS JUN,
		ROUND(AVG(SALES_MONTH_7),0) AS JUL,
		ROUND(AVG(SALES_MONTH_8),0) AS AUG,
		ROUND(AVG(SALES_MONTH_9),0) AS SEP,
		ROUND(AVG(SALES_MONTH_10),0) AS OCT,
		ROUND(AVG(SALES_MONTH_11),0) AS NOV,
		ROUND(AVG(SALES_MONTH_12),0) AS DEC
	FROM SALES
	GROUP BY 1;


-- List products whose price is below the overall average price.
	SELECT
		PRODUCT_NAME,
		PRICE
	FROM SALES
	WHERE PRICE < (SELECT AVG(PRICE) FROM SALES);


-- List products with review_count above average review_count.
	SELECT
		PRODUCT_NAME,
		REVIEW_COUNT
	FROM SALES
	WHERE REVIEW_COUNT > (SELECT AVG(REVIEW_COUNT) FROM SALES);	
	

-- Identify categories where average review_score > 4.0.
	SELECT
		CATEGORY,
		ROUND(AVG(REVIEW_SCORE),0)
	FROM SALES
	WHERE REVIEW_SCORE > 4
	GROUP BY 1;
