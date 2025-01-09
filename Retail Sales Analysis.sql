-- Analysis retail sales performance in 2023

CREATE DATABASE retail_sales_data;

-- Ensure there's no duplicate data
SELECT * FROM retail_sales;
SELECT DISTINCT * FROM retail_sales;

-- Ensure there's no null data
SELECT 
	COUNT(*) AS TotalNull 
FROM retail_sales
WHERE
	TransactionID IS NULL
    	OR Date IS NULL
    	OR CustomerID IS NULL
    	OR Gender IS NULL
    	OR Age IS NULL
    	OR ProductCategory IS NULL
    	OR Quantity IS NULL
    	OR PricePerUnit IS NULL
    	OR TotalAmount IS NULL;

-- Number of transactions in a year
SELECT COUNT(TransactionID) AS NumberOfTransactions
FROM retail_sales
WHERE YEAR(STR_TO_DATE(Date, '%Y-%m-%d')) = 2023;

-- Total products sold in a year
SELECT SUM(Quantity) AS TotalProducts
FROM retail_sales
WHERE YEAR(STR_TO_DATE(Date, '%Y-%m-%d')) = 2023;

-- Total sales in a year
SELECT SUM(TotalAmount) AS TotalSales
FROM retail_sales
WHERE YEAR(STR_TO_DATE(Date, '%Y-%m-%d')) = 2023;

-- Average sales per month
SELECT (SUM(TotalAmount)/12) AS AverageSales
FROM retail_sales
WHERE YEAR(STR_TO_DATE(Date, '%Y-%m-%d')) = 2023;

-- Total sales each month
SELECT
	DATE_FORMAT(Date, '%Y-%m') AS Month,
    	SUM(TotalAmount) AS TotalSales
FROM retail_sales
WHERE YEAR(STR_TO_DATE(Date, '%Y-%m-%d')) = 2023
GROUP BY Month
ORDER BY Month;

-- Month with the highest total sales
SELECT
	DATE_FORMAT(Date, '%Y-%m') AS Month,
    	SUM(TotalAmount) AS TotalSales
FROM retail_sales
WHERE YEAR(STR_TO_DATE(Date, '%Y-%m-%d')) = 2023
GROUP BY Month
ORDER BY TotalSales DESC
LIMIT 1;

-- Month with the lowest total sales
SELECT
	DATE_FORMAT(Date, '%Y-%m') AS Month,
   	 SUM(TotalAmount) AS TotalSales
FROM retail_sales
WHERE YEAR(STR_TO_DATE(Date, '%Y-%m-%d')) = 2023
GROUP BY Month
ORDER BY TotalSales ASC
LIMIT 1;

-- Total sales by quarter
SELECT CONCAT('Q', 
	CASE
		WHEN MONTH(STR_TO_DATE(Date, '%Y-%m-%d')) BETWEEN 1 AND 3 THEN 1
		WHEN MONTH(STR_TO_DATE(Date, '%Y-%m-%d')) BETWEEN 4 AND 6 THEN 2
		WHEN MONTH(STR_TO_DATE(Date, '%Y-%m-%d')) BETWEEN 7 AND 9 THEN 3
		WHEN MONTH(STR_TO_DATE(Date, '%Y-%m-%d')) BETWEEN 10 AND 12 THEN 4
	END) AS Quarter,
    	SUM(TotalAmount) AS TotalSales
FROM retail_sales
WHERE YEAR(STR_TO_DATE(Date, '%Y-%m-%d')) = 2023
GROUP BY Quarter
ORDER BY Quarter;

-- Total sales each month per product category
SELECT
	ProductCategory,
   	SUM(CASE WHEN DATE_FORMAT(Date, '%Y-%m') = '2023-01' THEN TotalAmount ELSE 0 END) AS Jan2023,
    	SUM(CASE WHEN DATE_FORMAT(Date, '%Y-%m') = '2023-02' THEN TotalAmount ELSE 0 END) AS Feb2023,
    	SUM(CASE WHEN DATE_FORMAT(Date, '%Y-%m') = '2023-03' THEN TotalAmount ELSE 0 END) AS Mar2023,
	SUM(CASE WHEN DATE_FORMAT(Date, '%Y-%m') = '2023-04' THEN TotalAmount ELSE 0 END) AS Apr2023,
    	SUM(CASE WHEN DATE_FORMAT(Date, '%Y-%m') = '2023-05' THEN TotalAmount ELSE 0 END) AS May2023,
    	SUM(CASE WHEN DATE_FORMAT(Date, '%Y-%m') = '2023-06' THEN TotalAmount ELSE 0 END) AS Jun2023,
    	SUM(CASE WHEN DATE_FORMAT(Date, '%Y-%m') = '2023-07' THEN TotalAmount ELSE 0 END) AS Jul2023,
    	SUM(CASE WHEN DATE_FORMAT(Date, '%Y-%m') = '2023-08' THEN TotalAmount ELSE 0 END) AS Aug2023,
    	SUM(CASE WHEN DATE_FORMAT(Date, '%Y-%m') = '2023-09' THEN TotalAmount ELSE 0 END) AS Sep2023,
	SUM(CASE WHEN DATE_FORMAT(Date, '%Y-%m') = '2023-10' THEN TotalAmount ELSE 0 END) AS Oct2023,
    	SUM(CASE WHEN DATE_FORMAT(Date, '%Y-%m') = '2023-11' THEN TotalAmount ELSE 0 END) AS Nov2023,
    	SUM(CASE WHEN DATE_FORMAT(Date, '%Y-%m') = '2023-12' THEN TotalAmount ELSE 0 END) AS Dec2023,
    	SUM(TotalAmount) AS TotalSales
FROM retail_sales
WHERE YEAR(STR_TO_DATE(Date, '%Y-%m-%d')) = 2023
GROUP BY ProductCategory;

-- Total transactions by gender
SELECT
	Gender,
    	COUNT(TransactionID) AS TotalTransaction
FROM retail_sales
GROUP BY Gender;

-- Total transactions by age group
SELECT
	CASE
		WHEN Age BETWEEN 18 AND 30 THEN '18-30'
        	WHEN Age BETWEEN 31 AND 45 THEN '31-45'
        	WHEN Age > 45 THEN '45+'
		ELSE 0
    	END AS AgeGroup,
	COUNT(TransactionID) AS TotalTransactions
FROM retail_sales
WHERE YEAR(STR_TO_DATE(Date, '%Y-%m-%d')) = 2023
GROUP BY AgeGroup
ORDER BY AgeGroup;

-- Average sales by gender
SELECT
	Gender,
    	AVG(TotalAmount) AS TotalSales
FROM retail_sales
GROUP BY Gender;

-- Average sales by age group
SELECT
	CASE
		WHEN Age BETWEEN 18 AND 30 THEN '18-30'
        	WHEN Age BETWEEN 31 AND 45 THEN '31-45'
        	WHEN Age > 45 THEN '45+'
		ELSE 0
    	END AS AgeGroup,
	AVG(TotalAmount) AS TotalSales
FROM retail_sales
WHERE YEAR(STR_TO_DATE(Date, '%Y-%m-%d')) = 2023
GROUP BY AgeGroup
ORDER BY AgeGroup;
