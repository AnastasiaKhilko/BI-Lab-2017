CREATE USER test_DWH IDENTIFIED BY 123456;
  GRANT
CREATE session TO test_DWH;
  EXEC system.grants_mgmt.grant_blat('CREATE ANY TABLE', 'test_DWH');
  EXEC system.grants_mgmt.grant_blat('SELECT ANY TABLE', 'test_DWH');
ALTER USER test_DWH QUOTA 100M ON users;
GRANT UNLIMITED TABLESPACE TO test_DWH;