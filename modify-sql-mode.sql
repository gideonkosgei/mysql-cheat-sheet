/*
https://stackoverflow.com/questions/41887460/select-list-is-not-in-group-by-clause-and-contains-nonaggregated-column-inc
Step 1: sudo vi /etc/mysql/mysql.conf.d/mysqld.cnf
Step 2: Go to last line and add the following

	sql_mode = STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_ENGINE_SUBSTITUTION

Step 3: Save

Step 4: Restart mysql server.

*/

SELECT @@sql_mode; /* view sql mode*/


/*
sql mode is stored along with the stored procedure, so even if you change the sql mode correctly it doesn't update the SP at all. 
To fix this I, deleted and recreated the stored procedures while the new sql mode is set
*/
