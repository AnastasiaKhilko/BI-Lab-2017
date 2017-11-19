
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','EXT_CNTR2STRUCTURE_ISO3166','BL_CL');

GRANT read ON DIRECTORY ext_tables TO BL_CL;

-- WRK_GEO_COUNTRIES_ISO3166,   WRK_GEO_STRUCTURE_ISO3166,    WRK_CNTR2STRUCTURE_ISO3166
-- EXT_GEO_COUNTRIES_ISO3166,   EXT_GEO_STRUCTURE_ISO3166,   EXT_CNTR2STRUCTURE_ISO3166
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','EXT_CNTR2STRUCTURE_ISO3166','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','EXT_GEO_STRUCTURE_ISO3166','BL_CL');
exec FRAMEWORK.pkg_utl_grants_mgmt.proc_grant ('select', 'SRC','EXT_GEO_COUNTRIES_ISO3166','BL_CL');
/*grant select on SRC.EXT_GEO_COUNTRIES_ISO3166 to BL_CL;
grant select on SRC.EXT_GEO_STRUCTURE_ISO3166 to BL_CL;
grant select on SRC.EXT_CNTR2STRUCTURE_ISO3166 to BL_CL;*/

 
