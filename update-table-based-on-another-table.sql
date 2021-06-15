UPDATE temp_animal_stats
INNER JOIN temp_country_totals       
ON temp_animal_stats.country_id = temp_country_totals.country_id
SET temp_animal_stats.grand_total = temp_country_totals.grand_total;