#Write a query that returns all the country names and regions, ordered by country name. 
SELECT country.NAME AS 'Name', country.region AS 'Region'
FROM country
ORDER BY NAME;
