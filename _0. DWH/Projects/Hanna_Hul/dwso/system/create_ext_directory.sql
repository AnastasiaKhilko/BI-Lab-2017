CREATE OR REPLACE DIRECTORY ext_source
AS '/media/sf_source_folder';

GRANT READ ON DIRECTORY ext_source TO sa_src;
GRANT READ ON DIRECTORY ext_source TO bl_cl;