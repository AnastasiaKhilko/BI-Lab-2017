
-- sa_src
drop user sa_src_lab1;
create user sa_src_lab1 IDENTIFIED by "123456";


CREATE OR REPLACE DIRECTORY ext_references
AS
  '/media/sf_source_folder/';

GRANT READ ON DIRECTORY ext_references TO sa_src_lab1;
GRANT WRITE ON DIRECTORY ext_references TO sa_src_lab1;
GRANT create session TO sa_src_lab1;
GRANT create table  TO sa_src_lab1;
GRANT CREATE ANY PROCEDURE  TO sa_src_lab1;
GRANT SELECT ANY TABLE  TO sa_src_lab1;
GRANT UNLIMITED TABLESPACE to sa_src_lab1;