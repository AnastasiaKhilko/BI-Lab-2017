CREATE USER sa_src 
IDENTIFIED BY "123" 
DEFAULT TABLESPACE tbs_pdb_test;

--GRANT CONNECT TO sa_src;
--GRANT RESOURCE TO sa_src;
GRANT all privileges to sa_src;

CREATE USER bl_cl 
IDENTIFIED BY "123" 
DEFAULT TABLESPACE tbs_pdb_test;

--GRANT CONNECT TO  bl_cl;
--GRANT RESOURCE TO  bl_cl;
GRANT all privileges to bl_cl;

CREATE USER bl_3nf 
IDENTIFIED BY "123" 
DEFAULT TABLESPACE tbs_pdb_test;

--GRANT CONNECT TO bl_3nf;
--GRANT RESOURCE TO bl_3nf;
 GRANT all privileges to bl_3nf;


CREATE USER bl_dm 
IDENTIFIED BY "123" 
DEFAULT TABLESPACE tbs_pdb_test;

--GRANT CONNECT TO bl_dm;
--GRANT RESOURCE TO bl_dm;
GRANT all privileges to bl_dm;