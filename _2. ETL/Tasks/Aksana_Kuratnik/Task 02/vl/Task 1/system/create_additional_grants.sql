BEGIN
  pkg_grants.USER_GRANT(GRANT_NAME => 'UNLIMITED TABLESPACE', USER_NAME => 'BL_CL_1ST');
END;
---------------------------------------------------------------------------------------------

BEGIN
  pkg_grants.USER_GRANT(GRANT_NAME => 'UNLIMITED TABLESPACE', USER_NAME => 'BL_DM');
END;
---------------------------------------------------------------------------------------------

BEGIN
  pkg_grants.USER_GRANT(GRANT_NAME => 'INSERT', SCHEMA_NAME => 'BL_DM', OBJECT_NAME => 'DIM_STORES', USER_NAME => 'BL_DM');
END;

---------------------------------------------------------------------------------------------

BEGIN
  pkg_grants.USER_GRANT(GRANT_NAME => 'INSERT', SCHEMA_NAME => 'BL_DM', OBJECT_NAME => 'DIM_CUSTOMERS_SCD', USER_NAME => 'BL_DM');
END;
---------------------------------------------------------------------------------------------

BEGIN
  pkg_grants.USER_GRANT(GRANT_NAME => 'INSERT', SCHEMA_NAME => 'BL_DM', OBJECT_NAME => 'DIM_EMPLOYEES_SCD', USER_NAME => 'BL_DM');
END;
---------------------------------------------------------------------------------------------

BEGIN
  pkg_grants.USER_GRANT(GRANT_NAME => 'INSERT', SCHEMA_NAME => 'BL_DM', OBJECT_NAME => 'DIM_PRODUCTS_SCD', USER_NAME => 'BL_DM');
END;
---------------------------------------------------------------------------------------------

BEGIN
  pkg_grants.USER_GRANT(GRANT_NAME => 'INSERT', SCHEMA_NAME => 'BL_DM', OBJECT_NAME => 'FCT_RETAIL_SALES_DD', USER_NAME => 'BL_DM');
END;