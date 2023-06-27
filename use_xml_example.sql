--drop table company_info
--DROP FUNCTION proc_fetch_company_info(boolean)
--how to use XML in Postgresql 
--softwareNuggets

-- Step 1: Create the company_info table
CREATE Temporary TABLE company_info (
  companyName VARCHAR(100),
  create_date DATE,
  stateName VARCHAR(50),
  city VARCHAR(50),
  zip VARCHAR(10),
  phone VARCHAR(20),
  email VARCHAR(100),
  url VARCHAR(100),
  isCompanyActive BOOLEAN
);

-- Step 2: Insert sample data into the company_info table
INSERT INTO company_info (companyName, create_date, stateName, city, zip, phone, email, url, isCompanyActive)
VALUES
  ('Company 1', '2023-01-01', 'State 1', 'City 1', '12345', '123-456-7890', 'info1@example.com', 'www.company1.com', true),
  ('Company 2', '2023-02-01', 'State 2', 'City 2', '23456', '234-567-8901', 'info2@example.com', 'www.company2.com', true),
  ('Company 3', '2023-03-01', 'State 3', 'City 3', '34567', '345-678-9012', 'info3@example.com', 'www.company3.com', true),
  ('Company 4', '2023-04-01', 'State 4', 'City 4', '45678', '456-789-0123', 'info4@example.com', 'www.company4.com', false),
  ('Company 5', '2023-05-01', 'State 5', 'City 5', '56789', '567-890-1234', 'info5@example.com', 'www.company5.com', false),
  ('Company 6', '2023-06-01', 'State 6', 'City 6', '67890', '678-901-2345', 'info6@example.com', 'www.company6.com', true),
  ('Company 7', '2023-07-01', 'State 7', 'City 7', '78901', '789-012-3456', 'info7@example.com', 'www.company7.com', false),
  ('Company 8', '2023-08-01', 'State 8', 'City 8', '89012', '890-123-4567', 'info8@example.com', 'www.company8.com', true),
  ('Company 9', '2023-09-01', 'State 9', 'City 9', '90123', '901-234-5678', 'info9@example.com', 'www.company9.com', false),
  ('Company 10', '2023-10-01', 'State 10', 'City 10', '01234', '012-345-6789', 'info10@example.com', 'www.company10.com', true);

-- Step 3: Create the proc_fetch_company_info stored procedure
CREATE OR REPLACE FUNCTION proc_fetch_company_info(is_active BOOLEAN)
  RETURNS XML AS
$$
DECLARE
  xml_result XML;
BEGIN
  SELECT XMLFOREST(companyName, create_date, stateName, city, zip, phone, email, url, isCompanyActive)
    INTO xml_result
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
  SELECT proc_fetch_company_info(isActive) INTO xml_output;
  
  -- Print the XML result
  RAISE NOTICE '%', xml_output;
END $$
language plpgsql;
