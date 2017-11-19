/*logical order*/
-- create users
-- grant users

-- framework_pkg
-- framework_grant

-- src_ddl
-- src_grant

-- bl_cl_ddl
-- bl_cl_grant

-- bl_3nf_ddl
-- bl_3nf_grant

-- bl_cl_pkg

-- bl_cl_pkg_call(main action, calls all packages)


/*connect SYSTEM/oracle;
show user;
@SYSTEM_drop_users.sql
@SYSTEM_create_users.sql
@SYSTEM_grant_users.sql */


connect FRAMEWORK/123456;
show user;
@FRAMEWORK_pkg.sql
@FRAMEWORK_grant.sql


connect SRC/123456;
show user;
@SRC_DDL.sql
@SRC_grant.sql
commit;

connect BL_CL/123456;
show user;
@BL_CL_DDL.sql
--@BL_CL_grant.sql

connect BL_3NF/123456;
show user;
@BL_3NF_DDL.sql
@BL_3NF_grant.sql

connect BL_CL/123456;
show user;
@BL_CL_PKG1.sql
@BL_CL_PKG2.sql
@BL_CL_PKG3.sql

connect BL_CL/123456;
show user;
@BL_CL_call_pkg.sql


select * from BL_3NF.CONTINENTS;
select * from ERROR_Continents;
select * from BL_3NF.COUNTRIES;
select * from ERROR_COUNTRIES;
select * from BL_3NF.REGIONS;
select * from ERROR_REGIONS;
select * from BL_3NF.COUNTRIES
where COUNTRY_CODE='CHI' or COUNTRY_CODE='SRK'
;