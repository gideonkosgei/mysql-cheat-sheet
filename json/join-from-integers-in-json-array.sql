-- https://stackoverflow.com/questions/65365713/mysql-5-join-from-integers-in-json-array
use adgg_uat;
SELECT a.id,     
	(
		select json_arrayagg(r.label)
		from core_master_list r
		where json_contains(a.additional_attributes, cast(`r`.`value` as json), '$."249"') and
		r.list_type_id = 8        
    ) as data  
FROM core_animal a WHERE a.id = 354272;



 




