update `adgg_uat`.`core_animal_event`
set `core_animal_event`.`additional_attributes` = 
JSON_SET(`core_animal_event`.`additional_attributes`, '$."62"', 
(JSON_UNQUOTE(JSON_EXTRACT(`core_animal_event`.`additional_attributes`, '$."59"'))+ 
JSON_UNQUOTE(JSON_EXTRACT(`core_animal_event`.`additional_attributes`, '$."61"')))) 
WHERE  (`core_animal_event`.`event_type` = 2) AND (`core_animal_event`.`country_id` = '11') ;