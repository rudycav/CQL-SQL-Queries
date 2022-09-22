#Write a query that  returns the menu sponsor (the restaurant name for the most part), the menu location, the menu place, and the full dish name for all dishes that include some keyword (I used “lo mein” ).
SELECT menus.sponsor, menus.place, menus.location, dishes.NAME
FROM menus, menu_pages, menu_items, dishes
WHERE menus.menu_id = menu_pages.menu_id
    AND menu_pages.menu_page_id = menu_items.menu_page_id 
    AND dishes.dish_id = menu_items.dish_id
    AND dishes.NAME LIKE '%lo mein%';
    
   