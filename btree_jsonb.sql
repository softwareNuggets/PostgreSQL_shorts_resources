/*
	how to use B-TREE index on a JSONB <key>
	a) insert 25 Million rows into a table
	b) create a btree index on a jsonb<key>
	c) query table 
	d) use explain so we can see btree-index was used.
	
	https://github.com/softwareNuggets/PostgreSQL_shorts_resources
	btree_jsonb.sql
	
*/
drop table contact_table2;
drop function populate_contacts;
truncate table contact_table2

-- Create the table
CREATE TABLE contact_table2 (
    serial_number SERIAL PRIMARY KEY,
    contact_info JSONB
);



-- Function to insert rows
CREATE OR REPLACE FUNCTION populate_contacts(num_rows INT)
RETURNS VOID AS $$
DECLARE
    all_ten INT; 
    str VARCHAR(20);
BEGIN
    FOR i IN 1..num_rows LOOP
        all_ten := i;

        str := RIGHT('000000000' || CAST(all_ten AS TEXT), 10);
        
		--{'phone':'000-000-0000', 'email':'0000000000@mail.com' }
        INSERT INTO contact_table2 (contact_info)
        VALUES (
            jsonb_build_object(
                'phone', 
                SUBSTRING(str FROM 1 FOR 3) || '-' ||
                SUBSTRING(str FROM 4 FOR 3) || '-' ||
                SUBSTRING(str FROM 7 FOR 4),
                'email', str || '@mail.com'
            )
        );
    END LOOP;
END;
$$ LANGUAGE plpgsql;









-- on line 56, we will call the function we just wrote
-- let's insert 25 million rows
select populate_contacts(25000000);

		
SELECT *
FROM contact_table2
WHERE contact_info->>'phone'  = '000-175-9015';
--4.6sec


explain SELECT *
FROM contact_table2
WHERE contact_info->>'phone'  = '000-175-9015';




create index idx_phone_btree
	on contact_table2
	using btree ((contact_info->>'phone'));




SELECT *
FROM contact_table2
WHERE contact_info->>'phone'  = '000-115-0015';

explain SELECT *
FROM contact_table2
WHERE contact_info->>'phone'  = '000-115-0015';


SELECT *
FROM contact_table2
WHERE contact_info->>'phone'  in('000-999-9999','000-115-0015','000-200-0002');

		
explain SELECT *
FROM contact_table2
WHERE contact_info->>'phone'  in('000-999-9999','000-115-0015','000-200-0002');
		
