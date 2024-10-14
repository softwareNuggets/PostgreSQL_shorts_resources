/*
	Software Nuggets
	Youtube:   https://www.youtube.com/softwareNuggets
	GitHub:    https://github.com/softwareNuggets/PostgreSQL_shorts_resources
	
	how to use the MERGE command
	how to update production database
	and insert new records
	using one command := MERGE
*/
-- start over commands
--drop table main_table;
--drop table transaction_orders;


--this is a production database table
create table main_table (
 order_id 		int 	not null primary key,
 has_shipped 	BOOLEAN not null,
 shipped_date 	date 	null
)

insert into main_table(order_id,  has_shipped)
values
(1,FALSE),
(2,FALSE),
(3,FALSE),
(4,FALSE),
(5,FALSE),
(6,FALSE),
(7,FALSE);

--this table contains new orders, 
--as well as updated orders(orders were shipped)
create table transaction_orders
(
 order_id 		int not null,
 has_shipped 	boolean not null,
 date_shipped 	date null
)

insert into transaction_orders(order_id, has_shipped,date_shipped)
values
(1,TRUE,'2024-10-06'),
(3,TRUE,'2024-10-06'),
(8,FALSE,null);


select * from main_table order by order_id
select * from transaction_orders;

merge into main_table as M
using transaction_orders as T
 	on (M.order_id = T.order_id )
when matched then
 	update SET  
	 	has_shipped  	=  	T.has_shipped,
 		shipped_date 	= 	T.date_shipped
when not matched by target then
 insert (order_id, has_shipped) 
 values (T.order_id, T.has_shipped);


select * from main_table order by order_id


/*  EXAMPLE 2 */

-- start over commands
--drop table main_table;
--drop table transaction_orders;


--this is a production database table
create table main_table (
 order_id 		int 	not null primary key,
 has_shipped 	BOOLEAN not null,
 shipped_date 	date 	null
);

insert into main_table(order_id,  has_shipped)
values
(1,FALSE),
(2,FALSE),
(3,FALSE),
(4,FALSE),
(5,FALSE),
(6,FALSE),
(7,FALSE);

--this table contains new orders, 
--as well as updated orders(orders were shipped)
create table transaction_orders
(
 order_id 	int not null,
 has_shipped 	boolean not null,
 date_shipped 	date null
)

insert into transaction_orders(order_id, has_shipped,date_shipped)
values
(1,TRUE,'2024-10-06'),
(3,TRUE,'2024-10-06'),
(8,FALSE,null);


select * from main_table order by order_id
select * from transaction_orders;

merge into main_table as M
using transaction_orders as T
 	on (M.order_id = T.order_id )
when matched then
 	update SET  
	 	has_shipped  	=  	T.has_shipped,
 		shipped_date 	= 	T.date_shipped
when not matched by target then
 insert (order_id, has_shipped) 
 values (T.order_id, T.has_shipped)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;


select * from main_table order by order_id

