----         o             
----         , ,-. ,-. ;-. 
----         | `-. | | | | 
----         | `-' `-' ' ' 
----        -'                                    
----  https://github.com/softwareNuggets
----    /PostgreSQL_shorts_resources/
----     vid_12_JSON_intro.sql

--drop table people
create temporary table people (
    amigo 			text,
    contact_info 	json
);


insert into people(amigo, contact_info)
values
('Jim Brown', 
 	'{"dob"   : "1990-10-06", 
 	  "phone" : "444-1234", 
 	  "email" : "jim@mail.com"}'
),
		
('Sue North', 
 	'{"dob"    : "1987-12-22", 
 	  "phone"  : "444-5678", 
 	  "email"  : "sue@mail.com"}'
),
		
('Tom Black', 
 	'{"dob"   : "1972-06-17", 
 	  "phone" : "444-9510", 
 	  "email" : "tom@mail.com"}'
);







--people(amigo, contact_info)

--The result of contact_info->'phone' 
--will be the value of the "phone" key 
--in the contact_info JSON object.
select 
	amigo,
	contact_info->'phone' as phone
from people




--this is an error, you have to put
--single quotes around the 'key'
select 
	amigo,
	contact_info->phone as phone
from people



select 
  amigo,
  contact_info->>'dob' as born_on
from people


select 
 amigo,
(contact_info->>'dob')::date as born_on
from people

