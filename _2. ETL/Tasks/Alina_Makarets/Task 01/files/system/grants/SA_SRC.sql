
EXEC grants_mgmt.grant_blat('CREATE ANY TABLE', 'SA_SRC');
EXEC grants_mgmt.grant_blat('SELECT ANY TABLE', 'SA_SRC');
EXEC grants_mgmt.grant_blat('READ,WRITE ON DIRECTORY ext_tables', 'SA_SRC');
