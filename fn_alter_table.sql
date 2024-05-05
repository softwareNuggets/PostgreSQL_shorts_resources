CREATE OR REPLACE FUNCTION fn_alter_table
(
	table_info JSON
)
returns varchar
as
$$
DECLARE
    v_table_name 	VARCHAR;
    v_columns 		JSON;
    v_column_def 	JSON;
    v_column_name 	VARCHAR;
    v_data_type 	VARCHAR;
    v_size 			INT;
    v_precision 	INT;
	v_table_exists  BOOLEAN;
BEGIN

	-- Extract table name and columns from JSON input
    v_table_name 	:= table_info->>'table_name';		--extract text value
    v_columns 		:= table_info->'columns';          --extract JSON object

	-- make sure we have values for v_table_name and v_columns
    IF v_table_name IS NULL THEN
        RAISE EXCEPTION 'Table name is required';
    END IF;

	IF v_columns IS NULL THEN
        RAISE EXCEPTION 'Columns are required';
    END IF;

	-- Check if the table exists in information_schema.tables
    SELECT EXISTS (
        SELECT 1
        FROM information_schema.tables
        WHERE table_name = v_table_name
    ) INTO v_table_exists;

    IF NOT v_table_exists THEN
        RAISE EXCEPTION 'Table % does not exist', v_table_name;
    END IF;

	
    FOR v_column_def IN SELECT * FROM json_array_elements(v_columns)
    LOOP
		-- Extract column details from column definition
        v_column_name 		:= v_column_def->>'name';						--extract text value
        v_data_type 		:= v_column_def->>'data_type';					--extract text value
        v_size 				:= NULLIF(v_column_def->>'size', '')::INT;
        v_precision 		:= NULLIF(v_column_def->>'precision', '')::INT;

		--RAISE NOTICE 'Column Name: %, Data Type: %, Size: %, Precision: %',
        --             v_column_name, v_data_type, v_size, v_precision;

		-- Validate data type, size, and precision for NUMERIC
        IF v_data_type = 'NUMERIC' THEN
            IF v_size IS NULL THEN
                RAISE EXCEPTION 'Size parameter is required for NUMERIC data type for column %', v_column_name;
            END IF;
            IF v_precision IS NULL THEN
                RAISE EXCEPTION 'Precision parameter is required for NUMERIC data type for column %', v_column_name;
            END IF;
        END IF;

		-- Execute ALTER TABLE statement based on data type
        EXECUTE format('ALTER TABLE %I ADD COLUMN %I %s%s',
                       v_table_name, v_column_name, v_data_type, 
                       CASE 
                           WHEN v_data_type IN ('CHAR', 'VARCHAR') THEN format('(%s)', v_size) 
                           WHEN v_data_type = 'NUMERIC' THEN format('(%s, %s)', v_size, v_precision)
                           ELSE '' 
                       END);


	END LOOP;

	RETURN 'function complete';
END;
$$
Language plpgsql;

SELECT fn_alter_table('{}')

select fn_alter_table('{ "table_name": "employee" }')

select fn_alter_table('
	{
    "table_name": "employee",
    "columns": [
        {"name": "dt_smallint", "data_type": "SMALLINT"},
		{"name": "dt_char", "data_type": "CHAR", "size": 10},
		{"name": "dt_numeric", "data_type": "NUMERIC", "size": 10, "precision": 2}
		]
	}')

SELECT NULLIF('', '')::INT;
	
SELECT fn_alter_table('{
    "table_name": "employee",
    "columns": [
        {"name": "dt_smallint", "data_type": "SMALLINT"},
        {"name": "dt_integer", "data_type": "INTEGER"},
        {"name": "dt_bigint", "data_type": "BIGINT"},
        {"name": "dt_numeric", "data_type": "NUMERIC", "size": 10, "precision": 2},
        {"name": "dt_real", "data_type": "REAL"},
        {"name": "dt_double", "data_type": "DOUBLE PRECISION"},
        {"name": "dt_boolean", "data_type": "BOOLEAN"},
        {"name": "dt_char", "data_type": "CHAR", "size": 10},
        {"name": "dt_varchar", "data_type": "VARCHAR", "size": 255},
        {"name": "dt_text", "data_type": "TEXT"},
        {"name": "dt_date", "data_type": "DATE"},
        {"name": "dt_time", "data_type": "TIME"},
        {"name": "dt_timestamp", "data_type": "TIMESTAMP"},
        {"name": "dt_interval", "data_type": "INTERVAL"},
        {"name": "dt_uuid", "data_type": "UUID"},
        {"name": "dt_json", "data_type": "JSON"},
        {"name": "dt_jsonb", "data_type": "JSONB"},
        {"name": "dt_money", "data_type": "MONEY"}
    ]
}');


-- test
drop table employee;

create table employee
(
		emp_id integer not null
);

select *
from employee
	
SELECT fn_alter_table(
	'{
    "table_name": "employee",
    "columns": [
        {"name": "dt_smallint", "data_type": "SMALLINT"},
        {"name": "dt_integer", "data_type": "INTEGER"},
        {"name": "dt_bigint", "data_type": "BIGINT"}
	    ]
}');

select *
from employee