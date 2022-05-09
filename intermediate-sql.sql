/* The Apple Stock Prices Dataset */
SELECT * 
  FROM tutorial.aapl_historical_stock_price

/* SQL AGGREGATE FUNCTIONS 
SQL is excellent at aggregating data the way you might in a pivot table in Excel.

COUNT - counts how many rows are in a particular column.
SUM - adds together all the values in a particular column.
MIN and MAX - return the lowest and highest values in a particular column, respectively.
AVG - calculates the average of a group of selected values.
*/

/* SQL COUNT 
COUNT is a SQL aggregate function for counting the number of rows in a particular column.
*/
SELECT COUNT(*) -- using COUNT(1) has the same effect
  FROM tutorial.aapl_historical_stock_price

-- Counting individual columns 
-- Provide a count of all rows where high column is not null 
SELECT COUNT(high)
  FROM tutorial.aapl_historical_stock_price

-- Query to count number of non-null rows in the low column 
SELECT COUNT(low) -- result: 3535 
  FROM tutorial.aapl_historical_stock_price

SELECT COUNT(low) AS low -- Add column name
  FROM tutorial.aapl_historical_stock_price


-- Counting non-numerical columns
-- COUNT simply counts the total number of non-null rows, not the distinct values 
SELECT COUNT(date)
  FROM tutorial.aapl_historical_stock_price

SELECT COUNT(date) AS count_of_date -- Add column name
  FROM tutorial.aapl_historical_stock_price

SELECT COUNT(date) AS "Count of Date" -- Add column name with spaces
  FROM tutorial.aapl_historical_stock_price


-- Query that determines counts of every single column
-- With these counts, can you tell which column has the most null values?
SELECT COUNT(year) AS year,
       COUNT(month) AS month,
       COUNT(open) AS open,
       COUNT(high) AS high,
       COUNT(low) AS low,
       COUNT(close) AS close,
       COUNT(volume) AS volume
  FROM tutorial.aapl_historical_stock_price


/* SQL SUM  
- is a SQL Aggregate function that totals the values in a given column 
- can only use on numerical columns 
- aggregators only aggregate vertically 
- If you want to perform a calculation across rows, you would do this with simple arithmetic.
*/

SELECT SUM(volume) AS "Sum of Volume"
  FROM tutorial.aapl_historical_stock_price

-- Query to calculate the average opening price (hint: you will need to use both COUNT and SUM, as well as some simple arithmetic.). 
SELECT SUM(open)/COUNT(open) AS avg_open_price 
  FROM tutorial.aapl_historical_stock_price

/* SQL MIN/MAX  
- MIN and MAX are SQL aggregation functions that return the lowest and highest values in a particular column.
- can be used on non-numerical columns 
*/

-- Query selects the MIN and the MAX from the numerical volume column in the Apple stock prices dataset.
SELECT MIN(volume) AS min_volume,
       MAX(volume) AS max_volume
  FROM tutorial.aapl_historical_stock_price

-- Query for Apple's lowest stock price 
SELECT MIN(low)
  FROM tutorial.aapl_historical_stock_price

-- Query for the highest single-day increase in Apple's share value
SELECT MAX(close - open)
  FROM tutorial.aapl_historical_stock_price


/* SQL AVG 
- Calculates the average of a selected group of values.
- Can only be used on numerical columns 
- Ignores nulls completely 
- To treat null values as 0, write a statement that changes the nulls to 0
*/

-- Two queries of the Apple Stock Prices dataset 
SELECT AVG(high)
  FROM tutorial.aapl_historical_stock_price
 WHERE high IS NOT NULL 

SELECT AVG(high) -- same results with the prev query
  FROM tutorial.aapl_historical_stock_price

-- Write a query that calculates the average daily trade volume for Apple stock.
SELECT AVG(volume) AS avg_volume
  FROM tutorial.aapl_historical_stock_price


/* SQL GROUP BY
- aggregate only part of a table (e.g count the number of entries for each year) 
- allows you to separate data into groups  
*/

-- Query to count number of entries per year
SELECT year,
       COUNT(*) AS count
  FROM tutorial.aapl_historical_stock_price
  GROUP BY year 

-- To group by multiple columns, separate column names with commas—just as with ORDER BY:
SELECT year,
       month, 
       COUNT(*) AS count
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year, month 

-- Calculate the total number of shares traded each month. Order your results chronologically.
SELECT year,
       month,
       SUM(volume) AS volume_sum
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year, month
 ORDER BY year, month 
 
/* GROUP BY column numbers 
- As with ORDER BY, you can substitute numbers for column names in the GROUP BY clause.

- use this ONLY when you're grouping many columns 
*/ 
SELECT year,
       month,
       COUNT(*) AS count
  FROM tutorial.aapl_historical_stock_price
 GROUP BY 1, 2 

/* GROUP BY with LIMIT 
- SQL evaluates the aggregations before the LIMIT clause. 
- If you group by a column with enough unique values that it exceeds the LIMIT number, the aggregates will be calculated, and then some rows will simply be omitted from the results.
- This is actually a nice way to do things because you know you're going to get the correct aggregates.
*/




