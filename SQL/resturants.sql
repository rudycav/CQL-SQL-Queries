--Create a view called ordered_menus which produces a view table which ordered by dish count (number of dishes on the menu)
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `ordered_menus` AS
    SELECT 
        `menus`.`name` AS `name`,
        `menus`.`sponsor` AS `sponsor`,
        `menus`.`dish_count` AS `dish_count`,
        `menus`.`menu_date` AS `menu_date`,
        `menus`.`page_count` AS `page_count`
    FROM
        `menus`
    ORDER BY `menus`.`dish_count` DESC
    
    
    
--Create a view that consists of the menu location, the menu event, and the name of each dish on the menu. 
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `dish_locations` AS
    SELECT 
        `menus`.`location` AS `location`,
        `menus`.`event` AS `event`,
        `dishes`.`name` AS `name`
    FROM
        (((`menus`
        JOIN `menu_pages`)
        JOIN `menu_items`)
        JOIN `dishes`)
    WHERE
        ((`dishes`.`dish_id` = `menu_items`.`dish_id`)
            AND (`menus`.`menu_id` = `menu_pages`.`menu_id`)
            AND (`menu_pages`.`menu_page_id` = `menu_items`.`menu_page_id`))
            
            
            
--Create and run a stored procedure that  takes one integer parameter and returns the result of subtracting 5 from it.
CREATE DEFINER=`root`@`localhost` PROCEDURE `minusfive`(input int)
BEGIN
DECLARE variable int;
SET variable = input - 5;
SELECT variable;
END



--Create and run a stored procedure that  takes an integer parameter and returns the total number of menus with a page count that equals the parameter.
CREATE DEFINER=`root`@`localhost` PROCEDURE `total_menus`(num VARCHAR(100))
BEGIN
DECLARE total_menus VARCHAR(100);
SELECT count(menus.menu_id)
INTO total_menus
FROM menus
WHERE menus.page_count = num;

SELECT total_menus;
END



--Create a procedure that takes the name of a dish as a parameter and returns the average price of menu items that whose name contains the dish name. 
CREATE DEFINER=`root`@`localhost` PROCEDURE `avg_price`(num VARCHAR(100))
BEGIN
DECLARE dish_name VARCHAR(30);
SELECT ((avg(highest_price) + avg(lowest_price))/2)
INTO dish_name
FROM dishes
WHERE dishes.name = num;

SELECT dish_name AS AverageCost;
END
