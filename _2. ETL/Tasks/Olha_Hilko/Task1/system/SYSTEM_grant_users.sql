
--GRANT EXECUTE ON grants_mgmt TO BL_3NF;
/*EXEC FRAMEWORK.PKG_UTL_GRANTS_MGMT.proc_grant ('create session', 'BL_CL');
EXEC FRAMEWORK.PKG_UTL_GRANTS_MGMT.proc_grant ('create any table', 'BL_CL');*/


--grant DBA to BL_CL;
--GRANT EXECUTE ON grants_mgmt TO BL_CL;



--revoke EXECUTE ON  FRAMEWORK.pkg_utl_drop from BL_CL;
--revoke EXECUTE ON  FRAMEWORK.pkg_utl_drop to system;



grant create session to FRAMEWORK;
grant DBA to FRAMEWORK;

--GRANT EXECUTE ON grants_mgmt TO BL_CL;
/*grant EXECUTE ON FRAMEWORK.pkg_utl_drop to Public;
grant EXECUTE ON FRAMEWORK.PKG_UTL_GRANTS_MGMT to PUBLIC;*/

/*
grant EXECUTE ON  FRAMEWORK.pkg_utl_drop to BL_CL;
grant EXECUTE ON  FRAMEWORK.PKG_UTL_GRANTS_MGMT to BL_CL;
exec FRAMEWORK.PKG_UTL_GRANTS_MGMT.proc_grant ('select', 'src','emp','BL_CL');
*/

grant create session to SRC;
GRANT DBA  TO SRC;
grant create table to SRC with admin option;
grant create any directory to SRC ;
--???grant read on directory to SRC with admin option ;
--revoke  DBA  from SRC;

grant create session to BL_CL;
grant create table to BL_CL;
grant create procedure to BL_CL;

grant create session to BL_3NF;
grant create table to BL_3NF with admin option;

