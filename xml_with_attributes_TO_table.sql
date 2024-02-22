/*
select version()
--drop table toll_data
--truncate table toll_data

CREATE Temporary TABLE  toll_data (
    toll_id 				SERIAL 			PRIMARY KEY,
    vehicle_license_plate 	VARCHAR(20) 	NOT NULL,
	state_plate				VARCHAR(2)  	NOT NULL,
	expiration_date			VARCHAR(7)  	NOT NULL,
    toll_booth_id 			INT 			NOT NULL,
	currency_type			VARCHAR(3)		NOT NULL,
	payment_rendered		VARCHAR(10) 	NOT NULL,
	device_serial			VARCHAR(14) 	NULL,
    toll_amount 			DECIMAL(10, 2) 	NOT NULL
)
*/


DO $$ 
DECLARE
	toll_id 				int;
	vehicle_license_plate 	varchar(6);
	state_plate				varchar(2);
	expiration_date   		varchar(7);
	toll_booth_id 			int;
	toll_amount 			decimal(10,2);
	currency_type			varchar(3);
	payment_rendered		varchar(10);
	device_serial			varchar(14);
	record 					XML;
	should_skip_record 		boolean;
	
	xml_data XML := '<toll_data_list>
						<toll_data>
							<toll_id>1</toll_id>
							<vehicle_license_plate state_plate="FL" 
													expiration_date="2024-06">ABC123</vehicle_license_plate>
							<toll_booth_id>101</toll_booth_id>
							<toll_amount currency_type="USD" payment_rendered="DEVICE" 
															device_serial="123-4567-89034">5.75</toll_amount>
						</toll_data>
						<toll_data>
							<toll_id>2</toll_id>
							<vehicle_license_plate state_plate="FL"  
													expiration_date="2024-06">XYZ789</vehicle_license_plate>
							<toll_booth_id>102</toll_booth_id>
							<toll_amount currency_type="USD" payment_rendered="Cash">8.50</toll_amount>
						</toll_data>
						<toll_data>
							<toll_id>3</toll_id>
							<vehicle_license_plate state_plate="TX"  
														expiration_date="2024-06">DEF456</vehicle_license_plate>
							<toll_booth_id>103</toll_booth_id>
							<toll_amount currency_type="USD" payment_rendered="DEVICE" 
														device_serial="123-4567-89034">3.25</toll_amount>
						</toll_data>
						<toll_data>
							<toll_id>4</toll_id>
							<vehicle_license_plate state_plate="FL"  
													expiration_date="2024-06">GHI789</vehicle_license_plate>
							<toll_booth_id>104</toll_booth_id>
							<toll_amount currency_type="USD" payment_rendered="DEVICE" 
															device_serial="123-4567-89034">6.00</toll_amount>
						</toll_data>
						<toll_data>
							<toll_id>5</toll_id>
							<vehicle_license_plate state_plate="NC"  
													expiration_date="2025-10">JKL012</vehicle_license_plate>
							<toll_booth_id>105</toll_booth_id>
							<toll_amount currency_type="USD" payment_rendered="Cash">4.75</toll_amount>
						</toll_data>
						<toll_data>
							<toll_id>6</toll_id>
							<vehicle_license_plate state_plate="FL"  expiration_date="2025-06">MNO345</vehicle_license_plate>
							<toll_booth_id>106</toll_booth_id>
							<toll_amount currency_type="USD" payment_rendered="Cash">2.50</toll_amount>
						</toll_data>
						<toll_data>
							<toll_id>7</toll_id>
							<vehicle_license_plate state_plate="FL"  expiration_date="2024-07">PQR678</vehicle_license_plate>
							<toll_booth_id>107</toll_booth_id>
							<toll_amount currency_type="USD" payment_rendered="Cash" device_serial="">7.25</toll_amount>
						</toll_data>
						<toll_data>
							<toll_id>8</toll_id>
							<vehicle_license_plate state_plate="FL"  
													expiration_date="2025-01">STU901</vehicle_license_plate>
							<toll_booth_id>108</toll_booth_id>
							<toll_amount currency_type="USD" payment_rendered="DEVICE" 
															device_serial="123-4567-89034">9.00</toll_amount>
						</toll_data>
						<toll_data>
							<toll_id>9</toll_id>
							<vehicle_license_plate state_plate="GA"  expiration_date="2024-04">VWX234</vehicle_license_plate>
							<toll_booth_id>109</toll_booth_id>
							<toll_amount currency_type="USD" payment_rendered="DEVICE" device_serial="">3.75</toll_amount>
						</toll_data>
						<toll_data>
							<toll_id>10</toll_id>
							<vehicle_license_plate state_plate="FL"  expiration_date="2024-12">YZA567</vehicle_license_plate>
							<toll_booth_id>110</toll_booth_id>
							<toll_amount currency_type="USD" payment_rendered="Cash">5.00</toll_amount>
						</toll_data>
					</toll_data_list>
					';
					
BEGIN
	-- xpath  = returns an array
	-- unnest = array to rows
	FOR record IN SELECT unnest(xpath('/toll_data_list/toll_data', xml_data)) LOOP	
	
		-- Reset variables for each iteration
		toll_id 				:= NULL;
		vehicle_license_plate 	:= NULL;
		state_plate 			:= NULL;
		expiration_date 		:= NULL;
		toll_booth_id 			:= NULL;
		toll_amount 			:= NULL;
		currency_type 			:= NULL;
		payment_rendered		:= NULL;
		device_serial 			:= NULL;
		
		should_skip_record 		:= FALSE;
		
		IF array_length(xpath('/toll_data/toll_id/text()', record), 1) IS NULL THEN
			RAISE NOTICE 'Skipping record because missing toll_id';
			should_skip_record := TRUE; 
		ELSE
			toll_id := (xpath('/toll_data/toll_id/text()', record))[1]::text::INT;
		END IF;
		
		IF array_length(xpath('/toll_data/vehicle_license_plate/text()', record), 1) IS NULL THEN
			RAISE NOTICE 'Skipping record because missing vehicle_license_plate';
			should_skip_record := TRUE;  
		ELSE
			 vehicle_license_plate := (xpath('/toll_data/vehicle_license_plate/text()', record))[1]::text::VARCHAR(20);
		END IF;	
		
		IF array_length(xpath('/toll_data/vehicle_license_plate/@state_plate', record), 1) IS NULL THEN
			RAISE NOTICE 'Skipping record because missing state_plate';
			should_skip_record := TRUE;  
		ELSE
			 state_plate := (xpath('/toll_data/vehicle_license_plate/@state_plate', record))[1]::text::VARCHAR(2);
		END IF;
		
		IF array_length(xpath('/toll_data/vehicle_license_plate/@expiration_date', record), 1) IS NULL THEN
			RAISE NOTICE 'Skipping record because missing expiration_date';
			should_skip_record := TRUE;  
		ELSE
			 expiration_date := (xpath('/toll_data/vehicle_license_plate/@expiration_date', record))[1]::text::VARCHAR(20);
		END IF;
		
		IF array_length(xpath('/toll_data/toll_booth_id/text()', record), 1) IS NULL THEN
			RAISE NOTICE 'Skipping record because missing toll_booth_id';
			should_skip_record := TRUE;  
		ELSE
			 toll_booth_id := (xpath('/toll_data/toll_booth_id/text()', record))[1]::text::INT;
		END IF;

		IF array_length(xpath('/toll_data/toll_amount/text()', record), 1) IS NULL THEN
			RAISE NOTICE 'Skipping record because missing toll_amount';
			should_skip_record := TRUE;  
		ELSE
			 toll_amount := (xpath('/toll_data/toll_amount/text()', record))[1]::text::DECIMAL(10, 2);
		END IF;

		IF array_length(xpath('/toll_data/toll_amount/@currency_type', record), 1) IS NULL THEN
			RAISE NOTICE 'Skipping record because missing currency_type';
			should_skip_record := TRUE;  
		ELSE
			 currency_type := (xpath('/toll_data/toll_amount/@currency_type', record))[1]::text::VARCHAR(3);
		END IF;		
        
 		IF array_length(xpath('/toll_data/toll_amount/@payment_rendered', record), 1) IS NULL THEN
			RAISE NOTICE 'Skipping record because missing payment_rendered';
			should_skip_record := TRUE;  
		ELSE
			 payment_rendered :=(xpath('/toll_data/toll_amount/@payment_rendered', record))[1]::text::VARCHAR(10);
		END IF;
		
		IF array_length(xpath('/toll_data/toll_amount/@device_serial', record), 1) IS NULL THEN
			RAISE NOTICE 'Skipping record because missing device_serial';
			should_skip_record := TRUE;  
		ELSE
			 device_serial:= COALESCE((xpath('/toll_data/toll_amount/@device_serial', record))[1]::text::VARCHAR(14), null);
		END IF;	
		
		
		IF NOT should_skip_record THEN
			insert into toll_data(toll_id,vehicle_license_plate,state_plate,expiration_date,
								  toll_booth_id,currency_type,payment_rendered,device_serial,toll_amount )
			values(toll_id,vehicle_license_plate,state_plate,expiration_date,
						toll_booth_id,currency_type,payment_rendered,
					   case device_serial
							when '' then NULL
							when NULL then NULL
							else device_serial
					   end, toll_amount);
		END IF;	
		
		
		
	END LOOP;

END $$;







/*
some common nodes tests
-------------------------------------------
node():			Matches any node
element():		Matches any element node
attribute():	Matches any attribute node
test():			Mataches any text node
comment():		Matches any comment node
*/

/*
select *
from toll_data

*/