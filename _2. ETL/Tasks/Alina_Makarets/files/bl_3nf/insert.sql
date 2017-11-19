INSERT INTO ce_worlds
                (world_id,
                 world_desc)
    SELECT  world_id,
            world_desc
    FROM bl_cl.cl_world;
    
INSERT INTO ce_continents
                (continent_id,
                 continent_desc,
                 world_id)        
    SELECT continent_id,
           continent_desc,
           world_id
    FROM bl_cl.cl_continents;

INSERT INTO ce_regions
                (region_id,
                 region_desc,
                 continent_id)        
    SELECT region_id,
           region_desc,
           continent_id
    FROM bl_cl.cl_regions;
    
INSERT INTO ce_countries
                (country_id,
                 country_desc,
                 country_code,
                 region_id)        
    SELECT  country_id,
            country_desc,
            country_code,
            region_id          
    FROM bl_cl.cl_countries;