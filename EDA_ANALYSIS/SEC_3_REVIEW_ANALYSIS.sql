-- SECTION 3: REVIEW ANALYSIS

-- Which products have the highest review scores
	SELECT
		PRODUCT_NAME,
		REVIEW_SCORE
	FROM SALES
	ORDER BY 2 DESC
	LIMIT 100;


-- Find all products with review_count > 50 and sort by highest review_score
	select 
		product_name,
		review_count
	from sales
	where review_count > 50
	order by 2 desc;

	
-- What is the average review score per category
	select
		category,
		round(avg(review_score),1)
	from sales
	group by 1;


-- Identify products with low review_score (below 2).
	select
		product_name,
		review_score
	from sales
	where review_score < 2;


-- Which category has the highest average review rating?
	with Avg_reviwe_score as (
			select
				category,
				round(avg(review_score),1) as Avg_reviwe_score
			from sales
			group by 1
			)
		select 
			max(Avg_reviwe_score)
		from Avg_reviwe_score;