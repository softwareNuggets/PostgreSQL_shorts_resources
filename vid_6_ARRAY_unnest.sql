select *
from countries
where country_code  = 'USA'

--let's transform an array
--into a set of rows

select 
	country_name,
	unnest(colors)
from countries
where country_code  = 'USA'


select color, count(*) as num_colors
from (
		select unnest(colors) as color
		from countries
	 ) as all_colors
group by color
order by num_colors desc, 1



select 	
		unnest(colors), 
		count(*) use_color
from countries
group by unnest(colors)
order by 2 desc, 1