GRANT READ ON DIRECTORY EXT_TABLES_DWH TO BL_CL;
GRANT READ ON DIRECTORY EXT_TABLES_LOGS TO BL_CL;
GRANT write ON DIRECTORY EXT_TABLES_DWH TO BL_CL;
GRANT write ON DIRECTORY EXT_TABLES_LOGS TO BL_CL;
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','src_individual','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','src_org','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','src_azs','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','src_geo','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','src_fuelType','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','src_paymentType','BL_CL');
--exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','src_a','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','src_address','BL_CL');



/*GRANT READ ON DIRECTORY EXT_TABLES_DWH TO BL_CL2;
GRANT READ ON DIRECTORY EXT_TABLES_LOGS TO BL_CL2;
GRANT write ON DIRECTORY EXT_TABLES_DWH TO BL_CL2;
GRANT write ON DIRECTORY EXT_TABLES_LOGS TO BL_CL2;
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','src_individuals','BL_CL2');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','src_org','BL_CL2');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','SRC_AZS','BL_CL2');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','src_geo','BL_CL2');
 */