--DROP TABLE TEMP_employee_m

CREATE TEMPORARY TABLE TEMP_employee_m (
    employee 	VARCHAR(50),
    department 	VARCHAR(50)
);

INSERT INTO TEMP_employee_m (employee, department)
VALUES
    ('Sandry', 'publicity'),
    ('Baron', 'publicity'),
    ('Charles', 'publicity'),
    ('Connie', 'food'),
    ('Nicole', 'food'),
    ('Laura', 'food'),
    ('Pete', 'music'),
    ('Jerry', 'music'),
    ('Isaac', 'music'),
    ('Jenny', 'security'),
    ('Kevin', 'security'),
    ('Allan', 'security'),
    ('Megan', 'tickets'),
    ('Nancy', 'tickets'),
    ('Thomas', 'tickets');
	

	
SELECT department, 
       array_agg(employee) AS emp
FROM TEMP_employee_m
GROUP BY department;	
