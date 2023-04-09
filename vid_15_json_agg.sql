----         o             
----         , ,-. ,-. ;-. 
----         | `-. | | | | 
----         | `-' `-' ' ' 
----        -'    postgresql

----  https://github.com/softwareNuggets
----    /PostgreSQL_shorts_resources/
----        vid_15_json_agg.sql


-- json_agg
-- aggregates record values as JSON



--drop table employees
CREATE temporary TABLE employees (
  emp_id 			INTEGER PRIMARY KEY,
  emp_name 			VARCHAR(50),
  department 		VARCHAR(50)
);

INSERT INTO employees 
		(emp_id, emp_name, department) 
VALUES 
(1, 'Alice', 	'HR'),
(2, 'Bob', 		'HR'),
(3, 'Charlie', 	'HR'),
(4, 'David', 	'IT'),
(5, 'Eve', 		'IT'),
(6, 'Frank', 	'IT');
  


select department,
		count(*) as numEmployees
from employees
group by department;


--an aggregate function is a function 
--that operates on a group of values and
--returns a single value as the result.

SELECT 	
    department, 
	json_agg(emp_name) AS employee_names
FROM employees
GROUP BY department;



