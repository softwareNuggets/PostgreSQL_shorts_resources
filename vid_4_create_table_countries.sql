--drop table countries

CREATE TABLE countries (
  country_name VARCHAR(60),
  country_code VARCHAR(3),
  --colors TEXT[]
  colors text ARRAY
);



INSERT INTO countries (country_name, country_code, colors)
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


INSERT INTO countries (country_name, country_code, colors)
VALUES
  ('Argentina', 'ARG', '{"blue", "white", "blue"}'),
  ('Bolivia', 'BOL', '{"red", "yellow", "green"}'),
  ('Brazil', 'BRA', '{"green", "yellow", "blue"}'),
  ('Chile', 'CHL', '{"red", "white", "blue"}'),
  ('Colombia', 'COL', '{"yellow", "blue", "red"}'),
  ('Ecuador', 'ECU', '{"yellow", "blue", "red"}'),
  ('Guyana', 'GUY', '{"green", "yellow", "blue"}'),
  ('Paraguay', 'PRY', '{"red", "white", "blue"}'),
  ('Peru', 'PER', '{"red", "white"}'),
  ('Suriname', 'SUR', '{"red", "white", "green"}'),
  ('Uruguay', 'URY', '{"blue", "white", "blue"}'),
  ('Venezuela', 'VEN', '{"yellow", "blue", "red"}');