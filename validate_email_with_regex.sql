CREATE OR REPLACE FUNCTION validate_email(email_address text)
RETURNS BOOLEAN 
AS $$
BEGIN
     RETURN email_address ~* '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
END;
$$ LANGUAGE plpgsql;

-- ~   In PostgreSQL, the single character ~ is called the "case-sensitive regular expression match" operator. 
-- *   means that the pattern preceding it can match zero or more occurrences of the characters it represents

-- other regex expressions
-- basic     [a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$
-- html5     [a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$
-- co.uk     [a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(?:\.[a-zA-Z]{2,})?$

select validate_email('thumbs=up_mate@gmail.com')