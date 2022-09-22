#Write a query that returns all the country names and regions, ordered by country name. 
SELECT country.NAME AS 'Name', country.region AS 'Region'
FROM country
ORDER BY NAME;


#Write a query that returns the name of all countries in which Chinese is spoken, along with the percentage of speakers
SELECT country.NAME AS 'Country', countrylanguage.Percentage AS 'Percentage'
FROM country, countrylanguage
WHERE country.code=countrylanguage.countrycode AND Language = 'chinese'; 


# Return the name of all countries in which the percentage of Arabic speakers is higher than the average number of Arabic speakers across all countries
SELECT country.NAME AS 'Percentage of Arabic speakers > Average Arabic speakers'
FROM country
WHERE EXISTS
	(SELECT percentage > AVG(country.NAME)
    FROM countrylanguage
    WHERE country.code=countrylanguage.CountryCode AND countrylanguage.Language = 'arabic');
    
    
#Return the total population of cities located in Western Europe. 
SELECT sum(city.population) AS 'Urban population in Western Europe'
FROM city, country
WHERE city.CountryCode=country.Code AND region='western europe';


#Return a list of the number of different spoken languages in each country. 
SELECT country.NAME AS 'Country', count(countrylanguage.LANGUAGE) AS 'Number if spoken languages'
FROM country, countrylanguage
WHERE country.CODE=countrylanguage.CountryCode
GROUP BY country.NAME
ORDER BY country.NAME;


#Write a query that returns the menu item id, name, date first appeared and date last appeared of all dishes that include the term “curry”. 
SELECT menu_items.menu_items_id AS 'Item ID', dishes.NAME AS 'Name of Dish', dishes.first_appeared AS 'Year first listed', dishes.last_appeared AS 'Year last listed'
FROM menu_items, dishes
WHERE menu_items.dish_id=dishes.dish_id AND NAME LIKE '%curry%';


#Write a query that  returns the menu sponsor (the restaurant name for the most part), the menu location, the menu place, and the full dish name for all dishes that include some keyword (I used “lo mein” ).
SELECT menus.sponsor, menus.place, menus.location, dishes.NAME
FROM menus, menu_pages, menu_items, dishes
WHERE menus.menu_id = menu_pages.menu_id
    AND menu_pages.menu_page_id = menu_items.menu_page_id 
    AND dishes.dish_id = menu_items.dish_id
    AND dishes.NAME LIKE '%lo mein%';




