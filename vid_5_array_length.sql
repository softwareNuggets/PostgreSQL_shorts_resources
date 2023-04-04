
--signature
  array_length(array, dimension)
  
  
  
 --one dimensional array
 select array_length(
  		ARRAY [ 'red', 
			    'white',
			    'blue']
 		,1);





select 	country_name, 
		colors,
		array_length(colors,1)
from countries	
where country_code = 'USA'




select 	country_name, 
		colors,
		array_length(colors,1)
from countries
where array_length(colors,1) % 2 = 0
order by 3 desc







