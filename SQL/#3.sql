#Write a query that returns the name of all countries in which Chinese is spoken, along with the percentage of speakers
SELECT country.NAME AS 'Country', countrylanguage.Percentage AS 'Percentage'
FROM country, countrylanguage
WHERE country.code=countrylanguage.countrycode AND Language = 'chinese'; 