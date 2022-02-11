 
 UPDATE core_animal a
INNER JOIN temp_makitosha_breeds_percentage_rank b      
ON a.tag_id = b.tag_id
SET a.additional_attributes = JSON_SET(JSON_UNQUOTE(a.additional_attributes), '$."458"', b.breed_id) 
 WHERE a.farm_id = 494612 AND b.uuid=_uuid AND b.ranking = 2;   
 
 update `adgg_uat`.`core_animal_event`
set `core_animal_event`.`additional_attributes` = 
JSON_SET(`core_animal_event`.`additional_attributes`, '$."62"', 
(JSON_UNQUOTE(JSON_EXTRACT(`core_animal_event`.`additional_attributes`, '$."59"'))+ 
JSON_UNQUOTE(JSON_EXTRACT(`core_animal_event`.`additional_attributes`, '$."61"')))) 
WHERE  (`core_animal_event`.`event_type` = 2) AND (`core_animal_event`.`country_id` = '11') ;


UPDATE core_animal a
INNER JOIN temp_makitosha_breeds_percentage_rank b      
ON a.tag_id = b.tag_id
SET a.additional_attributes = JSON_SET(a.additional_attributes, '$."458"', b.breed_id) 
 WHERE a.farm_id = 494612 AND b.uuid=_uuid AND b.ranking = 2;   
 
	
