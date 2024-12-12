-- DROP TABLE IF EXISTS public.site_user_m;

CREATE TABLE site_user_m (
    id 				serial PRIMARY KEY,         -- Auto-incrementing primary key
    login_name 		character varying NOT NULL, -- Login name of the user
    password_salt 	UUID 	NOT NULL,          	 -- Salt for the password hash
    password_hash 	text 	NOT NULL,            -- Hashed password
    created_at 		TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp, 
	CONSTRAINT site_user_m_login_name_key UNIQUE (login_name)
);

select * from site_user_m;
--truncate table site_user_m;


CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- DROP PROCEDURE IF EXISTS public.proc_register_user(character varying, text);
CREATE OR REPLACE PROCEDURE public.proc_register_user(
	IN p_login_name character varying,
	IN p_password text)
AS 
$$
DECLARE
    v_salt 		UUID;
BEGIN
	-- Check if input parameters are not null
    IF p_login_name IS NULL OR p_password IS NULL THEN
        RAISE EXCEPTION 'Login name and password cannot be null';
    END IF;

	-- Check if login_name is unique
    IF EXISTS (SELECT 1 FROM site_user_m WHERE login_name = p_login_name) THEN
        RAISE EXCEPTION 'Login name "%" is already taken', p_login_name;
    END IF;
	
    -- Generate a new salt
    v_salt 		:= gen_random_uuid();		--select gen_random_uuid()
    
    -- Insert new user with hashed password
    INSERT INTO site_user_m (login_name, password_salt, password_hash)
    VALUES (
        p_login_name, 
        v_salt,
        sfn_hash_password(p_password, v_salt)
    );
END;
$$ LANGUAGE 'plpgsql';

CALL public.proc_register_user(
    'software nuggets',
    'my_private_pwd'
);

select * from site_user_m;

CREATE OR REPLACE FUNCTION public.sfn_hash_password(
	p_password text,
	p_salt uuid)
RETURNS character varying
AS 
$$
DECLARE
    v_hashed_password 	VARCHAR(128);
    v_pwd_and_salt 		TEXT;
BEGIN
    -- Concatenate password with salt
    v_pwd_and_salt := p_password || CAST(p_salt AS TEXT);
    
    -- Use PostgreSQL's built-in cryptographic hash function with explicit type casting
    v_hashed_password := encode(
        					digest(v_pwd_and_salt::bytea, 'sha512'::text), 
        					'hex'
    						);
    
    RETURN v_hashed_password;
END;
$$ LANGUAGE plpgsql;


select sfn_hash_password('my_simple_pwd',gen_random_uuid());

-- DROP FUNCTION IF EXISTS public.sfn_validate_user(character varying, text);

CREATE OR REPLACE FUNCTION public.sfn_validate_user
(
	p_login_name character varying,
	p_input_password text
)
RETURNS boolean
AS $$
DECLARE
    v_stored_hash 		VARCHAR(128);
    v_password_salt 	UUID;
    v_is_valid 			BOOLEAN := FALSE;
BEGIN

	-- Check if input parameters are not NULL or empty
    IF COALESCE(TRIM(p_login_name), '') = '' OR COALESCE(TRIM(p_input_password), '') = '' THEN
    	RAISE EXCEPTION 'Login name and password cannot be NULL or empty';
	END IF;
	
    -- Retrieve stored hash and salt for the given login name
    SELECT password_hash, password_salt
    INTO v_stored_hash, v_password_salt
    FROM site_user_m 
    WHERE login_name = p_login_name;
    
    -- Compare the input password hash with stored hash
    v_is_valid := (v_stored_hash = sfn_hash_password(p_input_password, v_password_salt));
    
    RETURN v_is_valid;
END;
$$ LANGUAGE plpgsql;

select * from site_user_m;
select sfn_validate_user(null,null);
select sfn_validate_user(null,'help');
select sfn_validate_user('software nuggets',null);
select sfn_validate_user('software nuggets','my_private_pwd');
select sfn_validate_user('software nuggets','aaaaaaaaaaaaaa');

select * from site_user_m;
CREATE OR REPLACE PROCEDURE public.update_user_pwd(
    IN p_login_name 	character varying,
    IN p_new_password 	text
)
AS
$$
DECLARE
    v_salt UUID;
BEGIN
    -- Check if input parameters are not null
    IF p_login_name IS NULL OR p_new_password IS NULL THEN
        RAISE EXCEPTION 'Login name and new password cannot be null';
    END IF;

    -- Check if user exists
    IF NOT EXISTS (SELECT 1 FROM site_user_m WHERE login_name = p_login_name) THEN
        RAISE EXCEPTION 'User with login name "%" does not exist', p_login_name;
    END IF;

    -- Generate a new salt
    v_salt := gen_random_uuid();
    
    -- Update the user's password with the new salt and hashed password
    UPDATE site_user_m
    SET password_salt = v_salt,
        password_hash = sfn_hash_password(p_new_password, v_salt)
    WHERE login_name = p_login_name;
    
END;
$$ LANGUAGE plpgsql;


CALL public.update_user_pwd(
    'software nuggets',
    'one_two_three'
);

select sfn_validate_user('software nuggets','my_private_pwd')

select sfn_validate_user('software nuggets','one_two_three')
