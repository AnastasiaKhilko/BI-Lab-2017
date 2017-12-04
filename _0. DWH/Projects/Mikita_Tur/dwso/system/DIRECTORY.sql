CREATE OR REPLACE DIRECTORY ext_sources_dwh AS '/media/sf_Mikita_Tur/exit_dwh';
GRANT READ ON DIRECTORY EXT_SOURCES_DWH TO SA_SRC;
GRANT READ ON DIRECTORY ext_sources_dwh TO bl_cl;