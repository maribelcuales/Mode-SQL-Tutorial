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

