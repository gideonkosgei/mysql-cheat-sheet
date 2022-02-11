select id,additional_attributes -> '$."91"' as f 
from core_animal 
where farm_id = 494612 and tag_id = 'MAK-341I/S';


select id,jdoc -> '$."7"' as f from samp1