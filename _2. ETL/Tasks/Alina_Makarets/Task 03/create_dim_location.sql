DROP VIEW dim_location;

CREATE VIEW dim_location AS
SELECT  to_number (Null) as child_id,
       'World' as Level_name,
        world_code  as parent_id,
        world_description as Name       
FROM ce_worlds
UNION ALL
SELECT  w.world_id as child_id,
        'Continent' as Level_name,
        c.continent_code as parent_id,
        continent_description as Name       
FROM ce_continents c JOIN ce_worlds w ON c.world_id=w.world_id
UNION ALL
SELECT c.continent_code as child_id,
       'Region' as Level_name,
       r.region_code as parent_id,
       r.region_description as Name
FROM ce_regions r JOIN ce_continents c ON r.continent_id=c.continent_id
UNION ALL
SELECT r.region_code as child_id,
       'Country' as Level_name,
       c.country_code as parent_id,
       c.country_description as Name
FROM CE_COUNTRIES c JOIN ce_regions r ON c.region_id=r.region_id;

SELECT * FROM dim_location;

