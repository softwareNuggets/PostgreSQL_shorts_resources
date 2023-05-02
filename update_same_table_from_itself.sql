select version()

--drop table temp;
create temporary table temp
(
	customer_id int,
	contact_id int,
	type_id int,
	special_code varchar(10)
)

insert into temp
values
(1,1,1,null),
(1,2,2,null),
(1,3,3,'Code43'),
(2,11,1,null),
(2,12,2,null),
(2,23,3,'Code54')


select *
from temp
order by customer_id, contact_id

begin;
update temp as t1
set special_code = t2.special_code
from temp t2
where t1.customer_id = t2.customer_id
and t1.type_id = 2
and t2.type_id = 3
--rollback
--commit







