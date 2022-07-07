#The following statement deletes duplicate rows and keeps the highest id
DELETE t1 FROM contacts t1
INNER JOIN contacts t2 
WHERE 
    t1.id < t2.id AND 
    t1.email = t2.email;
    
    
#delete duplicate rows and keep the lowest id, you can use the following statement:

DELETE c1 FROM contacts c1
INNER JOIN contacts c2 
WHERE
    c1.id > c2.id AND 
    c1.email = c2.email;



delete test
   from test
  inner join (
     select max(id) as lastId, email
       from test
      group by email
     having count(*) > 1) duplic on duplic.email = test.email
  where test.id < duplic.lastId;
  
  
  
https://stackoverflow.com/questions/6107167/mysql-delete-duplicate-records-but-keep-latest
