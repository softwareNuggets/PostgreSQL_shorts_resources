--drop table orders
--truncate table orders
CREATE TEMPORARY TABLE orders (
  order_id 		SERIAL PRIMARY KEY,
  customer_name varchar(20),
  item_list 	varchar(50)
);

INSERT INTO orders 
		   (customer_name, item_list)
VALUES
('John',   'Shirt, Pants, Socks'),
('Jane',   'Dress, Hat'),
('Bob',    'Pants, Shoes, Socks'),
('Sarah',  'Shirt, Shoes, Socks'),
('David',  'Pants, Hat'),
('Lisa',   'Shirt, Pants, Shoes, Hat'),
('Mike',   'Shirt, Shoes'),
('Emily',  'Dress, Shoes, Hat'),
('Tom',    'Shirt, Pants, Shoes'),
('Henry',  'Shirt, Pants, Shoes, Socks');


select 	string_to_array(item_list, ', ')
FROM  	orders


select 
 unnest (string_to_array(item_list, ', '))
from orders


SELECT
 unnest(
	  string_to_array(item_list, ', ')
 	 ) AS item,
 COUNT(*) AS num_orders
FROM
  orders
GROUP BY
  item
ORDER BY
  num_orders DESC;
  
  
  
  
  