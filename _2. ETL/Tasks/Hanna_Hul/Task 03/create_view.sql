CREATE OR REPLACE VIEW GEO AS
SELECT  C.CONTINENT_ID as ID, 
        C.CONTINENT_NAME as NAME,
        Null as parent_id,
        '1' as level_id
FROM CE_CONTINENTS C
UNION ALL
SELECT  REGION_ID as ID,
        REGION_NAME as name,
        CONTINENT_ID as parent_id,
         '2' as level_id
FROM CE_REGIONS 
UNION ALL
SELECT  COUNTRY_ID as ID,
        COUNTRY_NAME as name, 
        REGION_ID as parent_id,
'3'as level_id
FROM CE_COUNTRIES;