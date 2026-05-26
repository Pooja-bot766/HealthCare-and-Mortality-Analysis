#HEALTHCARE & MORTALITY ANALYSIS

CREATE DATABASE health_project; # helps to create a new database in MySQL to store tables.

USE health_project; # used to select a specific database to work on.

SHOW databases; # displays all available databases in MySQL.
SHOW tables; # displays all available tables inside the selected database.

DESCRIBE health_indicators; #shows table structure including column names,null values and keys.

SELECT * FROM health_indicators; # retrieves all columns from a table.
SELECT country_name from health_indicators; # fetches required columns from a table.

select * from health_indicatores limit 5; # restricts the number of rows returned.
SELECT * FROM health_indicators LIMIT 10;

Select distinct region from health_indicators; #reomves duplicate values and returnss only unique records.

SELECT * FROM health_indicators WHERE country_name = 'India'; #filters rows based on specific columns.

SELECT country_name, life_expectancy FROM health_indicators WHERE life_expectancy > 80; # used to compare values.

SELECT country_name, region, gdp_per_capita
 FROM health_indicators 
 WHERE region = 'East Asia & Pacific' 
 AND gdp_per_capita > 10000; # returns records only if all conditions are true.
 
SELECT *
FROM health_indicators
WHERE country_name = 'India'
OR country_name = 'China'; # returns records if at least one condition is true.

SELECT *
FROM health_indicators
WHERE life_expectancy
BETWEEN 70 AND 80; # used for range-based analysis.

SELECT *
FROM health_indicators
WHERE country_name
IN ('India','Japan'); #allows filtering multiple values in a single query, also IN is specified as shorthand operator of OR.

SELECT *
FROM health_indicators
WHERE country_name
LIKE 'A%'; # searches patterns in text values.

SELECT *
FROM health_indicators
ORDER BY life_expectancy ASC; # sorts data in ascending format(default).

SELECT *
FROM health_indicators
ORDER BY life_expectancy DESC; #sorts data in descending format.

#Aggregate Functions: perform calculations on multiple rows and return a single result
SELECT COUNT(*)
FROM health_indicators; #counts total rows.

SELECT AVG(life_expectancy)
FROM health_indicators; #calculates average value.

SELECT MAX(gdp_per_capita)
FROM health_indicators; #returns highest value.

SELECT MIN(life_expectancy)
FROM health_indicators; # returns lowest value.

SELECT SUM(population)
FROM health_indicators; #calculates total sum.

#GROUPBY- groups rows having similar values,used with aggregate functions
SELECT region,
AVG(life_expectancy)
FROM health_indicators
GROUP BY region;

SELECT region,
AVG(life_expectancy)
FROM health_indicators
GROUP BY region
HAVING AVG(life_expectancy) > 75; # having- filters grouped data after aggregation.

SELECT *
FROM health_indicators
WHERE life_expectancy IS NULL; #used to identify incomplete data,unknown value.

SELECT country_name AS country
FROM health_indicators; #as is used for temporarily renames columns or tables.

#RANK() Window Function: used to assign rankings to rows based on a specified column.
SELECT country_name,
life_expectancy,
RANK() OVER
(
ORDER BY life_expectancy DESC
)
AS country_rank
FROM health_indicators;

#ROW_NUMBER() Window Function: assigns a unique sequential number to each row.
SELECT country_name,
gdp_per_capita,
ROW_NUMBER() OVER
(
ORDER BY gdp_per_capita DESC
)
AS row_num
FROM health_indicators;

#DELETE :- used to remove specific rows from a table based on a condition.
DELETE FROM health_indicators
WHERE country_name = 'India';

#TRUNCATE :-used to remove all records from a table completely but structure of the table remains same.
TRUNCATE TABLE health_indicators;

#DROP:-used to permanently remove the entire table or database including structure and data.
DROP TABLE health_indicators;

#UPDATE :-modifies existing records in a table
UPDATE health_indicators
SET income_level = 'High income'
WHERE country_name = 'Japan';

#ALTER TABLE:- modifies an existing table structure.
ALTER TABLE health_indicators
RENAME COLUMN gdp_per_capita
TO gdp;

#STRING FUNCTIONS
SELECT UPPER(country_name)
FROM health_indicators; #converts to upper case.

SELECT country_name,
LENGTH(country_name)
FROM health_indicators; #returns the length of particalur data in a column.

#CASE statement
SELECT country_name,
CASE
WHEN life_expectancy > 80
THEN 'Healthy Country'
WHEN life_expectancy > 70
THEN 'Moderate'
ELSE 'Needs Improvement'
END AS health_category
FROM health_indicators;

#SUBQUERY - a query inside another query.
SELECT country_name,
gdp_per_capita
FROM health_indicators
WHERE gdp_per_capita >
(
SELECT AVG(gdp_per_capita)
FROM health_indicators
); #Countries above average GDP

#JOINS - used to combine data from two or more tables based on a common column.
  #left join - returns all records from the left table and matching records from the right table.
SELECT c.country_name,
c.indicator_name,
m.category
FROM country_latest c
INNER JOIN indicator_metadata m
ON c.indicator_code =
m.indicator_code; 

#inner join - returns only matching records from both tables.
SELECT c.country_name,
c.indicator_name,
m.category
FROM country_latest c
INNER JOIN indicator_metadata m
ON c.indicator_code =
m.indicator_code;

#right join - returns all records from the right table and matching records from the left table.
SELECT c.country_name,
m.indicator_name,
m.category
FROM country_latest c
RIGHT JOIN indicator_metadata m
ON c.indicator_code =
m.indicator_code;

#SELF JOIN - joins a table with itself.
SELECT a.country_name,
b.country_name,
a.region
FROM health_indicators a
JOIN health_indicators b
ON a.region = b.region
AND a.country_name != b.country_name;

#FULL OUTER JOIN - Returns all matching and non-matching records from both tables. 
   # uses union operator to fetch data.