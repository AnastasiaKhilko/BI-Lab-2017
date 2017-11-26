BEGIN
  pkg_grants.user_grant(grant_name => 'CREATE ANY DIRECTORY', user_name => 'SA_SRC');
END;
------------------------------------------------------------------------------------------------------
BEGIN
  pkg_grants.USER_GRANT(GRANT_NAME => 'READ ON DIRECTORY external_geo_tables', USER_NAME => 'SA_SRC');
END;
------------------------------------------------------------------------------------------------------
BEGIN
  pkg_grants.USER_GRANT(GRANT_NAME => 'READ ON DIRECTORY external_cust_tables', USER_NAME => 'SA_SRC');
END;
------------------------------------------------------------------------------------------------------
BEGIN
  pkg_grants.USER_GRANT(GRANT_NAME => 'READ ON DIRECTORY external_emp_tables', USER_NAME => 'SA_SRC');
END;
------------------------------------------------------------------------------------------------------
BEGIN
  pkg_grants.USER_GRANT(GRANT_NAME => 'READ ON DIRECTORY external_ext_tables', USER_NAME => 'SA_SRC');
END;
------------------------------------------------------------------------------------------------------
BEGIN
  pkg_grants.USER_GRANT(GRANT_NAME => 'UNLIMITED TABLESPACE', USER_NAME => 'BL_3NF');
END;
------------------------------------------------------------------------------------------------------
BEGIN
  pkg_grants.USER_GRANT(GRANT_NAME => 'UNLIMITED TABLESPACE', USER_NAME => 'BL_CL_2ND');
END;
------------------------------------------------------------------------------------------------------


