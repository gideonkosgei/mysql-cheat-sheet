

https://ixnfo.com/en/configuring-innodb-buffer-pool-size-in-mysql.html

SELECT @@innodb_buffer_pool_size;
SELECT @@innodb_buffer_pool_size;
SELECT @@innodb_buffer_pool_chunk_size;
SELECT @@innodb_buffer_pool_instances;
SHOW ENGINE INNODB STATUS;
show global status like '%innodb_buffer_pool_pages%';

SELECT CEILING(Total_InnoDB_Bytes*1.6/POWER(1024,3)) RIBPS FROM
(SELECT SUM(data_length+index_length) Total_InnoDB_Bytes
FROM information_schema.tables WHERE engine='InnoDB') A;

SET GLOBAL innodb_buffer_pool_size=2147483648;
SHOW STATUS WHERE Variable_name='InnoDB_buffer_pool_resize_status';