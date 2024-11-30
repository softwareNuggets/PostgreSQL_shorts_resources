--YouTube: @SoftwareNuggets
--written by: Scott Johnson on 11/30/2024

SELECT version(); 


drop table transaction_logs
CREATE TABLE transaction_logs (
    transaction_id BIGSERIAL primary key,
    customer_id INTEGER,
    transaction_date DATE,
    amount NUMERIC(10,2),
    transaction_type VARCHAR(20),
    details JSONB
);

select count(*) from transaction_logs

select 365*5  '1825'

select cast('2020-01-01' as date)
select '2020-01-01'::DATE 

select FLOOR(RANDOM() * (365 * 5))
select (FLOOR(RANDOM() * (365 * 5))::INTEGER * INTERVAL '1 day');

select '2020-01-01'::DATE +
		(FLOOR(RANDOM() * (365 * 5))::INTEGER * INTERVAL '1 day');
		
select FLOOR(RANDOM() * 4 + 1)
select (ARRAY['online', 'mobile', 'in-store', 'phone'])[2]
select (ARRAY['online', 'mobile', 'in-store', 'phone'])[FLOOR(RANDOM() * 4 + 1)]


DO $$
DECLARE
    i INTEGER;
    random_customer_id INTEGER;
    random_date DATE;
    random_amount NUMERIC(10,2);
    random_type VARCHAR(20);
BEGIN
    FOR i IN 1..1000000 LOOP
        -- Generate random customer ID between 1 and 10,000
        random_customer_id := FLOOR(RANDOM() * 10000 + 1);
        
        -- Generate random transaction date between 2020-01-01 and 2024-12-31
        random_date := '2020-01-01'::DATE + 
            (FLOOR(RANDOM() * (365 * 5))::INTEGER * INTERVAL '1 day');
        
        -- Generate random transaction amount between $10 and $5000
        random_amount := ROUND((RANDOM() * 4990 + 10)::NUMERIC, 2);
        
        -- Generate random transaction type
        random_type := (ARRAY['purchase', 'refund', 'transfer', 'payment', 
                               'deposit', 'withdrawal'])[FLOOR(RANDOM() * 6 + 1)];
        
        -- Insert the generated transaction
        INSERT INTO transaction_logs 
        			(customer_id, transaction_date, amount, transaction_type, details)
        VALUES 		(
            		random_customer_id,
            		random_date,
            		random_amount,
            		random_type,
            		jsonb_build_object(
                		'source', (ARRAY['online', 'mobile', 'in-store', 'phone'])[FLOOR(RANDOM() * 4 + 1)],
                		'category', (ARRAY['clothing', 'groceries', 'services'])[FLOOR(RANDOM() * 3 + 1)],
                		'transaction_hash', MD5(random_amount::TEXT || random_date::TEXT)
            )
        );
    END LOOP;
END $$;

