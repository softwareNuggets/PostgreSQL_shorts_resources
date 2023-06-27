--drop table company_info
--how to use XML in Postgresql 
--softwareNuggets

-- Step 1: Create the company_info table
CREATE Temporary TABLE company_info (
  companyName VARCHAR(100),
  xmlData XML
);



-- Step 2: Insert sample data into the company_info table
INSERT INTO company_info (companyName, xmlData)
VALUES
  (	'Company A', 
   	'<company><name>John Doe</name><state>California</state><phone>123-456-7890</phone></company>'),
  (	'Company B', 
   	'<company><name>Jane Smith</name><state>New York</state><phone>987-654-3210</phone></company>'),
  (	'Company C', 
   	'<company><name>Mark Johnson</name><state>Texas</state><phone>555-123-4567</phone></company>'),
  (	'Company D', 
   	'<company><name>Sarah Davis</name><state>Florida</state><phone>999-888-7777</phone></company>');


INSERT INTO company_info (companyName, xmlData)
VALUES
  (	'Company E', 
   '<company><name2>Some One</name><state>California</state><phone>159-489-9510</phone></company>');


select xmlData, xmlparse(DOCUMENT xmlData) AS xml_data
from company_info




