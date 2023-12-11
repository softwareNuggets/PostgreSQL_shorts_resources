/*
	software nuggets
	
	## row_to_json ##
	
	https://github.com/softwareNuggets
		    /PostgreSQL_shorts_resources/
			row_to_json.sql	
*/


--drop table territories
--drop table territory_group


create temporary table 	territory_group
(
	group_id 	int 			not null,
	group_name 	varchar(60)		not null,
	primary key (group_id)
);

create temporary table 	territories
(
	group_id 		int			not null,
	territory_id 	int			not null,
	territory_name 	varchar(60)	not null,
	
	primary key (group_id, territory_id),
	
	constraint fk_territory_group 
	   foreign key(group_id)
	   references territory_group(group_id)
)




insert into territory_group
			(group_id, group_name)
values
(1,'North'),
(2, 'South'),
(3, 'East'),
(4, 'West')


insert into territories
values
(1, 1,'North Dakota Territory'),
(1, 2,'South Dakota Territory'),
(2, 3, 'Texas Territory'),
(3, 1, 'Virginia Territory'),
(3, 2, 'Maryland Territory'),
(3, 3, 'North Carolina Territory'),
(3, 4, 'South Territory')


--(1,'North'),
--(2, 'South'),
--(3, 'East'),
--(4, 'West')

--convert all rows from territory_group to JSON
select row_to_json(tg) as json_results
from territory_group tg


--convert all rows from a sub-query to JSON
select row_to_json(c)
from 
	(
		select group_id, group_name
		from territory_group
	) as c

--convert a single row from a sub-query to JSON
select row_to_json(c)
from 
	(
		select group_id, group_name
		from territory_group
		where group_id = 1
	) as c


--convert all rows from a sub-query with table join to JSON
select row_to_json(c)
from 
	(
		select tg.group_id, tg.group_name,t.territory_name
		from territory_group tg
			left join territories t
				on(t.group_id = tg.group_id)
	) as c

 
 --select one row, format as json
SELECT row_to_json(t) AS territory
FROM territories t
WHERE t.group_id = 1 
AND t.territory_id = 1;


--format as json for all fields in territory_group
SELECT row_to_json(tg) AS territory_group
FROM territory_group tg;

--create an array of json objects
SELECT json_agg(row_to_json(tg)) AS json_result
FROM territory_group tg;


SELECT 
	json_build_object(
   		'group_id', tg.group_id,
   		'group_name', tg.group_name,
   		'territories', json_agg(row_to_json(t))
) AS json_result
FROM territory_group tg
	LEFT JOIN territories t 
		ON (tg.group_id = t.group_id)
WHERE tg.group_id = 1
GROUP BY tg.group_id, tg.group_name;


--aggregating JSON from multiple rows into a nested JSON structure
select row_to_json(row)
from (
		SELECT 
			tg.group_id,
			json_agg(
				json_build_object(
				 'territory_id', t.territory_id,
				 'territory_name', t.territory_name
				)
			) AS territories
		FROM territory_group tg
			JOIN territories t 
				 ON (tg.group_id = t.group_id)
		GROUP BY tg.group_id
) row;