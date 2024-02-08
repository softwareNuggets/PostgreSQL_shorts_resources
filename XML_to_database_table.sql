--software nuggets
--postgresql youtube video


--step 1

DO $$
DECLARE
    first_name 		VARCHAR(30);
    ssn 			VARCHAR(15);
    first_name 		VARCHAR(30);
	age				INT;
	record 			XML;
	
    xml_data XML := 
	'<data>
        <record><first_name>Bob1</first_name><ssn>111-44-1234</ssn><age>23</age></record>
        <record><first_name>Bob2</first_name><ssn>222-44-1234</ssn><age>32</age></record>
    </data>';
	
BEGIN
    FOR record IN SELECT unnest(xpath('/data/record', xml_data)) LOOP
        first_name_val 	:= (xpath('record/first_name/text()', record))[1]::VARCHAR(30);
        ssn_val 		:= (xpath('record/ssn/text()', record))[1]::VARCHAR(60);
		age 			:= (xpath('record/age/text()', record))[1]::text::INT;
		RAISE NOTICE 'Processing record: record = %', record;

		RAISE NOTICE 'Processing record: first_name = %, ssn = %', 
					first_name_val, ssn_val;
					
        --RAISE NOTICE 'Processing record: first_name = %, ssn = %, age = %', 
		--			first_name_val, ssn_val,age;
    END LOOP;
END $$;

--step 2

/*
select version()
drop table toll_data

CREATE Temporary TABLE  toll_data (
    toll_id 				SERIAL 		PRIMARY KEY,
    vehicle_license_plate 	VARCHAR(20) NOT NULL,
    toll_booth_id 			INT 		NOT NULL,
    toll_amount DECIMAL(10, 2) 			NOT NULL
)
*/


DO $$ 
DECLARE 
	toll_id 				int;
	vehicle_license_plate 	varchar(6);
	toll_booth_id 			int;
	toll_amount 			decimal(10,2);
	record 					XML;
	
    xml_data XML := '<toll_data_list>
						<toll_data>
							<toll_id>1</toll_id>
							<vehicle_license_plate>ABC123</vehicle_license_plate>
							<toll_booth_id>101</toll_booth_id>
							<toll_amount>5.75</toll_amount>
						</toll_data>
						<toll_data>
							<toll_id>2</toll_id>
							<vehicle_license_plate>XYZ789</vehicle_license_plate>
							<toll_booth_id>102</toll_booth_id>
							<toll_amount>8.50</toll_amount>
						</toll_data>
						<toll_data>
							<toll_id>3</toll_id>
							<vehicle_license_plate>DEF456</vehicle_license_plate>
							<toll_booth_id>103</toll_booth_id>
							<toll_amount>3.25</toll_amount>
						</toll_data>
						<toll_data>
							<toll_id>4</toll_id>
							<vehicle_license_plate>GHI789</vehicle_license_plate>
							<toll_booth_id>104</toll_booth_id>
							<toll_amount>6.00</toll_amount>
						</toll_data>
						<toll_data>
							<toll_id>5</toll_id>
							<vehicle_license_plate>JKL012</vehicle_license_plate>
							<toll_booth_id>105</toll_booth_id>
							<toll_amount>4.75</toll_amount>
						</toll_data>
						<toll_data>
							<toll_id>6</toll_id>
							<vehicle_license_plate>MNO345</vehicle_license_plate>
							<toll_booth_id>106</toll_booth_id>
							<toll_amount>2.50</toll_amount>
						</toll_data>
						<toll_data>
							<toll_id>7</toll_id>
							<vehicle_license_plate>PQR678</vehicle_license_plate>
							<toll_booth_id>107</toll_booth_id>
							<toll_amount>7.25</toll_amount>
						</toll_data>
						<toll_data>
							<toll_id>8</toll_id>
							<vehicle_license_plate>STU901</vehicle_license_plate>
							<toll_booth_id>108</toll_booth_id>
							<toll_amount>9.00</toll_amount>
						</toll_data>
						<toll_data>
							<toll_id>9</toll_id>
							<vehicle_license_plate>VWX234</vehicle_license_plate>
							<toll_booth_id>109</toll_booth_id>
							<toll_amount>3.75</toll_amount>
						</toll_data>
						<toll_data>
							<toll_id>10</toll_id>
							<vehicle_license_plate>YZA567</vehicle_license_plate>
							<toll_booth_id>110</toll_booth_id>
							<toll_amount>5.00</toll_amount>
						</toll_data>
					</toll_data_list>
					';
BEGIN
	FOR record IN SELECT unnest(xpath('/toll_data_list/toll_data', xml_data)) LOOP
	
        toll_id := (xpath('/toll_data/toll_id/text()', record))[1]::text::INT;
        vehicle_license_plate := (xpath('/toll_data/vehicle_license_plate/text()', record))[1]::text::VARCHAR(20);
        toll_booth_id := (xpath('/toll_data/toll_booth_id/text()', record))[1]::text::INT;
        toll_amount := (xpath('/toll_data/toll_amount/text()', record))[1]::text::DECIMAL(10, 2);
		
		insert into toll_data(toll_id,vehicle_license_plate,toll_booth_id,toll_amount )
		values(toll_id,vehicle_license_plate,toll_booth_id,toll_amount);
		
    END LOOP;

END $$;

select *
from toll_data