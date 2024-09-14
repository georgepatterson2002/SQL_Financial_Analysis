-- Retail Sales Financial Analysis

-- CREATE TABLE --

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
			(
				transactions_id INT PRIMARY KEY
				sale_date DATE,
				sale_time TIME,
				customer_id INT,
				gender VARCHAR(15),
				age INT,
				category VARCHAR(15),
				quantity INT,
				price_per_unit FLOAT,
				cogs FLOAT,
				total_sale FLOAT
			);

---

-- SHOW TABLE (AFTER IMPORT)--

SELECT * FROM retail_sales

---

--ROW COUNT--

SELECT
	COUNT(*)
FROM retail_sales

---

-- DATA CLEANING--

--Locate NULL Values

SELECT * FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR 
	gender IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	cogs IS NULL
	OR
	total_Sale IS NULL;

--Delete NULL Values

DELETE FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR 
	gender IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	cogs IS NULL
	OR
	total_Sale IS NULL;

---

--DATA EXPLORATION--

-- How many sales we have?
SELECT COUNT(*) total_sale FROM retail_sales

-- How many unique customers do we have?
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales

-- How many unique categories do we have?
SELECT DISTINCT category FROM retail_sales

---

--DATA ANALYSIS (Problems and Answers)--

--Find all sales made on '2022-11-05'
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

--Retrieve all transactions of Clothing with Quantity over 3 in the month November 2022
SELECT * FROM retail_sales
WHERE category = 'Clothing'
	AND
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND
	quantity >= 3

-- Calculate total sales for each category

SELECT 
	category,
	SUM(total_sale) as net_sale,
	COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1

-- Find the average age of customers who purchased from the 'Beauty' category

SELECT
	ROUND(AVG(age), 2) as average_age
FROM retail_sales
WHERE category = 'Beauty'

-- Find all transactions where the total sale is greater than 1000

SELECT * FROM retail_sales
WHERE total_sale > 1000

--Find total number of transactions made by each gender in each category

SELECT
	category,
	gender,
	COUNT(*) as total_trans
FROM retaiL_sales
GROUP
	BY
	category,
	gender
ORDER BY 1

-- Calculate average sales for each month. Find best selling month for each year

SELECT 
	year,
	month,
	average_sales
FROM
(
	SELECT 
		EXTRACT(YEAR FROM sale_date) as year,
		EXTRACT(MONTH FROM sale_date) as month,
		AVG(total_sale) as average_sales,
		RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
	FROM retail_sales
	GROUP BY 1, 2
) as t1
WHERE rank = 1

--Find top 5 customers based on the highest total sales

SELECT
	customer_id,
	SUM(total_sale) as total_sales
	FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--Find number of unique customers who purchased items from each category

SELECT
	category,
	COUNT(DISTINCT customer_id) as unique_customers
	FROM retail_sales
GROUP BY 1

-- Find total orders through each section of the day (Morning < 12:00 <= Afternoon <= 17:00 <= Evening)

SELECT * FROM retail_sales

SELECT
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END as shift,
	COUNT(*) as total_orders
FROM retail_sales
GROUP by shift

---

-- End of Project

