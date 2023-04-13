----         o             
----         , ,-. ,-. ;-. 
----         | `-. | | | | 
----         | `-' `-' ' ' 
----        -'    postgresql

----  https://github.com/softwareNuggets
----    /PostgreSQL_shorts_resources/
----       vid_17_json_typeof.sql


-- json_typeof
-- determine the data type
-- of a JSON value

-- The possible data types that can be
-- returned are:
--null, boolean, numeric,
--string, array, and object.


create temporary table cart (
	order_id 	int primary key,
	customer	varchar(50),
	items		JSON
);

INSERT INTO cart
			(order_id, customer, items)
values
(1, 'Alice',
	'{"name":"Shirt", "price": 25}'),
(2, 'Bob',
	'{"name":"Shirt", "price": 33}');
	

Select
	items ->> 'name',
	json_typeof(items -> 'name'),
	items ->> 'price',
	json_typeof(items -> 'price')
from cart;


SELECT
	json_typeof(elm -> 'name'),
	json_typeof(elm -> 'age'),
	json_typeof(elm -> 'has_job'),
	json_typeof(elm -> 'hobbies'),
	json_typeof(elm -> 'misc')
FROM (
	SELECT json_array_elements
	  ('[
	 	{"name": "Alice",
	 	"age": 30,
	 	"has_job": true,
	 	"hobbies": ["sailing","running"],
	 	"misc": null
	    },
		{"name": "Bob",
	 	"age": 65,
	 	"has_job": false,
	 	"hobbies": ["reading","programming"],
	 	"misc": "not null here"
	    }
	 ]') AS elm
) as elements;

