SELECT COUNT(*) 
FROM superstore;
SELECT DISTINCT 'segment'
FROM superstore;
SELECT MIN(sales),
	   MAX(sales),
       AVG(sales),
       STD(sales)
FROM superstore;
SELECT segment,COUNT(*) as total_orders
FROM superstore
GROUP BY segment
ORDER BY total_orders DESC;
SELECT Category,ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY Category
ORDER BY total_sales DESC;
SELECT 'Sub-Category',ROUND(SUM(Sales),2) as total_profit
FROM superstore
GROUP BY 'Sub-Category'
ORDER BY total_profit DESC;
SELECT 'Customer Name',COUNT(*) as total_orders
FROM superstore
GROUP BY 'Customer Name'
ORDER BY total_orders DESC
LIMIT 10;

SELECT State,ROUND(SUM(sales),2) as total_sales
FROM superstore
GROUP BY state
ORDER BY total_sales DESC;
SELECT Region,ROUND(SUM(sales),2) as total_sales
       ,ROUND(SUM(profit),2) as total_profit
FROM superstore
GROUP BY region 
ORDER BY total_sales DESC;
SELECT 'Product Name',ROUND(SUM(sales),2) as total_sales
FROM superstore
GROUP BY 'Product Name'
ORDER BY total_sales DESC
LIMIT 10;

