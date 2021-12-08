use adgg;
DELIMITER $$
CREATE PROCEDURE `sp_stats_top_cows`(_option integer,_org_id integer,_year year)
BEGIN
	/*	option
		0 - production year
		1 - lifetime
	*/
	SET @row_number = 0; 
    
	if _option = 0 then
		SELECT
			(@row_number:=@row_number + 1) AS num ,
			x.animal_id,
			x.name,
			x.tag_id,
			x.average_milk,
			x.total_milk
		 FROM (SELECT 
		  core_animal_event.animal_id,
		  core_animal.name,
		  core_animal.tag_id,  
		  ROUND(avg(replace(JSON_UNQUOTE(JSON_EXTRACT(core_animal_event.additional_attributes, '$."61"')),'null','') + 
		  replace(JSON_UNQUOTE(JSON_EXTRACT(core_animal_event.additional_attributes, '$."68"')),'null','') +
		  replace(JSON_UNQUOTE(JSON_EXTRACT(core_animal_event.additional_attributes, '$."59"')),'null','')),2) AS average_milk,
		  ROUND(SUM(replace(JSON_UNQUOTE(JSON_EXTRACT(core_animal_event.additional_attributes, '$."61"')),'null','') + 
		  replace(JSON_UNQUOTE(JSON_EXTRACT(core_animal_event.additional_attributes, '$."68"')),'null','') +
		  replace(JSON_UNQUOTE(JSON_EXTRACT(core_animal_event.additional_attributes, '$."59"')),'null','')),2) AS total_milk
		 FROM core_animal_event  
		 LEFT JOIN core_animal on core_animal.id = core_animal_event.animal_id
		 WHERE (core_animal_event.event_type = 2)
		 AND core_animal.org_id = _org_id
		 AND YEAR(core_animal_event.event_date) = _year
		 GROUP BY core_animal_event.animal_id
		 )  AS x order by x.total_milk DESC;
	 else
		 SELECT
			(@row_number:=@row_number + 1) AS num ,
			x.animal_id,
			x.name,
			x.tag_id,
			x.average_milk,
			x.total_milk
		 FROM (SELECT 
		  core_animal_event.animal_id,
		  core_animal.name,
		  core_animal.tag_id,  
		  ROUND(avg(replace(JSON_UNQUOTE(JSON_EXTRACT(core_animal_event.additional_attributes, '$."61"')),'null','') + 
		  replace(JSON_UNQUOTE(JSON_EXTRACT(core_animal_event.additional_attributes, '$."68"')),'null','') +
		  replace(JSON_UNQUOTE(JSON_EXTRACT(core_animal_event.additional_attributes, '$."59"')),'null','')),2) AS average_milk,
		  ROUND(SUM(replace(JSON_UNQUOTE(JSON_EXTRACT(core_animal_event.additional_attributes, '$."61"')),'null','') + 
		  replace(JSON_UNQUOTE(JSON_EXTRACT(core_animal_event.additional_attributes, '$."68"')),'null','') +
		  replace(JSON_UNQUOTE(JSON_EXTRACT(core_animal_event.additional_attributes, '$."59"')),'null','')),2) AS total_milk
		 FROM core_animal_event  
		 LEFT JOIN core_animal on core_animal.id = core_animal_event.animal_id
		 WHERE (core_animal_event.event_type = 2)
		 AND core_animal.org_id = _org_id
		 GROUP BY core_animal_event.animal_id
		 )  AS x order by x.total_milk DESC; 
	 end if;
END$$
DELIMITER ;

