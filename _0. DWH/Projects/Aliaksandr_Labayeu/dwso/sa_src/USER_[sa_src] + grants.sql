CREATE USER sa_src IDENTIFIED BY 123456;
GRANT CREATE ANY DIRECTORY TO sa_src;
GRANT CONNECT TO sa_src;
GRANT CREATE TABLE TO sa_src;
GRANT CREATE ANY SYNONYM TO sa_src;
ALTER USER sa_src QUOTA UNLIMITED ON USERS;