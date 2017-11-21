EXEC grants_mgmt.grant_blat('CREATE ANY TABLE', 'BL_CL');
EXEC grants_mgmt.grant_blat('SELECT ANY TABLE', 'BL_CL');
EXEC grants_mgmt.grant_blat('READ,WRITE ON DIRECTORY ext_tables', 'BL_CL');
--Для выдачи данных грантов нужно заранее создать таблицы:
EXEC grants_mgmt.grant_blat ('SELECT', 'SA_SRC','ext_geo_countries_iso3166','BL_CL');
EXEC grants_mgmt.grant_blat ('SELECT', 'SA_SRC','ext_geo_structure_iso3166','BL_CL');
EXEC grants_mgmt.grant_blat ('SELECT', 'SA_SRC','ext_cntr2structure_iso3166','BL_CL');