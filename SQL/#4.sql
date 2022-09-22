# Return the name of all countries in which the percentage of Arabic speakers is higher than the average number of Arabic speakers across all countries
SELECT country.NAME AS 'Percentage of Arabic speakers > Average Arabic speakers'
FROM country
WHERE EXISTS
	(SELECT percentage > AVG(country.NAME)
    FROM countrylanguage
    WHERE country.code=countrylanguage.CountryCode AND countrylanguage.Language = 'arabic');