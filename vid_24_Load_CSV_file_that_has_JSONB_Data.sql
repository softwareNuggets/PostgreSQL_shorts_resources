--Source code: GitHub
--https://github.com/softwareNuggets/PostgreSQL_shorts_resources\
--vid_24_Load_CSV_file_that_hash_JSONB_Data

--create a file called: 'C:\YOUTUBE\postgreSQL\shorts\sample_data.csv
--copy from lines 7 to 19 into that file
id,jsondata
1,"{""zipcode"": ""12345"", 
	""university_name"": ""University of Example"", 
	""number_of_students"": 5000, 
	""number_of_facilities"": 100}"
2,"{""zipcode"": ""23456"", 
	""university_name"": ""Another University"", 
	""number_of_students"": 8000, 
	""number_of_facilities"": 120}"
3,"{""zipcode"": ""34567"", 
	""university_name"": ""Yet Another University"", 
	""number_of_students"": 6000, 
	""number_of_facilities"": 80}"


--drop table sample_json_table
CREATE TEMPORARY TABLE sample_json_table (
    id 			INTEGER PRIMARY KEY,
    jsondata 	JSONB
); 

--important LAST ROW in file MUST NOT BE EMPTY
COPY sample_json_table (id, jsondata) 
    FROM 'C:\YOUTUBE\postgreSQL\shorts\sample_data.csv'
    WITH CSV HEADER;


select *
from sample_json_table