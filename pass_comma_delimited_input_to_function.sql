--drop table company_info
--DROP FUNCTION proc_find_companies_by_ids(character varying)
--how to use XML in Postgresql 
--softwareNuggets

-- Step 1: Create the company_info table
CREATE Temporary TABLE company_info (
  companyId integer not null primary key,
  companyName VARCHAR(100),
  stateName VARCHAR(50),
  phone VARCHAR(20),
  isCompanyActive BOOLEAN
);





-- Step 2: Insert sample data into the company_info table
INSERT INTO company_info (companyId, companyName, stateName, phone, isCompanyActive)
VALUES
  (1,'Company 1', 'State 1',  '123-456-7890', true),
  (2,'Company 2', 'State 2',  '234-567-8901', true),
  (3,'Company 3', 'State 3',  '345-678-9012', true),
  (4,'Company 4', 'State 4',  '456-789-0123', false),
  (5,'Company 5', 'State 5',  '567-890-1234', false);



<companies>
	<company>
		<companyid>1</companyid>
		<companyname>Company 1</companyname>
		<statename>State 1</statename>
		<phone>123-456-7890</phone>
		<iscompanyactive>true</iscompanyactive>
	</company>
	<company>
		<companyid>2</companyid>
		<companyname>Company 2</companyname>
		<statename>State 2</statename>
		<phone>234-567-8901</phone>
		<iscompanyactive>true</iscompanyactive>
	</company>
	<company>
		<companyid>5</companyid>
		<companyname>Company 5</companyname>
		<statename>State 5</statename>
		<phone>567-890-1234</phone>
		<iscompanyactive>false</iscompanyactive>
	</company>
</companies>






DROP FUNCTION proc_find_companies_by_ids(character varying)


-- Step 3: Create the proc_fetch_company_info stored procedure
CREATE OR REPLACE FUNCTION proc_find_companies_by_ids(comma_separated_list varchar(100))
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
               XMLFOREST(companyId, companyName, stateName, phone, isCompanyActive)
             )
           )
         )
  INTO xml_result
  FROM company_info
  WHERE companyId IN (
    SELECT unnest(string_to_array(comma_separated_list, ','))::integer
  );

  RETURN xml_result;
END;
$$
LANGUAGE plpgsql;





--Step 4, execute procedure and show output
DO  $$
DECLARE
  xml_output XML;
  isActive BOOLEAN := true;
  comma_separated varchar := '1,2,5';
BEGIN
  -- Execute the stored procedure and capture the result
  SELECT proc_find_companies_by_ids(comma_separated) INTO xml_output;
  
  -- Print the XML result
  RAISE NOTICE '%', xml_output;
END $$
language plpgsql;




