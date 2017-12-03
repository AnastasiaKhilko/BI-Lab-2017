--Create Directory with path to External References files storage
/*==============================================================*/
/* Directories: ext_references                                  */
/*==============================================================*/
CREATE OR REPLACE DIRECTORY ext_sources_dwh AS 'd:\exit_task_dwh';

--==============================================================
-- Grants
--==============================================================
GRANT READ ON DIRECTORY ext_sources_dwh TO sa_src;
GRANT READ ON DIRECTORY ext_sources_dwh TO bl_cl;