CREATE TABLE Meeting
(
    ID INT,
    Meeting_id INT,
    field_key VARCHAR(100),
    field_value VARCHAR(100)
);

INSERT INTO Meeting(ID,Meeting_id,field_key,field_value)
VALUES (1, 1,'first_name' , 'Alec');
INSERT INTO Meeting(ID,Meeting_id,field_key,field_value)
VALUES (2, 1,'last_name' , 'Jones');
INSERT INTO Meeting(ID,Meeting_id,field_key,field_value)
VALUES (3, 1,'occupation' , 'engineer');
INSERT INTO Meeting(ID,Meeting_id,field_key,field_value)
VALUES (4,2,'first_name' , 'John');
INSERT INTO Meeting(ID,Meeting_id,field_key,field_value)
VALUES (5,2,'last_name' , 'Doe');
INSERT INTO Meeting(ID,Meeting_id,field_key,field_value)
VALUES (6,2,'occupation' , 'engineer');

SET @sql = NULL;
SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'max(case when field_key = ''',
      field_key,
      ''' then field_value end) ',
      field_key
    )
  ) INTO @sql 
FROM
  Meeting;
SET @sql = CONCAT('SELECT Meeting_id, ', @sql, ' 
                  FROM Meeting 
                   GROUP BY Meeting_id');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


/*

	REFERENCES
	https://ubiq.co/database-blog/how-to-create-dynamic-pivot-tables-in-mysql/

*/