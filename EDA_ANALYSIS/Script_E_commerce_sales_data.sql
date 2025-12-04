-- CREATING TABLE

CREATE TABLE sales(
					product_id int primary key,
					product_name varchar(25),
					category varchar(25),	
					price decimal(10,2),
					review_score decimal(10,2),	
					review_count int,
					sales_month_1 int,	
					sales_month_2 int,
					sales_month_3 int,	
					sales_month_4 int,	
					sales_month_5 int,	
					sales_month_6 int,	
					sales_month_7 int,	
					sales_month_8 int,	
					sales_month_9 int,	
					sales_month_10 int,	
					sales_month_11 int,	
					sales_month_12 int
);
