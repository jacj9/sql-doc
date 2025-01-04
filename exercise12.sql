/*
Exercises from Lesson 12: Sorting and Limiting Query Results
Written on: December 28, 2024
*/
USE world;
SHOW TABLES;
TABLE city;
TABLE country;
TABLE countrylanguage;

-- Exercise 12.1: What's in the World Database?
/*
For the first exercise, start by simply looking at the data in each table. Use SELECT queries
to view the first 10 rows of data and all columns in each of the three tables. Note the columns
included in the table and what the data in each column looks like.
*/
SELECT COUNT(*)
FROM city
LIMIT 10;

SELECT COUNT(*)
FROM country
LIMIT 10;

SELECT *
FROM countrylanguage
LIMIT 10;


-- Exercise 12.2: Small Cities (42 rows)
/*
Generate a list of all cities with a population less than 10,000.
- Include all fields in the city in the results.
- Sort the results with the largest population at the top of the list and the lowest
population at the end of the list.
*/
SELECT *
FROM city
WHERE population < 10000
ORDER BY population DESC;


-- Exercise 12.3: Cities by Region (4,079 rows)
/*
Generate a list of all cities grouped by region and country.
- Include only the name of the region, the name of the country, and the 
name of the city.

- Sort the results in alphabetical order by region, country, and city.
*/
SELECT country.Region, country.LocalName, city.Name
FROM city
LEFT OUTER JOIN country ON city.CountryCode = country.Code
ORDER BY country.Region, country.LocalName, city.Name;


-- Exercise 12.4: Speaking French (22 rows)
/*
Generate a list of all countries where any form of French is spoken.
- Include the name of the country, the language, and the percentage of people who speak that language.
- Sort the data by percentage, with the largest value at the top of the list.
- Use a single WHERE statement without OR.
*/
SELECT country.Name As CountryName, lang.Language, lang.Percentage
FROM Country
INNER JOIN CountryLanguage lang ON Country.Code = lang.CountryCode
WHERE lang.Language = 'French'
ORDER BY lang.Percentage DESC;


-- Exercise 12.5: No Independence (47 rows)
/*
Generate a list of countries for which no year of independence is provided.
-- Include only the country name, continent, and population for each country in the list.
-- Sort in alphabetical order by the country names.
*/
SELECT Name AS CountryName, Continent, Population
FROM Country
WHERE IndepYear IS NULL
ORDER BY Name;


-- Exercise 12.6: Country Languages (990 rows)
/*
Generate a list of countries and the languages that are spoken in each country.
- Include only the country name, continent, language, and percentage spoken for each country.
- Include all countries, even those for which no language is specified.
- Sort by country name in alphabetical order and then by percentage, with the highest percentage first.
*/
TABLE Country;
TABLE CountryLanguage;

SELECT Country.Name AS CountryName, Country.Continent, lang.Language, lang.Percentage
FROM Country
LEFT JOIN CountryLanguage lang ON Country.Code = lang.CountryCode
ORDER BY Country.Name ASC, lang.Percentage DESC;


-- Exercise 12.7: No Language (6 rows)
/*
Generate a list of countries for which no language is specified.
- Include only the country name and continent.
- Sort alphabetically by continent and country name
*/
SELECT Country.Name AS CountryName, Country.Continent
FROM Country
LEFT JOIN CountryLanguage ON Country.Code = CountryLanguage.CountryCode
WHERE CountryLanguage.Language IS NULL
ORDER BY Country.Continent, Country.Name;


-- Exercise 12.8: City Population (232 rows)
/*
Calculate the total city population for each country.
- Include the country name and total population.  
- Sort the results by total population, starting with the smallest value.
*/
TABLE City;
TABLE Country;

SELECT Country.Name AS CountryName, SUM(City.Population) AS TotalPopulation
FROM City
LEFT JOIN Country ON City.CountryCode = Country.Code
GROUP BY Country.Name
ORDER BY SUM(City.Population) ASC;


-- Exercise 12.9: Average City Population (7 rows)
/*
Calculate the average city population for each continent.
- Include all continent names and average population in the results.
- Sort the results by average population, starting with the largest value.
*/
TABLE City;
TABLE Country;

SELECT Country.Continent, AVG(City.Population)
FROM City
RIGHT JOIN Country ON City.CountryCode = Country.Code
GROUP BY Country.Continent
ORDER BY AVG(City.Population) DESC;


-- Exercise 12.10: GNP
/*
Generate a list of the 10 countries with the highest GNP.
- Include the country name and GNP columns.
*/
SELECT Name, GNP
FROM Country
ORDER BY GNP DESC
LIMIT 10;


-- Exercise 12.11: Capital Cities (4,079 rows)
/*
Generate a list of the capital cities with the population and the official language(s) for that country.
- Include the name of the city, the country where the city is located, the city's
population, and the country's official languages.
- Use meaningful names to distinguish the column headings.
- Sort by city name alphabetically.
*/
TABLE City;
Table Country;
TABLE CountryLanguage;

SELECT City.Name AS CityName, Country.Name AS CountryName, City.Population, CountryLanguage.Language
FROM City
LEFT OUTER JOIN Country ON City.ID = Country.Capital
LEFT OUTER JOIN CountryLanguage ON Country.Code = CountryLanguage.CountryCode
ORDER BY ISNULL(Country.Name), City.Name ASC;


-- Exercise 12.12: Country Capital Cities (239 rows)
/*
Generate a list of countries and their capital cities.
- Include the name of the country and the name of the city in the results, using
a meaningful name for each columns.
- Include countries with no capital city.
- Sort alphabetically by country name.
*/
SELECT Country.Name AS CountryName, City.Name AS CityName, City.Population, CountryLanguage.Language
FROM City
RIGHT OUTER JOIN Country ON City.ID = Country.Capital
LEFT OUTER JOIN CountryLanguage ON Country.Code = CountryLanguage.CountryCode
GROUP BY Country.Name
ORDER BY ISNULL(City.Name), Country.Name ASC;