--GitHub
--https://github.com/softwareNuggets/
--					/PostgreSQL_shorts_resources
--					/Convert_IP_to_integer.sql


create or replace function Convert_IP_to_integer(ipaddress varchar)
returns bigint
as
$$
declare ip_bigint bigint:=0;
begin
	ip_bigint := 
		(split_part(ipaddress, '.', 1)::bigint << 24) +
		(split_part(ipaddress, '.', 2)::bigint << 16) +
		(split_part(ipaddress, '.', 3)::bigint << 8) +
		(split_part(ipaddress, '.', 4)::bigint);
	
	return ip_bigint;
end;
$$
language plpgsql;



create or replace function Convert_integer_to_IPAddr(intValue bigint)
returns varchar
as
$$
declare ip_address varchar(20) := null;
begin
	ip_address :=
		(intValue 	>> 24)::int 		|| '.' ||
		((intValue 	>> 16) & 255)::int 	|| '.' ||
		((intValue 	>> 8) & 255)::int 	|| '.' ||
		(intValue 	& 255)::int;
		
	return (ip_address);
end;
$$
language plpgsql;










select version()






select convert_ip_to_integer('127.0.0.1') 		--loopback address
select convert_ip_to_integer('157.166.226.25')	--cnn.com

select Convert_integer_to_IPAddr(2644959769);   --a big integer



