--Below queries shows the locations of where most of the orders come from based on the Region
SELECT COUNT(region) AS num_orders_placed_by_region, region, state, city, postcode
FROM [salesdata].[dbo].[sales_customer$]
GROUP BY region, state, city, postcode
ORDER BY num_orders_placed_by_region DESC


--Below queries shows the number of orders each customer has placed
SELECT name, COUNT(order_id) AS num_orders_placed
FROM [salesdata].[dbo].[sales_customer$]
GROUP BY name
ORDER BY num_orders_placed DESC


--Below shows the Total Amount and Average of Sales per Sub Category between 2015 to 2018 
SELECT sub_category, ROUND(SUM(sales), 2) AS sales_per_sub_category, ROUND(AVG(sales), 2) AS avg_sales_per_sub_category
FROM [salesdata].[dbo].[sales_product$]
GROUP BY sub_category
ORDER BY sales_per_sub_category DESC


--Below returns the amount of discount that has been given per Sub Category 
SELECT sub_category, ROUND(AVG(discount), 2) AS total_avg_discount
FROM [salesdata].[dbo].[sales_product$]
GROUP BY sub_category


--Below shows amount of discounts and average discounts each customer has been getting with further information about the customer such as the region
--And the type of customer 
SELECT sc.name, sc.region, sp.category, CASE 
		WHEN sc.segment = 'Consumer' THEN 1 
		WHEN sc.segment = 'Corporate' THEN 2
		ELSE 3 END AS segment_code, 
COUNT(sp.discount) AS total_discount, ROUND(AVG(discount), 2) AS total_avg_discount
FROM [salesdata].[dbo].[sales_customer$] AS sc
LEFT JOIN [salesdata].[dbo].[sales_product$] AS sp
ON sc.order_id = sp.order_id
GROUP BY sc.name, sc.region, sp.category, sc.segment
ORDER BY total_discount DESC


--Below shows the Total Amount and Average of Profit per Sub Category between 2015 to 2018 
SELECT sub_category, ROUND(SUM(profit), 2) AS profit_per_sub_category, ROUND(AVG(profit), 2) AS avg_profit_per_sub_category
FROM [salesdata].[dbo].[sales_product$]
GROUP BY sub_category
ORDER BY profit_per_sub_category DESC 


--Below queries return an output of the Max, Min and Avg sales per Sub Category for each year (2015 - 2018)
SELECT sub_category, ROUND(MAX(sales), 2) AS max_sale, ROUND(MIN(sales), 2) AS min_sale, ROUND(AVG(sales), 2) AS avg_sale,
so.year_only
FROM [salesdata].[dbo].[sales_product$] AS sp
INNER JOIN [salesdata].[dbo].[sales_order$] AS so
ON sp.id = so.product_id AND
sp.order_id = so.id
WHERE so.year_only = 2015
GROUP BY sub_category, so.year_only

UNION

SELECT sub_category, ROUND(MAX(sales), 2) AS max_sale, ROUND(MIN(sales), 2) AS min_sale, ROUND(AVG(sales), 2) AS avg_sale,
so.year_only
FROM [salesdata].[dbo].[sales_product$] AS sp
INNER JOIN [salesdata].[dbo].[sales_order$] AS so
ON sp.id = so.product_id AND
sp.order_id = so.id
WHERE so.year_only = 2016
GROUP BY sub_category, so.year_only

UNION

SELECT sub_category, ROUND(MAX(sales), 2) AS max_sale, ROUND(MIN(sales), 2) AS min_sale, ROUND(AVG(sales), 2) AS avg_sale,
so.year_only
FROM [salesdata].[dbo].[sales_product$] AS sp
INNER JOIN [salesdata].[dbo].[sales_order$] AS so
ON sp.id = so.product_id AND
sp.order_id = so.id
WHERE so.year_only = 2017
GROUP BY sub_category, so.year_only

UNION

SELECT sub_category, ROUND(MAX(sales), 2), ROUND(MIN(sales), 2), ROUND(AVG(sales), 2), so.year_only
FROM [salesdata].[dbo].[sales_product$] AS sp
INNER JOIN [salesdata].[dbo].[sales_order$] AS so
ON sp.id = so.product_id AND
sp.order_id = so.id
WHERE so.year_only = 2018
GROUP BY sub_category, so.year_only
ORDER BY sub_category, so.year_only


--Below queries return an output of the list of Sub Categories where the AVG Sale is less than the Total AVG Sale year for each year(2015 - 2018)
SELECT sub_category, ROUND(MAX(sales), 2) AS max_sale, ROUND(MIN(sales), 2) AS min_sale, ROUND(AVG(sales), 2) AS avg_sale,
so.year_only, (SELECT ROUND(AVG(sales), 2) FROM [salesdata].[dbo].[sales_product$]) AS total_avg_sale
FROM [salesdata].[dbo].[sales_product$] AS sp
INNER JOIN [salesdata].[dbo].[sales_order$] AS so
ON sp.id = so.product_id AND
sp.order_id = so.id
WHERE so.year_only = 2015 AND
sales < (SELECT AVG(sales) FROM [salesdata].[dbo].[sales_product$])
GROUP BY sub_category, so.year_only

UNION

SELECT sub_category, ROUND(MAX(sales), 2), ROUND(MIN(sales), 2), ROUND(AVG(sales), 2),
so.year_only, (SELECT ROUND(AVG(sales), 2)FROM [salesdata].[dbo].[sales_product$]) AS total_avg_sale
FROM [salesdata].[dbo].[sales_product$] AS sp
INNER JOIN [salesdata].[dbo].[sales_order$] AS so
ON sp.id = so.product_id AND
sp.order_id = so.id
WHERE so.year_only = 2016 AND
sales < (SELECT AVG(sales) FROM [salesdata].[dbo].[sales_product$])
GROUP BY sub_category, so.year_only

UNION

SELECT sub_category, ROUND(MAX(sales), 2), ROUND(MIN(sales), 2), ROUND(AVG(sales), 2),
so.year_only, (SELECT ROUND(AVG(sales), 2) FROM [salesdata].[dbo].[sales_product$]) AS total_avg_sale
FROM [salesdata].[dbo].[sales_product$] AS sp
INNER JOIN [salesdata].[dbo].[sales_order$] AS so
ON sp.id = so.product_id AND
sp.order_id = so.id
WHERE so.year_only = 2017 AND
sales < (SELECT AVG(sales) FROM [salesdata].[dbo].[sales_product$])
GROUP BY sub_category, so.year_only

UNION

SELECT sub_category, ROUND(MAX(sales), 2), ROUND(MIN(sales), 2), ROUND(AVG(sales), 2), so.year_only,
(SELECT ROUND(AVG(sales), 2)FROM [salesdata].[dbo].[sales_product$]) AS total_avg_sale
FROM [salesdata].[dbo].[sales_product$] AS sp
INNER JOIN [salesdata].[dbo].[sales_order$] AS so
ON sp.id = so.product_id AND
sp.order_id = so.id
WHERE so.year_only = 2018 AND
sales < (SELECT AVG(sales) FROM [salesdata].[dbo].[sales_product$])
GROUP BY sub_category, so.year_only
ORDER BY sub_category, so.year_only


--Below queries return an output of the Max, Min and Avg Profit per Sub Category for each year (2015 - 2018)
SELECT sub_category, ROUND(MAX(profit), 2) AS max_profit, ROUND(MIN(profit), 2) AS min_profit, ROUND(AVG(profit), 2) AS avg_profit,
so.year_only
FROM [salesdata].[dbo].[sales_product$] AS sp
INNER JOIN [salesdata].[dbo].[sales_order$] AS so
ON sp.id = so.product_id AND
sp.order_id = so.id
WHERE so.year_only = 2015
GROUP BY sub_category, so.year_only

UNION

SELECT sub_category, ROUND(MAX(profit), 2), ROUND(MIN(profit), 2), ROUND(AVG(profit), 2), so.year_only
FROM [salesdata].[dbo].[sales_product$] AS sp
INNER JOIN [salesdata].[dbo].[sales_order$] AS so
ON sp.id = so.product_id AND
sp.order_id = so.id
WHERE so.year_only = 2016
GROUP BY sub_category, so.year_only

UNION

SELECT sub_category, ROUND(MAX(profit), 2), ROUND(MIN(profit), 2), ROUND(AVG(profit), 2), so.year_only
FROM [salesdata].[dbo].[sales_product$] AS sp
INNER JOIN [salesdata].[dbo].[sales_order$] AS so
ON sp.id = so.product_id AND
sp.order_id = so.id
WHERE so.year_only = 2017
GROUP BY sub_category, so.year_only

UNION

SELECT sub_category, ROUND(MAX(profit), 2), ROUND(MIN(profit), 2), ROUND(AVG(profit), 2), so.year_only
FROM [salesdata].[dbo].[sales_product$] AS sp
INNER JOIN [salesdata].[dbo].[sales_order$] AS so
ON sp.id = so.product_id AND
sp.order_id = so.id
WHERE so.year_only = 2018
GROUP BY sub_category, so.year_only
ORDER BY sub_category, so.year_only


--Below queries return an output of the list of Sub Categories where the AVG Profit is less than the Total AVG Profit
--For all Sub Categories for each year(2015 - 2018)
SELECT sub_category, ROUND(MAX(profit), 2) AS max_profit, ROUND(MIN(profit), 2) AS min_profit, ROUND(AVG(profit), 2) AS avg_profit,
so.year_only, (SELECT ROUND(AVG(profit), 2) FROM [salesdata].[dbo].[sales_product$]) AS total_avg_profit, sc.region
FROM [salesdata].[dbo].[sales_product$] AS sp
INNER JOIN [salesdata].[dbo].[sales_order$] AS so
ON sp.id = so.product_id AND
sp.order_id = so.id
INNER JOIN [salesdata].[dbo].[sales_customer$] AS sc
ON sp.order_id = sc.order_id
WHERE so.year_only = 2015 AND
sales < (SELECT AVG(sales) FROM [salesdata].[dbo].[sales_product$])
GROUP BY sub_category, so.year_only, sc.region

UNION

SELECT sub_category, ROUND(MAX(profit), 2), ROUND(MIN(profit), 2), ROUND(AVG(profit), 2),
so.year_only, (SELECT ROUND(AVG(profit), 2) FROM [salesdata].[dbo].[sales_product$]) AS total_avg_profit, sc.region
FROM [salesdata].[dbo].[sales_product$] AS sp
INNER JOIN [salesdata].[dbo].[sales_order$] AS so
ON sp.id = so.product_id AND
sp.order_id = so.id
INNER JOIN [salesdata].[dbo].[sales_customer$] AS sc
ON sp.order_id = sc.order_id
WHERE so.year_only = 2016 AND
sales < (SELECT AVG(sales) FROM [salesdata].[dbo].[sales_product$])
GROUP BY sub_category, so.year_only, sc.region

UNION

SELECT sub_category, ROUND(MAX(profit), 2), ROUND(MIN(profit), 2), ROUND(AVG(profit), 2),
so.year_only, (SELECT ROUND(AVG(profit), 2) FROM [salesdata].[dbo].[sales_product$]) AS total_avg_profit, sc.region
FROM [salesdata].[dbo].[sales_product$] AS sp
INNER JOIN [salesdata].[dbo].[sales_order$] AS so
ON sp.id = so.product_id AND
sp.order_id = so.id
INNER JOIN [salesdata].[dbo].[sales_customer$] AS sc
ON sp.order_id = sc.order_id
WHERE so.year_only = 2017 AND
sales < (SELECT AVG(sales) FROM [salesdata].[dbo].[sales_product$])
GROUP BY sub_category, so.year_only, sc.region

UNION

SELECT sub_category, ROUND(MAX(profit), 2), ROUND(MIN(profit), 2), ROUND(AVG(profit), 2),
so.year_only, (SELECT ROUND(AVG(profit), 2) FROM [salesdata].[dbo].[sales_product$]) AS total_avg_profit, sc.region
FROM [salesdata].[dbo].[sales_product$] AS sp
INNER JOIN [salesdata].[dbo].[sales_order$] AS so
ON sp.id = so.product_id AND
sp.order_id = so.id
INNER JOIN [salesdata].[dbo].[sales_customer$] AS sc
ON sp.order_id = sc.order_id
WHERE so.year_only = 2018 AND
sales < (SELECT AVG(sales) FROM [salesdata].[dbo].[sales_product$])
GROUP BY sub_category, so.year_only, sc.region
ORDER BY sub_category, so.year_only