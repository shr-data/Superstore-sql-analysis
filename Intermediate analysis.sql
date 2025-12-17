SELECT 
    `Customer Name`,
    ROUND(SUM(Sales), 2) AS total_sales
FROM superstore
GROUP BY `Customer Name`
ORDER BY total_sales DESC
LIMIT 10;

SELECT State,ROUND(SUM(Sales),2) as total_sales
FROM superstore
GROUP BY State
ORDER BY total_sales DESC;
SELECT `Ship Mode`,ROUND(SUM(Sales),2) as total_sales,ROUND(SUM(Profit),2) as total_profits
FROM superstore
GROUP BY `Ship Mode`
ORDER BY total_sales DESC;

SELECT  
    DATE_FORMAT(
        STR_TO_DATE(`Order Date`, '%m/%d/%Y'),
        '%Y-%m'
    ) AS YearMonth,
    ROUND(SUM(Sales), 2) AS total_sales
FROM superstore
GROUP BY YearMonth
ORDER BY YearMonth;


