#Return the total population of cities located in Western Europe. 
SELECT sum(city.population) AS 'Urban population in Western Europe'
FROM city, country
WHERE city.CountryCode=country.Code AND region='western europe';
