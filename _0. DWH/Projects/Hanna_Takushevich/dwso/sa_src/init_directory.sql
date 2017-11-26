--Create Directory with path to External References files storage
/*==============================================================*/
/* Directories: ext_references                                  */
/*==============================================================*/
CREATE OR REPLACE DIRECTORY ext_references AS '/media/sf_Hanna_Takushevich/sources';

GRANT READ ON DIRECTORY ext_references TO bl_cl;
