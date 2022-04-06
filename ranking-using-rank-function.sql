
-- Reference
--  https://www.mysqltutorial.org/mysql-window-functions/mysql-rank-function/

	SELECT
		farm.id farm_id,
		ifnull(animal.reg_date,date(animal.created_at)) animal_registration_date,
		animal.id animal_id,  
		animal.tag_id, 
		ifnull(breeds.label,'Unknown') main_breed,
		animal.birthdate,    
		sex.label hh_gender,	
		ifnull(JSON_UNQUOTE(JSON_EXTRACT(animal.additional_attributes, '$."751"')),herd.herd_size) herd_size,    
		country.`name` AS country, 
		region.`name` AS region,
		district.`name` AS district,
		ward.`name` AS ward,
		village.`name` AS village,
        evnt.event_date calving_date,
		LAG(evnt.event_date,1) OVER (PARTITION BY evnt.animal_id ORDER BY evnt.event_date ) previous_calving_date,
		DATEDIFF(evnt.event_date,LAG(evnt.event_date,1) OVER (PARTITION BY evnt.animal_id ORDER BY evnt.event_date )) calving_interval,
        RANK() OVER (PARTITION BY evnt.animal_id ORDER BY evnt.event_date ) parity              
	FROM core_animal animal
	JOIN core_farm farm  ON animal.farm_id = farm.id
	LEFT JOIN core_country country ON farm.country_id = country.id
	LEFT JOIN country_units region ON farm.region_id = region.id
	LEFT JOIN country_units district ON farm.district_id = district.id
	LEFT JOIN country_units ward ON farm.ward_id = ward.id
	LEFT JOIN country_units village ON farm.village_id = village.id
	LEFT JOIN core_master_list sex ON JSON_UNQUOTE(JSON_EXTRACT(farm.additional_attributes, '$."36"')) = sex.value AND sex.list_type_id = 3
	LEFT JOIN core_master_list breeds on animal.main_breed = breeds.value AND breeds.list_type_id = 8
	LEFT JOIN (SELECT id, count(id) herd_size FROM core_farm group by id) herd ON farm.id = herd.id
    LEFT JOIN core_animal_event evnt ON animal.id = evnt.animal_id
	WHERE farm.is_deleted =0 AND farm.country_id = 10 AND evnt.event_type = 1
    ORDER BY animal.id
    LIMIT 1000;
    
    
   
    
    
	


