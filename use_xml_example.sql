--drop table company_info
--DROP FUNCTION proc_list_of_fetch_company_info(boolean)
--how to use XML in Postgresql 
--softwareNuggets

-- Step 1: Create the company_info table
CREATE Temporary TABLE company_info (
  companyName VARCHAR(100),
  stateName VARCHAR(50),
  phone VARCHAR(20),
  isCompanyActive BOOLEAN
);





-- Step 2: Insert sample data into the company_info table
INSERT INTO company_info (companyName, stateName, phone, isCompanyActive)
VALUES
  ('Company 1', 'State 1',  '123-456-7890', true),
  ('Company 2', 'State 2',  '234-567-8901', true),
  ('Company 3', 'State 3',  '345-678-9012', true),
  ('Company 4', 'State 4',  '456-789-0123', false),
  ('Company 5', 'State 5',  '567-890-1234', false);



<companies>
	<company>
		<companyname>Company 1</companyname>
		<statename>State 1</statename>
		<phone>123-456-7890</phone>
		<iscompanyactive>true</iscompanyactive>
	</company>
	<company>
		<companyname>Company 2</companyname>
		<statename>State 2</statename>
		<phone>234-567-8901</phone>
		<iscompanyactive>true</iscompanyactive>
	</company>
	<company>
		<companyname>Company 3</companyname>
		<statename>State 3</statename>
		<phone>345-678-9012</phone>
		<iscompanyactive>true</iscompanyactive>
	</company>
</companies>









-- Step 3: Create the proc_fetch_company_info stored procedure
CREATE OR REPLACE FUNCTION proc_list_of_fetch_company_info(is_active BOOLEAN)
  RETURNS XML AS
$$
DECLARE
  xml_result XML;
BEGIN
  SELECT XMLELEMENT(
    NAME "companies",
    XMLAGG(
      XMLELEMENT(
        NAME "company",
        XMLFOREST(companyName, stateName, phone, isCompanyActive)
      )
    )
  ) INTO xml_result
  FROM company_info
  WHERE isCompanyActive = is_active;

  RETURN xml_result;
END;
$$
LANGUAGE plpgsql;











--Step 4, execute procedure and show output
DO  $$
DECLARE
  xml_output XML;
  isActive BOOLEAN := true;
BEGIN
  -- Execute the stored procedure and capture the result
  SELECT proc_list_of_fetch_company_info(isActive) INTO xml_output;
  
  -- Print the XML result
  RAISE NOTICE '%', xml_output;
END $$
language plpgsql;





