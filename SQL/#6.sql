#Return a list of the number of different spoken languages in each country. 
SELECT country.NAME AS 'Country', count(countrylanguage.LANGUAGE) AS 'Number if spoken languages'
FROM country, countrylanguage
WHERE country.CODE=countrylanguage.CountryCode
GROUP BY country.NAME
ORDER BY country.NAME;