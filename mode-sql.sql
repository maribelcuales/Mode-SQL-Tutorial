SELECT * FROM tutorial.us_housing_units

SELECT  year,
        month,
        month_name,
        south,
        west,
        midwest,
        northeast
  FROM tutorial.us_housing_units

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

