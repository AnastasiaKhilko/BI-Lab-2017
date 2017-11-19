CREATE OR REPLACE DIRECTORY ext_tables
AS
  '/media/sf_shared_dwh/';

GRANT READ ON DIRECTORY ext_tables TO SA_SRC;
GRANT WRITE ON DIRECTORY ext_tables TO SA_SRC;