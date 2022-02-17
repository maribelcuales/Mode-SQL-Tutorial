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
