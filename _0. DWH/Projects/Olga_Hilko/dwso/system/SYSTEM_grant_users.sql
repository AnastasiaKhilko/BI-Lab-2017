
--GRANT EXECUTE ON grants_mgmt TO BL_3NF;
/*EXEC FRAMEWORK.PKG_UTL_GRANTS_MGMT.proc_grant ('create session', 'BL_CL');
EXEC FRAMEWORK.PKG_UTL_GRANTS_MGMT.proc_grant ('create any table', 'BL_CL');*/


--grant DBA to BL_CL;
--GRANT EXECUTE ON grants_mgmt TO BL_CL;



--revoke EXECUTE ON  FRAMEWORK.pkg_utl_drop from BL_CL;
--revoke EXECUTE ON  FRAMEWORK.pkg_utl_drop to system;



grant create session to FRAMEWORK;

grant create session to SRC;
grant create table to SRC with admin option;
grant create any directory to SRC ;
--???grant read on directory to SRC with admin option ;

grant create session to BL_CL;
grant create table to BL_CL;
grant create procedure to BL_CL;

grant create session to BL_3NF;
grant create table to BL_3NF with admin option;
grant create SEQUENCE to bl_3nf;

grant create session to BL_CL_DM;
grant create table to BL_CL_DM;
grant create procedure to BL_CL_DM;

grant create session to BL_DM;
grant create table to BL_DM with admin option;
grant create procedure to BL_DM;
grant create SEQUENCE to bl_dm;
