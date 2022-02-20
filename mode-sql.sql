/* Query/select all */
SELECT * FROM tutorial.us_housing_units

/* Query/select all without using * */
SELECT  year,
        month,
        month_name,
        south,
        west,
        midwest,
        northeast
  FROM tutorial.us_housing_units

/* Query year, month, and west */
SELECT  year,
        month, 
        west 
  FROM tutorial.us_housing_units

/* Rename a column with spaces*/
SELECT west AS "West Region" 
  FROM tutorial.us_housing_units

/* Rename a column with lower-case */
SELECT west AS West_Region,
       south AS South_Region
  FROM tutorial.us_housing_units

/*Rename column names with first letter capitalized */
SELECT  year AS "Year",
        month AS "Month",
        month_name AS "Month Name",
        west AS "West",
        midwest AS "Midwest",
        south AS "South",
        northeast AS "Northeast"
  FROM tutorial.us_housing_units

/* Limit returned rows to 100 */
SELECT *
  FROM tutorial.us_housing_units
 LIMIT 100

/* Filtering data according to month */
SELECT *
  FROM tutorial.us_housing_units
 WHERE month = 1 

/* Filtering data according to month and limit resutls to 100*/
SELECT *
  FROM tutorial.us_housing_units
 WHERE month = 1 
 LIMIT = 100

/* Filter data by month = 5 and limit resutls to 100*/
SELECT *
  FROM tutorial.us_housing_units
 WHERE month = 5
 LIMIT = 100


/* COMPARISON OPERATORS 
Equal                     = 
Not equal to              <> or !=
Greater than, Less than   >, <
Greater than or equal to  >=
Less than or equal to     >=
*/

/* Return rows where west region produced more than 30,000 units  */
SELECT *
  FROM tutorial.us_housing_units
 WHERE west > 30

/* Query if south produced 20,000 or fewer housing units */
SELECT *
  FROM tutorial.us_housing_units
 WHERE south < 20


/* NON-NUMERICAL DATA 
If you're using a comparison operator with values that are non-numeric, you need to put the value in single quotes: 'value'.

Note: SQL uses single quotes to reference column values. 

You can use >, <, and the rest of the comparison operators on non-numeric columns as well—they filter based on alphabetical order.
*/
SELECT *
  FROM tutorial.us_housing_units
 WHERE month_name != 'January'

SELECT *
  FROM tutorial.us_housing_units
 WHERE month_name > 'January'

/*NOT a good query */
SELECT *
  FROM tutorial.us_housing_units
 WHERE month_name > 'J'

SELECT *
  FROM tutorial.us_housing_units
 WHERE month_name = 'February'


/* 
ARITHMETIC IN SQL 
In SQL, you can only perform arithmetic across columns on values in a given row.

You can only add values in multiple columns from the same row together using +.

if you want to add values across multiple rows, you'll need to use aggregate functions.
*/

/* The above example produces a column showing the sum of whatever is in the south and west columns for each row.  */
SELECT year,
       month,
       west,
       south,
       west + south AS south_plus_west
  FROM tutorial.us_housing_units

/* You can chain arithmetic functions, including both column names and actual numbers. 

The columns that contain the arithmetic functions are called "derived columns" because they are generated by modifying the information that exists in the underlying data.
*/
SELECT year,
       month,
       west,
       south,
       west + south - 4 * year AS nonsense_column 
  FROM tutorial.us_housing_units

/* Query that calculates the sum of all four regions in a separate column. */
SELECT year,
       month,
       west,
       south,
       midwest,
       northeast,
       west + south + midwest + northeast AS usa_total
  FROM tutorial.us_housing_units

/* Query to get the average of west and south */
SELECT year,
       month,
       west,
       south,
       (west + south)/2 AS south_west_avg
  FROM tutorial.us_housing_units

/* Write a query that returns all rows for which more units were produced in the West region than in the Midwest and Northeast combined. */
SELECT year,
       month,
       west,
       south,
       midwest,
       northeast
  FROM tutorial.us_housing_units
  WHERE west > (midwest + northeast)

/* Query that calculates the percentage of all houses completed in the United States represented by each region. Only return results from the year 2000 and later.

Hint: There should be four columns of percentages. */ 
SELECT year,
       month,
       west/(west + south + midwest + northeast)*100 AS west_pct,
       south/(west + south + midwest + northeast)*100 AS south_pct,
       midwest/(west + south + midwest + northeast)*100 AS midwest_pct,
       northeast/(west + south + midwest + northeast)*100 AS northeast_pct
  FROM tutorial.us_housing_units
 WHERE year >= 2000


/* 
LOGICAL OPERATORS 
Logical operators allow you to use multiple comparison operators in one query.

LIKE allows you to match similar values, instead of exact values.
IN allows you to specify a list of values you'd like to include.
BETWEEN allows you to select only rows within a certain range.
IS NULL allows you to select rows that contain no data in a given column.
AND allows you to select only rows that satisfy two conditions.
OR allows you to select rows that satisfy either of two conditions.
NOT allows you to select rows that do not match a certain condition.
*/

/* Use dataset from Billboard Music Charts. It contains year-end results of the year's top 100 songs from 1956-2013.  */
SELECT * 
  FROM tutorial.billboard_top_100_year_end


/* Query results order by year and year_rank  */
SELECT * 
  FROM tutorial.billboard_top_100_year_end
ORDER BY year DESC, year_rank

/*
SQL LIKE Operator 
LIKE is a logical operator in SQL that allows you to match on similar values rather than exact ones. 
*/

/* The "group" appears in double quotations as a way of indicating that you are referring to the column name "group", not the SQL function. 

In general, putting double quotes around a word or phrase will indicate that you are referring to that column name. 

Like is case-sensitive. The % represents any character or set of characters. */
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" LIKE 'Snoop%'

/* Use ILIKE to ignore case when matching values */
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" ILIKE 'snoop%'

/* You can also use _ (a single underscore) to substitute for an individual character. */
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE artist ILIKE 'dr_ke'

/* Query for all rows which Ludacris was a member of the group.*/
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" ILIKE '%ludacris%'

/* Query for all rows which the first artist listed in the group begins with DJ. */
SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE "group" LIKE 'DJ%'


