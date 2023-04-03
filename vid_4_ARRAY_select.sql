select *
from countries

select 	country_name,
		colors,
		colors[1]
from countries

select 	country_name,
		colors,
		cardinality(colors)
from countries

select country_name,
		colors,
		colors[cardinality(colors)]
from countries

select country_name,
		colors
from countries
where cardinality(colors) = 3


select country_name,
		colors
from countries
where cardinality(colors) = 3
and colors[cardinality(colors)] = 'red'

