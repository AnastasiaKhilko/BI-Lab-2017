-- USERS
DROP USER sa_src CASCADE;
DROP USER bl_cl CASCADE;
DROP USER bl_3nf CASCADE;
DROP USER bl_cl2 CASCADE;
DROP USER dwh CASCADE;

-- sa_src
CREATE USER sa_src IDENTIFIED BY 123456;
GRANT CREATE ANY DIRECTORY TO sa_src;
GRANT CONNECT TO sa_src;
GRANT CREATE TABLE TO sa_src;
GRANT CREATE ANY SYNONYM TO sa_src;
ALTER USER sa_src QUOTA UNLIMITED ON USERS;

-- bl_cl
CREATE USER bl_cl IDENTIFIED BY 123456;
GRANT ALL PRIVILEGES TO bl_cl;
GRANT CONNECT, RESOURCE TO bl_cl;

-- bl_3nf
CREATE USER bl_3nf IDENTIFIED BY 123456;
GRANT CREATE SESSION TO bl_3nf;

-- bl_cl2
CREATE USER bl_cl2 IDENTIFIED BY 123456;
GRANT ALL PRIVILEGES TO bl_cl2;

-- dwh
CREATE USER dwh IDENTIFIED BY 123456;