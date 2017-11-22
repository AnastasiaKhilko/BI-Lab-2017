CREATE PUBLIC SYNONYM countries FOR BL_3NF.countries;
CREATE PUBLIC SYNONYM globals FOR BL_3NF.globals;
CREATE PUBLIC SYNONYM regions  FOR BL_3NF.regions;
CREATE PUBLIC SYNONYM continents FOR BL_3NF.continents;


GRANT EXECUTE ON sp_DATE_DIMENSION TO test_DWH;
grant create session, create procedure to  test_DWH identified by 123456;

exec system.grants_mgmt.grant_blat ('SELECT', 'BL_3NF','countries','test_DWH');
exec system.grants_mgmt.grant_blat ('SELECT', 'BL_3NF','globals','test_DWH');
exec system.grants_mgmt.grant_blat ('SELECT', 'BL_3NF','regions','test_DWH');
exec system.grants_mgmt.grant_blat ('SELECT', 'BL_3NF','continents','test_DWH');
exec system.grants_mgmt.grant_blat ('CREATE ANY VIEW', 'test_DWH');