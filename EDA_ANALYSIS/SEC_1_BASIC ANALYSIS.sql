-- SECTION 1: BASIC ANALYSIS

-- Show the first 10 rows of the sales table.
SELECT * 
FROM SALES 
LIMIT 10;

-- How many total products are available?
SELECT COUNT(*) 
FROM SALES;

-- List all unique product categories.
SELECT 
	DISTINCT CATEGORY 
FROM SALES;

-- Find products that have missing or NULL price.
SELECT * 
FROM SALES 
WHERE PRICE IS NULL;

-- Which are the top 10 most expensive products
SELECT * 
FROM SALES
ORDER BY PRICE DESC
LIMIT 10;

-- What is the average product price
SELECT ROUND(AVG(PRICE),2)
FROM SALES;

-- What is the average review score across all products
SELECT ROUND(AVG(REVIEW_SCORE),2)
FROM SALES;

-- Find products with 0 review_count
SELECT *
FROM SALES
WHERE REVIEW_COUNT = 0;

