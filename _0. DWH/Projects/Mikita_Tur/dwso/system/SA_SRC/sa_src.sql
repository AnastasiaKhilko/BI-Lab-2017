CREATE USER SA_SRC IDENTIFIED BY Q1w2e3r4
DEFAULT TABLESPACE users 
QUOTA UNLIMITED ON users 
TEMPORARY TABLESPACE temp
PROFILE default;

GRANT CONNECT TO SA_SRC;
gRANT resource TO SA_SRC;