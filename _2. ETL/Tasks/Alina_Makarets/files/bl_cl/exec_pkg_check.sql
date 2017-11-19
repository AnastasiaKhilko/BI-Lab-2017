EXEC PKG_ETL_GEO.load_worlds;
EXEC PKG_ETL_GEO.load_continents;
EXEC PKG_ETL_GEO.load_regions;
EXEC PKG_ETL_GEO.load_countries;

SELECT * FROM cl_world;
select * FROM cl_continents;
select * FROM cl_regions;
SELECT * FROM cl_countries;

commit;