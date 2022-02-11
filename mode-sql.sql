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
