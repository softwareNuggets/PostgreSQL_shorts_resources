
--What is the RANK() function?
---The RANK() function is like giving medals in a race.
---It gives each person (or row of data) a position based on their score: 1st, 2nd, or 3rd place, etc

--Why do we use RANK()?
---We use it when we want to see who did the best, second-best, third-best, and so on.
---It helps us know who is at the top 
---                 who is in the middle 
---                 who is at the bottom 
---based on some numbers/date (like scores, sales, dates or times).

--When should you use RANK()?
---Use RANK() when you want to compare things and order them
---by how big or small their values are. 
----For example:
------Who {sold} the most {books}?     replace sold=found, bought, ate, sold, borrowed, drank, raised, ran, travelled
------  								replace books=cars, CD's, hotdogs, money, gold, laps, miles

--How do you use Rank()
---You pick the thing you want to rank (like {sales}).
---Use the RANK() function and tell it how to order the data (biggest to smallest or smallest to biggest).
---It gives each person or row a number based on their position.






--drop table employee_sales
CREATE TABLE employee_sales 
(
    employee_id 	INT,
    employee_name 	VARCHAR(50),
    department 		VARCHAR(30),
    sales_month 	DATE,
    sales_amount 	DECIMAL(10, 2)
);


INSERT INTO employee_sales (employee_id, employee_name, department, sales_month, sales_amount) VALUES
(1, 'Ann', 'Electronics', '2024-01-01', 1500.00),
(1, 'Ann', 'Electronics', '2024-02-01', 2000.00),
(1, 'Ann', 'Electronics', '2024-03-01', 1800.00),
(2, 'Baron', 'Electronics', '2024-01-01', 2400.00),
(2, 'Baron', 'Electronics', '2024-02-01', 2500.00),
(2, 'Baron', 'Electronics', '2024-03-01', 3000.00),
(3, 'Charles', 'Electronics', '2024-01-01', 1300.00),
(3, 'Charles', 'Electronics', '2024-02-01', 1000.00),
(3, 'Charles', 'Electronics', '2024-03-01', 1700.00),
(4, 'David', 'Furniture', '2024-01-01', 900.00),
(4, 'David', 'Furniture', '2024-02-01', 1100.00),
(4, 'David', 'Furniture', '2024-03-01', 1200.00),
(5, 'Eve', 'Furniture', '2024-01-01', 3000.00),
(5, 'Eve', 'Furniture', '2024-02-01', 1700.00),
(5, 'Eve', 'Furniture', '2024-03-01', 1600.00),
(6, 'Frank', 'Furniture', '2024-01-01', 1900.00),
(6, 'Frank', 'Furniture', '2024-02-01', 2400.00),
(6, 'Frank', 'Furniture', '2024-03-01', 2200.00),
(7, 'George', 'Clothing', '2024-01-01', 3000.00),
(7, 'George', 'Clothing', '2024-02-01', 3200.00),
(7, 'George', 'Clothing', '2024-03-01', 3300.00),
(8, 'Hank', 'Clothing', '2024-01-01', 2800.00),
(8, 'Hank', 'Clothing', '2024-02-01', 2900.00),
(8, 'Hank', 'Clothing', '2024-03-01', 3100.00),
(9, 'Igor', 'Clothing', '2024-01-01', 2400.00),
(9, 'Igor', 'Clothing', '2024-02-01', 2600.00),
(9, 'Igor', 'Clothing', '2024-03-01', 2700.00),
(10, 'Jane', 'Clothing', '2024-01-01', 2500.00),
(10, 'Jane', 'Clothing', '2024-02-01', 2400.00),
(10, 'Jane', 'Clothing', '2024-03-01', 2600.00);


SELECT 
    employee_name, 
    department, 
    sales_amount, 
    DENSE_RANK() OVER (order by sales_amount desc) as sales_rank
FROM employee_sales;

--when you see "OVER", say to yourself, "what is the order of the data I want to compare"
--in this example, I want to rank employees by the sales_amount, when sorted in descending order
-- desc = high to low, asc = low to high




SELECT 
    employee_name, 
    department, 
    SUM(sales_amount) AS total_sales, 
    DENSE_RANK() OVER (ORDER BY SUM(sales_amount) DESC) AS sales_rank
FROM employee_sales
GROUP BY employee_name, department;







--PARTITION BY = It doesn’t reduce the rows. 
--PARTITION BY is like creating separate contests within a big competition.
--one fact to remember the aggretate function happens after the grouping

SELECT 
    employee_name,
    department, 
    SUM(sales_amount) AS total_sales,
    DENSE_RANK() OVER (
					PARTITION BY department 
					ORDER BY SUM(sales_amount) DESC
				) 
				AS rank_in_department
FROM employee_sales
GROUP BY employee_name, department

SELECT 
    employee_name,
    department, 
    SUM(sales_amount) AS total_sales,
    RANK() 			OVER (department_window) 	AS rank_in_department,
    DENSE_RANK() 	OVER (department_window) 	AS dense_rank_in_department          
FROM employee_sales
GROUP BY employee_name, department
window department_window as (PARTITION BY department ORDER BY SUM(sales_amount) DESC)






window _name_ as (_clause_)


SELECT 
    employee_name,
    department, 
    SUM(sales_amount) AS total_sales,
    RANK() OVER department_window AS rank_in_department
FROM employee_sales
GROUP BY employee_name, department
WINDOW department_window as (PARTITION BY department ORDER BY SUM(sales_amount) DESC)

















SELECT 
    employee_name,
    department, 
    SUM(sales_amount) AS total_sales,
    RANK() OVER dep_window AS rank_in_department
FROM employee_sales
GROUP BY employee_name, department
WINDOW dep_window as (PARTITION BY department ORDER BY SUM(sales_amount) DESC)








