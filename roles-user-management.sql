
GRANT ALL ON app_db.* TO 'app_developer';
GRANT SELECT ON app_db.* TO 'app_read';
GRANT INSERT, UPDATE, DELETE ON app_db.* TO 'app_write';


CREATE USER 'dev1'@'localhost' IDENTIFIED BY 'dev1pass';
CREATE USER 'read_user1'@'localhost' IDENTIFIED BY 'read_user1pass';
CREATE USER 'read_user2'@'localhost' IDENTIFIED BY 'read_user2pass';
CREATE USER 'rw_user1'@'localhost' IDENTIFIED BY 'rw_user1pass';


GRANT 'app_developer' TO 'dev1'@'localhost';
GRANT 'app_read' TO 'read_user1'@'localhost', 'read_user2'@'localhost';
GRANT 'app_read', 'app_write' TO 'rw_user1'@'localhost';


-- Checking Role Privileges
SHOW GRANTS FOR 'dev1'@'localhost';
SHOW GRANTS FOR 'dev1'@'localhost' USING 'app_developer';




ALTER USER 'jeffrey'@'localhost' PASSWORD EXPIRE;

CREATE USER 'jeffrey'@'localhost' PASSWORD EXPIRE INTERVAL 90 DAY;
ALTER USER 'jeffrey'@'localhost' PASSWORD EXPIRE INTERVAL 90 DAY;


CREATE USER 'jeffrey'@'localhost' PASSWORD EXPIRE NEVER;
ALTER USER 'jeffrey'@'localhost' PASSWORD EXPIRE NEVER;

-- Dual Password Support
ALTER USER 'appuser1'@'host1.example.com'
IDENTIFIED BY 'password_b'
RETAIN CURRENT PASSWORD;

-- remove secondary password
ALTER USER 'appuser1'@'host1.example.com'
DISCARD OLD PASSWORD;

-- Random Password Generation
CREATE USER
'u1'@'localhost' IDENTIFIED BY RANDOM PASSWORD,
'u2'@'%.example.com' IDENTIFIED BY RANDOM PASSWORD,
'u3'@'%.org' IDENTIFIED BY RANDOM PASSWORD;


-- Failed-Login Tracking and Temporary Account Locking
CREATE USER 'u1'@'localhost' IDENTIFIED BY 'password'
FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 3;

ALTER USER 'u2'@'localhost'
FAILED_LOGIN_ATTEMPTS 4 PASSWORD_LOCK_TIME UNBOUNDED;

ALTER USER 'old_app_dev'@'localhost' ACCOUNT LOCK;


-- Getting Started with Multifactor Authentication
CREATE USER 'alice'@'localhost'
  IDENTIFIED WITH caching_sha2_password
    BY 'sha2_password'
  AND IDENTIFIED WITH authentication_ldap_sasl
    AS 'uid=u1_ldap,ou=People,dc=example,dc=com';