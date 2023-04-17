----         o             
----         , ,-. ,-. ;-. 
----         | `-. | | | | 
----         | `-' `-' ' ' 
----        -'    postgresql

----  https://github.com/softwareNuggets
----    /PostgreSQL_shorts_resources/
----   vid_20_build_json_from_tables.sql

--             row_from_json

--drop table territory_group
--drop table territories
create temporary table territory_group
(
	group_id int not null,
	group_name varchar(60),
	primary key (group_id)
);

create temporary table territories
(
	group_id 		int,
	territory_id 	int,
	territory_name 	varchar(60),
	
	primary key (group_id, territory_id),
	
	constraint fk_territory_group 
	   foreign key(group_id)
	   references territory_group(group_id)
)




insert into territory_group
			(group_id, group_name)
values
(1,'North')	




insert into territories
values
(1, 1,'North Dakota Territory'),
(1, 2,'South Dakota Territory')





select row_to_json(row,'true')
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














