--Create Directory with path to External References files storage
/*==============================================================*/
/* Directories: ext_references                                  */
/*==============================================================*/
CREATE OR REPLACE DIRECTORY ext_tables AS '/media/sf_shared_dwh';

--==============================================================
-- Grants
--==============================================================

GRANT READ ON DIRECTORY ext_tables TO bl_cl_test;