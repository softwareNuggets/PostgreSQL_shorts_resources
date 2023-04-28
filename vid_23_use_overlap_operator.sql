--https://github.com/softwareNuggets/PostgreSQL_shorts_resources
--vid_23_use_overlap_operator.sql

-- overlap_operator = &&

--drop table countries
CREATE TEMPORARY TABLE loc_country_m (
  country_name VARCHAR(60),
  country_code VARCHAR(3),
  colors text ARRAY
);

INSERT INTO loc_country_m (country_name, country_code, colors)
VALUES
  ('Afghanistan', 'AFG', ARRAY['blue', 'white']),
  ('Australia', 'AUS', ARRAY['navy', 'white']),
  ('Brazil', 'BRA', ARRAY['green', 'yellow']),
  ('Canada', 'CAN', ARRAY['red', 'white']),
  ('China', 'CHN', ARRAY['red', 'gold']),
  ('Denmark', 'DNK', ARRAY['red', 'white']),
  ('Egypt', 'EGY', ARRAY['black', 'white']),
  ('France', 'FRA', ARRAY['blue', 'white', 'red']),
  ('Germany', 'DEU', ARRAY['black', 'red', 'gold']),
  ('India', 'IND', ARRAY['orange', 'white', 'green']),
  ('Italy', 'ITA', ARRAY['green', 'white', 'red']),
  ('Japan', 'JPN', ARRAY['white', 'red']),
  ('Mexico', 'MEX', ARRAY['green', 'white', 'red']),
  ('Nigeria', 'NGA', ARRAY['green', 'white', 'green']),
  ('Russia', 'RUS', ARRAY['white', 'blue', 'red']),
  ('South Africa', 'ZAF', ARRAY['red', 'white', 'green', 'black']),
  ('Spain', 'ESP', ARRAY['red', 'yellow']),
  ('Sweden', 'SWE', ARRAY['blue', 'yellow']),
  ('United Kingdom', 'GBR', ARRAY['blue', 'white', 'red']),
  ('United States', 'USA', ARRAY['red', 'white', 'blue']);

select *
from loc_country_m

--use overlap_operator
SELECT country_name, country_code, colors 
FROM loc_country_m 
WHERE colors && '{"black"}'

--use overlap_operator
SELECT country_name, country_code, colors 
FROM loc_country_m 
WHERE colors && '{"black","blue"}'

--use overlap_operator
select colors
FROM loc_country_m  
where array[colors[1]] && '{"blue","red"}'








select ARRAY[1,4,3] && ARRAY[1,6]




