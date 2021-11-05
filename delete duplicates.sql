delete test
   from test
  inner join (
     select max(id) as lastId, email
       from test
      group by email
     having count(*) > 1) duplic on duplic.email = test.email
  where test.id < duplic.lastId;
  
  
  
https://stackoverflow.com/questions/6107167/mysql-delete-duplicate-records-but-keep-latest