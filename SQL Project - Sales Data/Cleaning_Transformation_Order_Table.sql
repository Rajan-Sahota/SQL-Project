--Viewing all records and columns in the Order table 
SELECT *
FROM [salesdata].[dbo].[sales_order$]


--Viewing all unique values and the length of each value within the Ship Class column
--Returned seven values and can see three of the Ship Class have been spelt incorrectly 
SELECT DISTINCT ship_class, LEN(ship_class) AS Length
FROM  [salesdata].[dbo].[sales_order$]
ORDER BY ship_class


--Below query shows what the result would be when replacing the first incorrect Ship Class
SELECT REPLACE('FirstClass', 'Class', SPACE(1) + 'Class')
FROM [salesdata].[dbo].[sales_order$]


--Updated the incorrect Ship Class values. Now there are only four unique records that are showing correctly 
UPDATE [salesdata].[dbo].[sales_order$]
SET ship_class = REPLACE('FirstClass', 'Class', SPACE(1) + 'Class')
WHERE ship_class = 'FirstClass'

SELECT DISTINCT ship_class, LEN(ship_class) AS Length
FROM  [salesdata].[dbo].[sales_order$]
ORDER BY ship_class


--
SELECT SUBSTRING(ship_class, 1, len(ship_class) -1) AS New
FROM [salesdata].[dbo].[sales_order$]
WHERE ship_class = 'Second Classs'

UPDATE [salesdata].[dbo].[sales_order$]
SET ship_class = SUBSTRING(ship_class, 1, len(ship_class) -1)
WHERE ship_class = 'Second Classs'

SELECT DISTINCT ship_class, LEN(ship_class) AS Length
FROM  [salesdata].[dbo].[sales_order$]
ORDER BY ship_class


--
SELECT CONCAT(SUBSTRING('Standard Clas s', 1, LEN('Standard Clas s') -2), 's')
FROM [salesdata].[dbo].[sales_order$]
WHERE ship_class = 'Standard Clas s'

UPDATE [salesdata].[dbo].[sales_order$]
SET ship_class = CONCAT(SUBSTRING('Standard Clas s', 1, LEN('Standard Clas s') -2), 's')
WHERE ship_class = 'Standard Clas s'

SELECT DISTINCT ship_class, LEN(ship_class) AS Length
FROM  [salesdata].[dbo].[sales_order$]
ORDER BY ship_class


--Below query shows the Order Date and Ship Date columns includes a timestamp of '00:00:00:000'
--Used CAST to convert the two columns into DATE data type only to see the output
SELECT CAST(order_date AS DATE) AS order_date_only, order_date, CAST(ship_date AS DATE) AS ship_date_only, ship_date
FROM [salesdata].[dbo].[sales_order$]

SELECT CONVERT(DATE, order_date) AS order_date_only, order_date, CONVERT(DATE, ship_date) AS ship_date_only, ship_date
FROM [salesdata].[dbo].[sales_order$]

--Ran the below queries but the columns haven't updated, so will create two new columns that will only show the date for Order and Ship date 
UPDATE [salesdata].[dbo].[sales_order$]
SET order_date = CAST(order_date AS DATE) 

UPDATE [salesdata].[dbo].[sales_order$]
SET ship_date = CAST(ship_date AS DATE) 

ALTER TABLE [salesdata].[dbo].[sales_order$]
ADD order_date_only DATE

UPDATE [salesdata].[dbo].[sales_order$]
SET order_date_only = CONVERT(DATE, order_date)

ALTER TABLE [salesdata].[dbo].[sales_order$]
ADD ship_date_only DATE

UPDATE [salesdata].[dbo].[sales_order$]
SET ship_date_only = CONVERT(DATE, ship_date)

SELECT *
FROM [salesdata].[dbo].[sales_order$]


--Below query will drop the original columns called Order Date and Ship Date 
ALTER TABLE [salesdata].[dbo].[sales_order$]
DROP COLUMN order_date

ALTER TABLE [salesdata].[dbo].[sales_order$]
DROP COLUMN ship_date

SELECT *
FROM [salesdata].[dbo].[sales_order$]


--Extracting the YYYY from the Order Date column and putting it into it's own column
SELECT YEAR(order_date_only) AS year_only, order_date_only
FROM [salesdata].[dbo].[sales_order$]


ALTER TABLE [salesdata].[dbo].[sales_order$]
ADD year_only INT


UPDATE [salesdata].[dbo].[sales_order$]
SET year_only = YEAR(order_date_only)


SELECT* FROM [salesdata].[dbo].[sales_order$]





