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

-- Query to calculate the average daily price change in Apple stock, grouped by year.
SELECT year,
       AVG(close - open) AS avg_daily_change
  FROM tutorial.aapl_historical_stock_price
 GROUP BY 1
 ORDER BY 2
 
SELECT year,
       AVG(close - open) AS "Average Daily Change"
  FROM tutorial.aapl_historical_stock_price
 GROUP BY 1
 ORDER BY 2

/* 
Write a query that calculates the lowest and highest prices that Apple stock achieved each month.
*/
SELECT year,
       month,
       MIN(low) AS lowest_price,
       MAX(high) AS highest_price
  FROM tutorial.aapl_historical_stock_price
 GROUP BY 1, 2
 ORDER BY 1, 2

/* 
Write a query that calculates the lowest prices that Apple stock achieved each month.
*/
SELECT year,
       month,
       MIN(low) AS "Lowest Apple Stock Price",
  FROM tutorial.aapl_historical_stock_price
 GROUP BY 1, 2
 ORDER BY 1, 2


/* 
SQL HAVING
HAVING is the "clean" way to filter a query that has been aggregated, but this is also commonly done using a subquery, which you will learn about in a later lesson.

The WHERE clause won't work for this because it doesn't allow you to filter on aggregate columns—that's where the HAVING clause comes in.
*/

-- Query find every month during which AAPL stock worked its way over $400/share. 
SELECT year,
       month,
       MAX(high) AS month_high
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year, month 
HAVING MAX(high) > 400
 ORDER BY year, month

/*
QUERY CLAUSE ORDER 
The order in which you write the clauses is important. Here'rs the order for everything you've learned so far:

SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
*/

/* 
SQL CASE Statement 

The CASE statement is SQL's way of handling if/then logic. 

The CASE statement is followed by at least one pair of WHEN and THEN statements—SQL's equivalent of IF/THEN in Excel.

Every CASE statement must end with the END statement. The ELSE statement is optional, and provides a way to capture values not specified in the WHEN/THEN statements.
*/

SELECT player_name, -- values for player_name & year
       year, 
       CASE WHEN year = 'SR' THEN 'yes' --checks each row if conditional statement is true  
            ELSE NULL END AS is_a_senior -- if false, nothing happens in that row and a null value is left on the column 
  FROM benn.college_football_players
 

/* 
CASE Query: Replace nulls with "no" 
*/ 
SELECT player_name,
       year,
       CASE WHEN year = 'SR' THEN 'yes'
            ELSE 'no' END AS is_a_senior
  FROM benn.college_football_players

/* 
Query that includes a column that is flagged 'yes' when a player is from California. 
Sort the results with those players first. 
*/
SELECT player_name,
       state,
       CASE WHEN state = 'CA' THEN 'yes'
            ELSE NULL END AS from_california
  FROM benn.college_football_players
 ORDER BY 3

/* 
Adding multiple conditions to a CASE statement 
*/

-- Can define a number of outcomes in a CASE statement by including as many WHEN/THEN statements as you'd like
SELECT player_name,
       weight,
       CASE WHEN weight > 250 THEN 'over 250'
            WHEN weight > 200 THEN '201-250'
            WHEN weight > 175 THEN '176-200'
            ELSE '175 or under' END AS weight_group
  FROM benn.college_football_players

-- BEST PRACTICE: Create statements that don't overlap 
SELECT player_name,
       weight,
       CASE WHEN weight > 250 THEN 'over 250'
            WHEN weight > 200 AND weight <= 250 THEN '201-250'
            WHEN weight > 175 AND weight <= 200 THEN '176-200'
            ELSE '175 or under' END AS weight_group
  FROM benn.college_football_players

/* 
Write a query that includes players' names and a column that classifies them into four categories based on height. Answer below is just one of many possible answers, since you could divide players' heights in many ways.
*/
SELECT player_name,
       height,
       CASE WHEN height > 74 THEN 'over 74'
            WHEN height > 72 AND height <= 74 THEN '73-74'
            WHEN height > 70 AND height <= 72 THEN '71-72'
            ELSE 'under 70' END AS height_group
  FROM benn.college_football_players

-- You can also string together multiple conditional statements with AND and OR the same way you might in a WHERE clause:
SELECT player_name,
       year,
       position,
       CASE WHEN year = 'FR' AND position = 'WR' THEN 'frosh_wr'
            ELSE NULL END AS sample_case_statement 
  FROM benn.college_football_players

-- Write a query that selects all columns and adds an additional column that displays the player's name if that player is a junior or senior.
SELECT *,
       CASE WHEN year IN ('JR', 'SR') THEN player_name ELSE NULL END AS upperclass_player_name
  FROM benn.college_football_players

/* 
A quick review of CASE basics:
The CASE statement always goes in the SELECT clause
CASE must include the following components: WHEN, THEN, and END. ELSE is an optional component.
You can make any conditional statement using any conditional operator (like WHERE ) between WHEN and THEN. This includes stringing together multiple conditional statements using AND and OR.
You can include multiple WHEN statements, as well as an ELSE statement to deal with any unaddressed conditions.
*/

/* 
Using CASE with Aggregate Functions

Only count rows that fulfill a certain condition. Since COUNT ignores nulls, you could use a CASE statement to evaluate the condition and produce null or non-null values depending on the outcome:
*/
SELECT CASE WHEN year = 'FR' THEN 'FR'
            ELSE 'Not FR' END AS year_group,
            COUNT(1) AS count
  
  FROM benn.college_football_players
 GROUP BY CASE WHEN year = 'FR' THEN 'FR'
               ELSE 'Not FR' END 

-- Use a WHERE clause to filter out the rows I don't want to count?" 
SELECT COUNT(1) AS fr_count
  FROM benn.college_football_players
 WHERE year = 'FR'

-- Counting multiple conditions in one query (The WHERE clause only allows you to count one condition)
SELECT CASE WHEN year = 'FR' THEN 'FR'
            WHEN year = 'SO' THEN 'SO'
            WHEN year = 'JR' THEN 'JR'
            WHEN year = 'SR' THEN 'SR'
            ELSE 'No Year Data' END AS year_group,
            COUNT(1) AS count
  FROM benn.college_football_players
 GROUP BY 1

-- The above query is an excellent place to use numbers instead of columns in the GROUP BY clause because repeating the CASE statement in the GROUP BY clause would make the query obnoxiously long.

-- use the column's alias in the GROUP BY clause like this:
SELECT CASE WHEN year = 'FR' THEN 'FR'
            WHEN year = 'SO' THEN 'SO'
            WHEN year = 'JR' THEN 'JR'
            WHEN year = 'SR' THEN 'SR'
            ELSE 'No Year Data' END AS year_group,
            COUNT(1) AS count
  FROM benn.college_football_players
 GROUP BY year_group

-- if you do choose to repeat the entire CASE statement, you should remove the AS year_group column naming when you copy/paste into the GROUP BY clause:
SELECT CASE WHEN year = 'FR' THEN 'FR'
            WHEN year = 'SO' THEN 'SO'
            WHEN year = 'JR' THEN 'JR'
            WHEN year = 'SR' THEN 'SR'
            ELSE 'No Year Data' END AS year_group,
            COUNT(1) AS count
  FROM benn.college_football_players
 GROUP BY CASE WHEN year = 'FR' THEN 'FR'
               WHEN year = 'SO' THEN 'SO'
               WHEN year = 'JR' THEN 'JR'
               WHEN year = 'SR' THEN 'SR'
               ELSE 'No Year Data' END

-- Combining CASE statements with aggregations can be tricky at first. It's often helpful to write a query containing the CASE statement first and run it on its own. Using the previous example, you might first write:
SELECT CASE WHEN year = 'FR' THEN 'FR'
            WHEN year = 'SO' THEN 'SO'
            WHEN year = 'JR' THEN 'JR'
            WHEN year = 'SR' THEN 'SR'
            ELSE 'No Year Data' END AS year_group,
            *
  FROM benn.college_football_players

-- Write a query that counts the number of 300lb+ players for each of the following regions: West Coast (CA, OR, WA), Texas, and Other (everywhere else).
SELECT CASE WHEN state IN ('CA', 'OR', 'WA') THEN 'West Coast'
            WHEN state = 'TX' THEN 'Texas'
            ELSE 'Other' END AS arbitrary_regional_designation,
            COUNT(1) AS players
  FROM benn.college_football_players
 WHERE weight >= 300
 GROUP BY 1

-- Write a query that calculates the combined weight of all underclass players (FR/SO) in California as well as the combined weight of all upperclass players (JR/SR) in California.
SELECT CASE WHEN year IN ('FR', 'SO') THEN 'underclass'
            WHEN year IN ('JR', 'SR') THEN 'upperclass'
            ELSE NULL END AS class_group,
       SUM(weight) AS combined_player_weight
  FROM benn.college_football_players
 WHERE state = 'CA'
 GROUP BY 1  

/* 
Using CASE inside of aggregate functions

In the previous examples, data was displayed vertically, but in some instances, you might want to show data horizontally. This is known as "pivoting" (like a pivot table in Excel). Let's take the following query:
*/
SELECT CASE WHEN year = 'FR' THEN 'FR'
            WHEN year = 'SO' THEN 'SO'
            WHEN year = 'JR' THEN 'JR'
            WHEN year = 'SR' THEN 'SR'
            ELSE 'No Year Data' END AS year_group,
            COUNT(1) AS count
  FROM benn.college_football_players
 GROUP BY 1

-- Re-orient horizontally:
SELECT COUNT(CASE WHEN year = 'FR' THEN 1 ELSE NULL END) AS fr_count,
       COUNT(CASE WHEN year = 'SO' THEN 1 ELSE NULL END) AS so_count,
       COUNT(CASE WHEN year = 'JR' THEN 1 ELSE NULL END) AS jr_count,
       COUNT(CASE WHEN year = 'SR' THEN 1 ELSE NULL END) AS sr_count
  FROM benn.college_football_players 

-- Write a query that displays the number of players in each state, with FR, SO, JR, and SR players in separate columns and another column for the total number of players. Order results such that states with the most players come first.
SELECT state,
       COUNT(CASE WHEN year = 'FR' THEN 1 ELSE NULL END) AS fr_count,
       COUNT(CASE WHEN year = 'SO' THEN 1 ELSE NULL END) AS so_count,
       COUNT(CASE WHEN year = 'JR' THEN 1 ELSE NULL END) AS jr_count,
       COUNT(CASE WHEN year = 'SR' THEN 1 ELSE NULL END) AS sr_count,
       COUNT(1) AS total_players
  FROM benn.college_football_players
 GROUP BY state
 ORDER BY total_players DESC

-- Write a query that shows the number of players at schools with names that start with A through M, and the number at schools with names starting with N - Z.
SELECT CASE WHEN school_name < 'n' THEN 'A-M'
            WHEN school_name >= 'n' THEN 'N-Z'
            ELSE NULL END AS school_name_group,
       COUNT(1) AS players
  FROM benn.college_football_players
 GROUP BY 1


/* 
SQL DISTINCT 

Using SQL DISTINCT for viewing unique values
- DISTINCT can be particularly helpful when exploring a new data set.
- Looking at the unique values on each column can help identify how you might want to group or filter the data.
*/

-- Query to select unique values from the month column in the Apple stock prices dataset: 
SELECT DISTINCT month
  FROM tutorial.aapl_historical_stock_price

-- Query to include two (or more) columns in a SELECT DISTINCT clause, your results will contain all of the unique pairs of those two columns:
SELECT DISTINCT year, month
  FROM tutorial.aapl_historical_stock_price 

-- Write a query that returns the unique values in the year column, in chronological order.
SELECT DISTINCT year
  FROM tutorial.aapl_historical_stock_price
 ORDER BY yearr


/* 
Using DISTINCT in aggregations

You can use DISTINCT when performing an aggregation. You'll probably use it most commonly with the COUNT function.
*/

-- Query below that counts the unique values in the month column. 

SELECT COUNT(DISTINCT month) AS unique_months
  FROM tutorial.aapl_historical_stock_price

-- Query taking average trade volumes by month to get a sense of when Apple stock really moves:
SELECT month,
       AVG(volume) AS avg_trade_volume
  FROM tutorial.aapl_historical_stock_price
 GROUP BY month
 ORDER BY 2 DESC

-- DISTINCT goes inside the aggregate function rather than at the beginning of the SELECT clause. You can SUM or AVG the distinct values in a column, but there are fewer practical applications for them. 

/* 
DISTINCT PERFORMANCE 

Using DISTINCT, particularly in aggregations, can slow your queries down quite a bit.

For MAX and MIN, you probably shouldn't ever use DISTINCT because the results will be the same as without DISTINCT, and the DISTINCT function will make your query substantially slower to return results.
*/

-- Query that counts the number of unique values in the month column for each year
SELECT year,
       COUNT(DISTINCT month) AS months_count
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year
 ORDER BY year 

-- Write a query that separately counts the number of unique values in the month column and the number of unique values in the `year` column.
SELECT COUNT(DISTINCT year) AS years_count,
       COUNT(DISTINCT month) AS months_count
  FROM tutorial.aapl_historical_stock_price
  
  
/* 
SQL JOINS 

The real power of SQL, however, comes from working with data from multiple tables at once.

The tables you've been working with up to this point are all part of the same schema in a relational database. The term "relational database" refers to the fact that the tables within it "relate" to one another—they contain common identifiers that allow information from multiple tables to be combined easily.

In an organization like Twitter, it now has two tables. The first table—the users table—contains profile information, and has one row per user. The second table—the tweets table—contains tweet information, including the username of the person who sent the tweet. By matching—or joining—that username in the tweets table to the username in the users table, Twitter can still connect profile information to every tweet.

*/

-- Query to figure out which conference has the highest average weight. Given that information is in two separate tables, how do you do that? A join!
SELECT teams.conference AS conference,
       AVG(players.weight) AS average_weight
  FROM benn.college_football_players players
  JOIN benn.college_football_teams teams
    ON teams.school_name = players.school_name
 GROUP BY teams.conference
 ORDER BY AVG(players.weight) DESC

-- You can give a table an alias by adding a space after the table name and typing the intended name of the alias. As with column names, best practice here is to use all lowercase letters and underscores instead of spaces.

-- Query that selects the school name, player name, position, and weight for every player in Georgia, ordered by weight (heaviest to lightest). Be sure to make an alias for the table, and to reference all column names in relation to the alias.
SELECT players.school_name,
       players.player_name,
       players.position,
       players.weight
  FROM benn.college_football_players players
 WHERE players.state = 'GA'
 ORDER BY players.weight DESC

/*
JOIN and ON u

After the FROM statement, we have two new statements: JOIN, which is followed by a table name, and ON, which is followed by a couple column names separated by an equals sign.

ON indicates how the two tables (the one after the FROM and the one after the JOIN) relate to each other. You can see in the example above that both tables contain fields called school_name. Sometimes relational fields are slightly less obvious. For example, you might have a table called schools with a field called id, which could be joined against school_id in any other table. 

These relationships are sometimes called "mappings." teams.school_name and players.school_name, the two columns that map to one another, are referred to as "foreign keys" or "join keys." Their mapping is written as a conditional statement:
*/

ON teams.school_name = players.school_name
-- Join all rows from the players table on to rows in the teams table for which the school_name field in the players table is equal to the school_name field in the teams table.

-- When you run a query with a join, SQL performs the same operation as it did above to every row of the table after the FROM statement. To see the full table returned by the join, try running this query:
SELECT *      -- returns all columns 
  FROM benn.college_football_players players
  JOIN benn.college_football_teams teams
    ON teams.school_name = players.school_name


-- Return only columns from one table    
SELECT players.* 
  FROM benn.college_football_players players
  JOIN benn.college_football_teams teams
    ON teams.school_name = players.school_name

/* 
SQL INNER JOIN

It's often the case that one or both tables being joined contain rows that don't have matches in the other table. The way this is handled depends on whether you're making an inner join or an outer join.

Inner joins eliminate rows from both tables that do not satisfy the join condition set forth in the ON statement. In mathematical terms, an inner join is the intersection of the two tables.
*/

-- Joining tables with identical column names
-- Query with both tables that have columns called school_name
SELECT players.*,
       teams.*
  FROM benn.college_football_players players
  JOIN benn.college_football_teams teams
    ON teams.school_name = players.school_name

-- The results can only support one column with a given name—when you include 2 columns of the same name, the results will simply show the exact same result set for both columns even if the two columns should contain different data.


-- Name columns individually 
-- It happens that these two columns will actually contain the same data because they are used for the join key, but the following query technically allows these columns to be independent:
SELECT players.school_name AS players_school_name,
       teams.school_name AS teams_school_name
  FROM benn.college_football_players players
  JOIN benn.college_football_teams teams
    ON teams.school_name = players.school_name


-- Query that displays player names, school names and conferences for schools in the "FBS (Division I-A Teams)" division.
SELECT players.player_name,
       players.school_name,
       teams.conference
  FROM benn.college_football_players players
  JOIN benn.college_football_teams teams
    ON teams.school_name = players.school_name
 WHERE teams.division = 'FBS (Division I-A Teams)'


/* 
SQL OUTER JOINS 
When performing an inner join, rows from either table that are unmatched in the other table are not returned. 

In an outer join, unmatched rows in one or both tables can be returned. There are a few types of outer joins:

LEFT JOIN - returns only unmatched rows from the left table.
RIGHT JOIN - returns only unmatched rows from the right table.
FULL OUTER JOIN - returns unmatched rows from both tables.
*/

-- Crunchbase dataset: a crowdsourced index of startups, founders, investors, and the activities of all three
SELECT *
  FROM tutorial.crunchbase_companies

