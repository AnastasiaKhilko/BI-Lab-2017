CREATE OR REPLACE PACKAGE BODY pkg_insert_t AS 
  PROCEDURE table_insert AS
      BEGIN
        DELETE FROM ce_regions;
        DELETE FROM ce_countries;
        DELETE FROM ce_continents;
        DELETE FROM ce_world;
                
        INSERT INTO ce_world
          SELECT 
            seq_world.nextval AS world_id,
            parent_code AS word_code,
            child_code AS world_child_code,
            structure_desc AS world_desc
          FROM (
            SELECT     
              str.parent_code,
              str.child_code,
              str.structure_desc
            FROM cls_geo_structure str
              WHERE str.structure_level = 'World'
            );
        
        INSERT INTO ce_continents
          SELECT 
            seq_continent.nextval AS continent_id,
            parent_code AS continent_code,
            child_code AS continent_child_code,
            structure_desc AS continent_desc,
            world_id
          FROM (
            SELECT     
              str.parent_code,
              str.child_code,
              str.structure_desc,
              world_id
            FROM cls_geo_structure str
              INNER JOIN ce_world wrl ON wrl.world_child_code = str.parent_code  
              WHERE str.structure_level = 'Continents'
            );
            
        INSERT INTO ce_regions
          SELECT 
            seq_region.nextval AS region_id,
            parent_code AS region_code,
            child_code AS region_child_code,
            structure_desc AS region_desc,
            continent_id
          FROM (
            SELECT     
              str.parent_code,
              str.child_code,
              str.structure_desc,
              con.continent_id
            FROM cls_geo_structure str
            INNER JOIN ce_continents con ON con.continent_child_code = str.parent_code  
              WHERE str.structure_level = 'Regions'
            );
        
        INSERT INTO ce_countries
          SELECT 
            cntr.country_id,
            country_desc,
            country_code,
            region_id
          FROM cls_countries cntr
          INNER JOIN cls_structure c2s ON c2s.country_id = cntr.country_id
          INNER JOIN ce_regions reg ON reg.region_desc = c2s.structure_desc;
      COMMIT;
    END;
END pkg_insert_t;
/