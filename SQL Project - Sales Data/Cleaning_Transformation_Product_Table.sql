-- Viewing all records within the Customer table
SELECT *
FROM sales_product$


-- Viewing unique values within the Category column. 
SELECT DISTINCT category
FROM sales_product$


-- Viewing unique values within the Sub Category column. Can see a NULL value has been return
SELECT DISTINCT sub_category
FROM sales_product$


--Viewing all records where the Sub Category column has NULL values. This has returned two results which could help in filling the missing information
SELECT *
FROM sales_product$
WHERE sub_category IS NULL


--This returned the top 5 rows that meet the condition
--The product id 'OFF-EN-10000927' has a Sub Category of Envelopes
--The product id 'OFF-BI-10003094' has a Sub Category of Binders
SELECT TOP 5 id, category, sub_category, product_name
FROM sales_product$
WHERE id = 'OFF-EN-10000927' OR id = 'OFF-BI-10003094' 


--Below queries updates the Sub Category column within the Product table to replace the NULLs with the correct Sub Category based on the Product ID 
UPDATE sales_product$
SET sub_category = 'Envelopes'
WHERE id = 'OFF-EN-10000927' 

UPDATE sales_product$
SET sub_category = 'Binders'
WHERE id = 'OFF-BI-10003094' 


--Below query now shows that the NULL value has been replaced with the values above 
SELECT DISTINCT sub_category
FROM sales_product$
ORDER BY sub_category


-- Viewing unique values within the Product Name column. 
SELECT DISTINCT product_name
FROM sales_product$


--Viewing all records where the Product Name column has NULL values. This has returned two results 
--Able to use the first row to fill in the missing data
--The second row, doesn't have product ID and there are many products within the Binders Sub Category. 
SELECT *
FROM sales_product$
WHERE product_name IS NULL

--The below query returned seven records that meet the requirements below (including the NULL).
--All of those six records have the same Product Name 
SELECT id, category, sub_category, product_name
FROM sales_product$
WHERE id = 'OFF-AR-10003056' AND
category = 'Office Supplies' AND
sub_category = 'Art'


--Below queries updates the Product Name column within the Product table to replace the NULL with the correct Product Name based on the below conditions
UPDATE sales_product$
SET product_name = 'Newell 341'
WHERE id = 'OFF-AR-10003056' AND
category = 'Office Supplies' AND
sub_category = 'Art'


--The Product ID in the Product Table is also in the Order table. Below query JOINs the two tables together based on the condition 
--The returned data provides the Product ID which is seen in the Order table, which is 'OFF-BI-10003460'
SELECT sp.id AS sp_id, sp. category AS sp_cat, sp.sub_category AS sp_sc, sp.product_name AS sp_pname, sp.order_id AS so_oid,
so.id AS so_id, so.product_id AS so_pid
FROM [salesdata].[dbo].[sales_product$] AS sp
LEFT JOIN [salesdata].[dbo].[sales_order$] AS so
ON sp.order_id = so.id  
WHERE so.id = 'US-2018-136707'


--Below query returns a list of records that meets the criteria below and all have the same product name 'Acco 3-Hole Punch'
SELECT id, category, sub_category, product_name
FROM [salesdata].[dbo].[sales_product$]
WHERE id = 'OFF-BI-10003460'


--Below queries update the NULL values in the ID and Product Name columns within the Product table and can see no records appear when both columns have
--NULL values
UPDATE [salesdata].[dbo].[sales_product$]
SET id = 'OFF-BI-10003460'
WHERE id IS NULL

UPDATE [salesdata].[dbo].[sales_product$]
SET product_name = 'Acco 3-Hole Punch'
WHERE id = 'OFF-BI-10003460' AND
product_name IS NULL


SELECT id, category, sub_category, product_name
FROM [salesdata].[dbo].[sales_product$]
WHERE id IS NULL AND product_name IS NULL

--Shows all the values within the Sales column and shows that some values are not within two-decimal places 
SELECT CONVERT(nvarchar(50), sales) AS sales_str, LEN(sales) AS sales_length
FROM sales_product$


--Updated the Sales column within the Product table to round all values to two-decimal places 
--Can see all records within the Sales column are now within two-decimal places 
UPDATE sales_product$
SET sales = ROUND(sales, 2)

SELECT sales
FROM sales_product$


--Shows all the values within the Profit column and shows that some values are not within two-decimal places  
SELECT profit
FROM sales_product$

--Updated the Profit column within the Product table to round all values to two-decimal places 
--Can see all records within the Profit column are now within two-decimal places 
UPDATE sales_product$
SET profit = ROUND(profit, 2)

SELECT profit
FROM sales_product$


--Below shows two columns, the original discount column and a new column called "discount_in_percentage" which shows discount value per record as a 
--percentage with a % at the end 
SELECT discount, FORMAT(discount, 'P') AS discount_in_percentage
FROM [salesdata].[dbo].[sales_product$]


--Adding the new column called "discount_in_percentage" with the values seen in the above query to the Product table
ALTER TABLE [salesdata].[dbo].[sales_product$]
ADD discount_in_percentage nvarchar(255)

UPDATE [salesdata].[dbo].[sales_product$]
SET discount_in_percentage = FORMAT(discount, 'P')

SELECT *
FROM [salesdata].[dbo].[sales_product$]