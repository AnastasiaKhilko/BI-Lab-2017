--Create Directory with path to External References files storage
/*==============================================================*/
/* Directories: ext_references                                  */
/*==============================================================*/
CREATE OR REPLACE DIRECTORY ext_references AS 'D:\Epam\dwh\sources\geo';

GRANT READ ON DIRECTORY ext_references TO bl_cl;
GRANT WRITE ON DIRECTORY ext_references TO bl_cl;