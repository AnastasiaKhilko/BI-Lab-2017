-- SA_SRC
create user sa_src_lab1 IDENTIFIED by "123456";
--drop user sa_src_lab1;
-- BL_CL
create user bl_cl_lab1 IDENTIFIED by "123456";
drop user bl_cl_lab1;
-- BL_3NF
drop user bl_3nf_lab1;
create user bl_3nf_lab1 IDENTIFIED by "123456" ;

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
GRANT create session TO bl_cl_lab1;
GRANT create table  TO bl_cl_lab1;
GRANT CREATE ANY PROCEDURE  TO bl_cl_lab1;
GRANT SELECT ANY TABLE  TO bl_cl_lab1;
GRANT create synonym to bl_cl_lab1;
GRANT UNLIMITED TABLESPACE to bl_cl_lab1;

GRANT create session TO bl_3nf_lab1;
GRANT create table  TO bl_3nf_lab1;
GRANT CREATE ANY PROCEDURE  TO bl_3nf_lab1;
GRANT SELECT ANY TABLE  TO bl_3nf_lab1;
GRANT create synonym to bl_3nf_lab1;
GRANT UNLIMITED TABLESPACE to bl_3nf_lab1;
