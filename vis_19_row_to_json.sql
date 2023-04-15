--json is data format, which is
--represented as a collection of
-- key-value pairs
-- "key": value


--automatically generates "key"
-- fn  := 1,2,3...

select row_to_json(row(1,2,3))


select row_to_json(row(1,2,3), true)


--video 19, i will discuss 
--row_to_json, composite type  (1,2,3)




select row(1,2,3)


create type ntypes as
( 
  f1 integer,
  f2 integer,
  f3 integer
);

CREATE temporary table row_example 
(
    id int primary key,
    num ntypes
);

INSERT INTO row_example (id,num) 
VALUES 
(1, '(1,2,3)'::ntypes),
(2, '(2,4,6)'::ntypes);


select *
from row_example


select id,row_to_json(num)
from row_example
