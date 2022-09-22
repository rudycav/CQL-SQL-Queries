#Write a query that returns the menu item id, name, date first appeared and date last appeared of all dishes that include the term “curry”. 

SELECT menu_items.menu_items_id AS 'Item ID', dishes.NAME AS 'Name of Dish', dishes.first_appeared AS 'Year first listed', dishes.last_appeared AS 'Year last listed'
FROM menu_items, dishes
WHERE menu_items.dish_id=dishes.dish_id AND NAME LIKE '%curry%';

