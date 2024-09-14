# Retail Sales Financial Analysis SQL Project

## Project Overview

This project demonstrates key SQL skills used by data analysts and financial analysts to explore, clean, and analyze retail sales data. Through database setup, data cleaning, and exploratory data analysis (EDA), the project answers business-driven questions related to sales performance, customer behavior, and product categories.

## Objectives

1. **Database Setup**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values to ensure data integrity.
3. **Exploratory Data Analysis (EDA)**: Analyze key sales metrics and customer demographics.
4. **Business Analysis**: Use SQL to derive actionable insights for decision-making in retail sales.

## Project Structure

### 1. Database Setup

- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.


```sql

SELECT
	COUNT(*)
FROM retail_sales

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

SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

SELECT DISTINCT category FROM retail_sales;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Find all sales made on '2022-11-05'**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Retrieve all transactions of Clothing with Quantity over 3 in the month November 2022**:
```sql
SELECT * FROM retail_sales
WHERE category = 'Clothing'
	AND
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND
	quantity >= 3
```

3. **Calculate total sales for each category**:
```sql
SELECT 
	category,
	SUM(total_sale) as net_sale,
	COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1
```

4. **Find the average age of customers who purchased from the 'Beauty' category**:
```sql
SELECT
	ROUND(AVG(age), 2) as average_age
FROM retail_sales
WHERE category = 'Beauty'
```

5. **Find all transactions where the total sale is greater than 1000**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000
```

6. **Find total number of transactions made by each gender in each category**:
```sql
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
```

7. **Calculate average sales for each month. Find best selling month for each year**:
```sql
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
```

8. **Find top 5 customers based on the highest total sales**:
```sql
SELECT
	customer_id,
	SUM(total_sale) as total_sales
	FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
```

9. **Find number of unique customers who purchased items from each category**:
```sql
SELECT
	category,
	COUNT(DISTINCT customer_id) as unique_customers
	FROM retail_sales
GROUP BY 1
```

10. **Find total orders through each section of the day (Morning < 12:00 <= Afternoon <= 17:00 < Evening)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project provides a practical application of SQL for financial analysis in retail, emphasizing skills in data cleaning, sales analysis, and customer insights. It showcases how SQL can be leveraged for making data-driven business decisions in a retail environment.

## How to Use

1. **Set Up the Database**: Run the SQL ‘CREATE TABLE’ script provided in the `sql_queries.sql` file to create the database. Import the data found in ‘SQL - Retail Sales Analysis_utf.csv’ using a RDBMS of your choice.
2. **Run the Queries**: Use the SQL queries found below in `sql_queries.sql` to clean the data and perform the analysis.
