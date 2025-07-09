--programmer:   scott johnson
--YT:      		https://youtube.com/softwareNuggets
--github:  		https://github.com/softwareNuggets/
 					PostgreSQL_shorts_resources/blob/
					 main/sorting_issue.sql

--let's start over
-- Check if table exists
SELECT CASE 
    WHEN EXISTS (
        SELECT 1 FROM information_schema.tables 
        WHERE table_schema = 'YOUR_SCHEMA' 
        AND table_name = 'SAMPLE_DATA_NUGGET'
    )
    THEN 'WARNING: Table SAMPLE_DATA_NUGGET already exists! Do not proceed - this is a production table!'
    ELSE 'Safe to proceed - table does not exist'
END as safety_check;


drop table sample_data_nugget;

create table sample_data_nugget
(
	whole_saler_id varchar(30)
);

INSERT INTO sample_data_nugget (whole_saler_id) VALUES
('51760'),('999935'),('204496'),('8824'),
('50459'),('999934'),('2541'),('11779'),
('100010041'),('51466'),('1379'),('52039'),
('999932'),('3889'),('205097'),('2462');

select whole_saler_id
from sample_data_nugget
order by whole_saler_id


select distinct(whole_saler_id::integer) 
from sample_data_nugget   
order by whole_saler_id

select distinct(cast(whole_saler_id as integer)) 
from sample_data_nugget    
order by 1

SELECT DISTINCT CAST(whole_saler_id AS INTEGER)
FROM sample_data_nugget
ORDER BY CAST(whole_saler_id AS INTEGER);



