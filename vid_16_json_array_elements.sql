----         o             
----         , ,-. ,-. ;-. 
----         | `-. | | | | 
----         | `-' `-' ' ' 
----        -'    postgresql

----  https://github.com/softwareNuggets
----    /PostgreSQL_shorts_resources/
----    vid_16_json_array_elements.sql


-- json_array_elements
-- Expands a JSON array 
-- to a set of JSON values.

select * 
from json_array_elements
		('[1 , "x", false]')



--drop table cart;
CREATE temporary TABLE cart (
  order_id 		int PRIMARY KEY,
  customer 		VARCHAR(50),
  items			JSON
);

INSERT INTO cart 
		    (order_id, customer, items)
VALUES 
(1, 'Alice', '[
 		{"name": "Shirt", "price": 25}, 
		{"name": "Pants", "price": 40},  
 	    {"name": "Socks", "price": 8}
 		]'),
(2, 'Bob', 
 	  '[
 		{"name": "Hat", "price": 15}, 
 		{"name": "Gloves", "price": 20}]
 	');
	





SELECT 	
	c.order_id, 
	c.customer, 
	each_item->>'name' AS name, 
	(each_item->>'price')::numeric 
							AS price
FROM cart c
CROSS JOIN 
	LATERAL 
		json_array_elements(c.items) 
					AS each_item;
		






SELECT 	
	c.order_id, 
	c.customer, 
	lat.each_item->>'name' AS name, 
	(lat.each_item->>'price')::numeric 
							AS price
FROM cart c,
	json_array_elements(c.items) 
					AS lat(each_item)
where each_item ->> 'name' = 'Gloves'					
					
	
	
SELECT 	order_id, 
		customer, 
		x.each_item->>'name' AS name, 
		(x.each_item->>'price')::numeric 
							 AS price
FROM cart
CROSS JOIN 
	LATERAL 
		json_array_elements(items) 
						AS x(each_item);		
