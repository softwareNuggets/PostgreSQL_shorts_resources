--1 create table
--2 insert data
--3 exec the SQL "elements only in one of the arrays"

--source on my github account
--https://github.com/softwareNuggets
--       /PostgreSQL_shorts_resources
-- 	     /vid_27_unique_elements.sql

--drop table two_arrays
CREATE temporary TABLE two_arrays (
  id int PRIMARY KEY,
  array1 INTEGER[],
  array2 INTEGER[]
);

-- Insert sample data
INSERT INTO two_arrays (id,array1, array2) VALUES
  (1,'{1, 2, 3}', '{2, 3, 4}'),
  (2,'{4, 5, 6}', '{6, 7, 8}'),
  (3,'{7, 8, 9}', '{9, 10, 11}');

--goal

id	unique elements
1	{1,4}
2	{4,5,7,8}
3	{7,8,10,11}

select *
from two_arrays

--elements only in one of the arrays
WITH combined_elements AS (
  SELECT id, unnest(array1) AS element
  FROM two_arrays
  UNION ALL
  SELECT id, unnest(array2) AS element
  FROM two_arrays
),
element_counts AS (
  SELECT id, element, COUNT(*) AS count
  FROM combined_elements
  GROUP BY id, element
)
SELECT id, array_agg(DISTINCT element) AS unmatched_elements
FROM element_counts
WHERE count = 1
GROUP BY id;

	  

-- Generate the solution query
SELECT id, array_agg(DISTINCT matched_element) AS matched_elements
FROM (
  SELECT id, unnest(array1) AS matched_element, array2
  FROM two_arrays
  WHERE id IN (
    SELECT id
    FROM two_arrays
    WHERE EXISTS (
      SELECT 1
      FROM unnest(array1) AS array1_elem
      WHERE array1_elem = ANY (array2)
    )
  )
) subquery
WHERE matched_element = ANY (array2)
GROUP BY id;



WITH combined_elements AS (
  SELECT id, unnest(array1) AS element
  FROM two_arrays
  UNION ALL
  SELECT id, unnest(array2) AS element
  FROM two_arrays
),
element_counts AS (
  SELECT id, element, COUNT(*) AS count
  FROM combined_elements
  GROUP BY id, element
)
SELECT id, array_agg(DISTINCT element) AS unmatched_elements
FROM element_counts
WHERE count = 1
GROUP BY id;

