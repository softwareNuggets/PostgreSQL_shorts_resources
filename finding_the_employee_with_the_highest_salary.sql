--GitHub
--https://github.com/softwareNuggets/
--				/PostgreSQL_shorts_resources
--				/finding_the_employee_with_the_highest_salary.sql
--
--solves the problem of finding the employee with the highest salary in each department

--drop table employees
--drop table departments

CREATE TEMPORARY TABLE departments (
    department_id 	integer PRIMARY KEY,
    department_name varchar(30)
);


INSERT INTO departments (department_id,department_name)
VALUES
    (1,	'HR'),
    (2,	'Finance'),
    (3,	'IT'),
	(4, 'Sales');
	
CREATE TEMPORARY TABLE employees (
    employee_id 	integer PRIMARY KEY,
    department_id 	integer REFERENCES departments(department_id),
    employee_name 	varchar(30),
    salary 			numeric
);

INSERT INTO employees (employee_id, department_id, employee_name, salary)
VALUES
    (1, 1, 'Mike', 		50000),
    (2, 1, 'Nicole', 	55000),
	(3, 1, 'Baron',     55000),
    (4, 2, 'Sarah', 	60000),
    (5, 2, 'David', 	58000),
    (6, 3, 'Cal', 		65000);


-- example one
--
SELECT
    d.department_id,
    d.department_name,
    e.employee_name,
    e.salary
FROM departments d
LEFT JOIN employees e 
	ON (d.department_id = e.department_id)
WHERE e.salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = d.department_id
);




SELECT 	d.department_id, 
		d.department_name, 
		e.employee_name, 
		e.salary
FROM departments d
LEFT JOIN LATERAL (
    SELECT e.employee_name, e.salary
    FROM employees e
    WHERE e.department_id = d.department_id
    ORDER BY e.salary DESC
    LIMIT 1
) e ON true;




WITH RankedEmployees AS (
    SELECT
        d.department_id,
        d.department_name,
        e.employee_name,
        e.salary,
        ROW_NUMBER() OVER (PARTITION BY d.department_id ORDER BY e.salary DESC) AS rank_num
    FROM departments d
    LEFT JOIN employees e ON d.department_id = e.department_id
)
SELECT
    department_id,
    department_name,
    employee_name,
    salary
FROM RankedEmployees
WHERE rank_num = 1;


SELECT
    d.department_id,
    d.department_name,
    e.employee_name,
    e.salary
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = d.department_id
);




