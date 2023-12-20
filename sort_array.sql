/*
	how to sort an array datatype object
	a) create a table with using an array datatype 
	b) populate record with appropriate data
	c) write a function that will sort the array, high to low, or low to high
	
	https://github.com/softwareNuggets/PostgreSQL_shorts_resources
	sort_array.sql
*/
--drop table TargetPractice
CREATE temporary TABLE TargetPractice (
	player_id 		serial 		PRIMARY KEY,
    player_name 	text ,
    ring_hit 		INTEGER[]
);

INSERT INTO TargetPractice (player_name,ring_hit) VALUES
    ('Jason',	ARRAY[3, 3, 4, 2, 4]),
    ('Bruce',	ARRAY[5, 4, 5, 5, 3]),
	('Lee',		ARRAY[7, 4, 6, 4, 5]),
	('Baron',	ARRAY[4, 5, 8, 8, 3]),
	('Tom',		ARRAY[9, 8, 7, 7, 9]);


--drop type sort_direction_ENUM
CREATE TYPE sort_direction_ENUM AS ENUM ('ASC', 'DESC');

--drop function sort_array
CREATE OR REPLACE FUNCTION sort_array(
    arr 		INTEGER[],
    direction 	sort_direction_ENUM
) RETURNS INTEGER[] 
AS 
$$
DECLARE
    sorted_array INTEGER[];
BEGIN
    IF direction 		= 'ASC' THEN
        sorted_array := ARRAY(SELECT unnest(arr) as points ORDER BY points);
		
    ELSIF direction 	= 'DESC' THEN
        sorted_array := ARRAY(SELECT unnest(arr) as points ORDER BY points DESC);
		
    ELSE
        RAISE EXCEPTION 'Invalid sorting direction: %', direction;
    END IF;

    RETURN sorted_array;
END;
$$ LANGUAGE plpgsql;


-- Sort the practice shots
SELECT 
	player_id,
	player_name, 
	ring_hit as original_order,
	sort_array(ring_hit, 'ASC') AS low_to_high,
	sort_array(ring_hit, 'DESC') AS high_to_low
FROM TargetPractice;



