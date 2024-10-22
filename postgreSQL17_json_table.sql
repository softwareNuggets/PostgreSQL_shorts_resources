-- json_table function
-- is a new feature 
-- you must upgrade to PostgreSQL 17 to take advantage of this new feature.

--json_table 
--          work with JSON data more effectively
--          transforming it into a tabular format 
--          makes it easier to query

-- GitHub: https://github.com/softwareNuggets/PostgreSQL_shorts_resources
--    json_table.sql

-- YT: SoftwareNuggets




-- First, let's create a table to store our JSON data
--drop table dealership_inventory
CREATE TABLE dealership_inventory (
    id SERIAL PRIMARY KEY,
    inventory_data JSONB
);




-- Insert a sample JSON object into the table
INSERT INTO dealership_inventory (inventory_data) VALUES (
    '{
        "dealership": "UsedCars",
        "cars": [
            {
                "make": "Toyota",
                "model": "Camry",
                "year": 2022,
                "price": 25000,
                "features": ["Bluetooth", "Backup Camera"]
            },
            {
                "make": "Honda",
                "model": "Civic",
                "year": 2023,
                "price": 22000,
                "features": ["Apple CarPlay", "Lane Assist"]
            },
            {
                "make": "Ford",
                "model": "F-150",
                "year": 2021,
                "price": 35000,
                "features": ["Tow Package", "4WD"]
            }
        ]
    }'
);


--step 3:  Select all the data
select * from dealership_inventory








--step 4:  using the json_table function
SELECT 
    jt.*
FROM 
    dealership_inventory,
    json_table(inventory_data->'cars', 
               '$[*]' 
			   COLUMNS 
			   (
                   make 		TEXT 	PATH '$.make',
                   model 		TEXT	PATH '$.model',
                   make_year 	INT 	PATH '$.year',
                   price 		DECIMAL PATH '$.price'
               )
    ) AS jt
ORDER BY 
    jt.price DESC;



--step 5: selecting specific columns
SELECT 
    cars.make,
    cars.model,
    cars.make_year,
    cars.price
FROM 
    dealership_inventory,
    json_table(inventory_data->'cars', 
               '$[*]' COLUMNS (
                   make 	TEXT 		PATH '$.make',
                   model 	TEXT 		PATH '$.model',
                   make_year INT 		PATH '$.year',
                   price 	DECIMAL 	PATH '$.price'
               )
    ) AS cars
ORDER BY 
    cars.price DESC;

	


	




-- Now, let's use json_table to query this data
SELECT 
    jt.*,
    f.feature
FROM 
    dealership_inventory,
    json_table(inventory_data->'cars', 
               '$[*]' COLUMNS (
                   make TEXT PATH '$.make',
                   model TEXT PATH '$.model',
                   year INT PATH '$.year',
                   price DECIMAL PATH '$.price',
                   features JSON PATH '$.features'
               )
    ) AS jt
CROSS JOIN LATERAL json_array_elements_text(jt.features) AS f(feature)
WHERE 
    jt.price > 1000 AND f.feature LIKE '%Play';