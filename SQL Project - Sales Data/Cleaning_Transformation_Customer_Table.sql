-- Viewing all records within the Customer table
SELECT *
FROM sales_customer$


-- Viewing unique values within the Region column. Can see a NULL value has been return
SELECT DISTINCT region
FROM sales_customer$


--Viewing all records where the Region column has NULL values. This has returned three results which could help in filling the missing information
SELECT *
FROM sales_customer$
WHERE region IS NULL


--The below query returns four records. Two of them containing the region values 'West' and 'East' and the other two returning NULL based on the postcode
--West is equal to the postcode of 90035 and East is equal to the postcode of 10035
--Now we know what values to enter in the NULL fields
SELECT DISTINCT city, state, postcode, region
FROM sales_customer$
WHERE postcode = 90032 OR postcode = 10035


--Below queries updates the Region column within the Customer table to replace the NULLs with the correct Region based on the postcode 
UPDATE sales_customer$
SET region = 'West'
WHERE postcode = 90032 

UPDATE sales_customer$
SET region = 'East'
WHERE postcode = 10035


--Below query now shows only four records and they are Central, East, South and West. The Null value is no longer appearing 
SELECT DISTINCT region
FROM sales_customer$
ORDER BY region ASC


--Viewing unique States and City that have the Postcode missing. Has return three values and they California, Kentucky and Vermont
--California returned two cities and they are Long Beach and San Diego 
--Kentucky returned one city and that is Henderson
--Vermont returned one city and that is Burlington
SELECT DISTINCT state, city, postcode
FROM sales_customer$
WHERE postcode IS NULL


--When running the below query, it returns the correct postcodes based on the State and City for California and Kentucky
--No other records returned for Vermont with the correct postcode, as there is only one record of Vermont and that record has a NULL postcode
--Another issue noticed is that there three different postcodes returned for San Diego
SELECT DISTINCT state, city, postcode
FROM sales_customer$
WHERE postcode IS NOT NULL AND
city IN ('Long Beach', 'San Diego', 'Henderson', 'Burlington') AND
state IN (SELECT state 
		  FROM sales_customer$
		  WHERE state IN ('California', 'Kentucky', 'Vermont'))


--The below query returns all records and can see the customer name is Michael Kennedy 
SELECT * 
FROM sales_customer$
WHERE postcode IS NULL AND
city = 'San Diego'


--Unfortunately the below query shows only one record matching the criterias and has a NULL postcode
SELECT name, state, city, postcode
FROM sales_customer$
WHERE name = 'Michael Kennedy' AND
city = 'San Diego'


--In the meantime, we will update the postcode for California / Long Beach and Kentucky / Henderson
UPDATE sales_customer$
SET postcode = 90805
WHERE state = 'California' AND
city = 'Long Beach'

UPDATE sales_customer$
SET postcode = 42420
WHERE state = 'Kentucky' AND
city = 'Henderson'


--Below query returns no results which is expexted as there are no postcodes that are NULL that meet the State and City criteria 
SELECT postcode, city, state
FROM sales_customer$
WHERE state IN ('California', 'Kentucky') AND
city IN ('Long Beach', 'Henderson') AND
postcode IS NULL


--The below queries returns no results which indiciates that there are no NULL values in all three columns 
SELECT DISTINCT country, state, city
FROM sales_customer$
WHERE Country IS NULL OR
state IS NULL OR
city IS NULL


--The below query returned only unique cities within that column and can see there aren't any mispelling or cities appearing twice (looking for white space)
SELECT DISTINCT city 
FROM sales_customer$
ORDER BY city


--The below query returned only unique state within that column and can see there aren't any mispelling or cities appearing twice (looking for white space)
SELECT DISTINCT state 
FROM sales_customer$
ORDER BY state


--The below query returned two records that represent the same country and they are 'Unitied States' and 'US'
SELECT DISTINCT country 
FROM sales_customer$
ORDER BY country


--Updated the Country column within the Customer table and replaced the value 'US' with 'United States'
UPDATE sales_customer$
SET country = 'United States'
WHERE country = 'US' 

SELECT DISTINCT country 
FROM sales_customer$
ORDER BY country


--Below queries provides a list of unique records within the Segment column. Can see one of the values has been spelt incorrectly 
SELECT DISTINCT segment 
FROM [salesdata].[dbo].[sales_customer$]


--Incorrect value has now been corrected
UPDATE [salesdata].[dbo].[sales_customer$]
SET segment = 'Consumer'
WHERE segment = 'Consum'

SELECT DISTINCT segment 
FROM [salesdata].[dbo].[sales_customer$]
