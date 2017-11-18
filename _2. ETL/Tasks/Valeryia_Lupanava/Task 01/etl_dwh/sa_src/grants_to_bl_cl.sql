BEGIN
  pkg_grants.user_grant(grant_name => 'SELECT', schema_name => 'SA_SRC_LAB', object_name => 'EXT_COUNTRIES', user_name => 'BL_CL_LAB');
END;

BEGIN
  pkg_grants.user_grant(grant_name => 'SELECT', schema_name => 'SA_SRC_LAB', object_name => 'EXT_STRUCTURES', user_name => 'BL_CL_LAB');
END;

BEGIN
  pkg_grants.user_grant(grant_name => 'SELECT', schema_name => 'SA_SRC_LAB', object_name => 'EXT_FULL_DATA', user_name => 'BL_CL_LAB');
END;

GRANT READ ON DIRECTORY external_tables TO bl_cl_lab;
