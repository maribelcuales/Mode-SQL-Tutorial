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

SELECT COUNT(low) AS low --Solution (same result 3535) 
  FROM tutorial.aapl_historical_stock_price

