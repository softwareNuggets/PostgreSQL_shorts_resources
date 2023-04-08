----         o             
----         , ,-. ,-. ;-. 
----         | `-. | | | | 
----         | `-' `-' ' ' 
----        -'                                    
----  https://github.com/softwareNuggets
----    /PostgreSQL_shorts_resources/
----  vid_14_JSON_json_build_object.sql


--drop table usa_states
CREATE Temporary TABLE usa_states (
    state_name VARCHAR(50) PRIMARY KEY,
    capital    VARCHAR(50),
    population NUMERIC
);

INSERT INTO usa_states 
	(state_name, capital, population) 
VALUES
('California', 'Sacramento', 39538223),
('Texas', 'Austin', 29145505),
('Florida', 'Tallahassee', 21538187),
('New York', 'Albany', 20201249),
('Pennsylvania', 'Harrisburg', 13002700),
('Illinois', 'Springfield', 12812508),
('Ohio', 'Columbus', 11799448),
('Georgia', 'Atlanta', 10711908),
('North Carolina', 'Raleigh', 10687754),
('Michigan', 'Lansing', 10084442),
('New Jersey', 'Trenton', 9288994),
('Virginia', 'Richmond', 8626207),
('Washington', 'Olympia', 7693612),
('Arizona', 'Phoenix', 7278717),
('Massachusetts', 'Boston', 7029917);



select json_build_object (
			'state_name',state_name,
			'capital', capital,
			'population',population
		)
from usa_states


