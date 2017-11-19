------------------ Procedure DML INSERT  
-- execute pkg_system.table_insert();
CREATE OR REPLACE PACKAGE pkg_system
  AUTHID CURRENT_USER as
  PROCEDURE table_insert;
END pkg_system;
/

CREATE OR REPLACE PACKAGE BODY pkg_system AS 
  PROCEDURE table_insert AS
      BEGIN
        DELETE FROM nf_regions;
        DELETE FROM nf_countries;
        DELETE FROM nf_continents;
        DELETE FROM nf_world;
                
        INSERT INTO nf_world
          SELECT 
            seq_world.nextval AS world_id,
            parent_code AS word_code,
            achild_code AS world_child_code,
            structure_desc AS world_desc
          FROM (
            SELECT     
              str.parent_code,
              str.achild_code,
              str.structure_desc
            FROM CLS_GEO_STRUCTURE str
              WHERE str.structure_level = 'World'
            );
        
        INSERT INTO nf_continents
          SELECT 
            seq_continent.nextval AS continent_id,
            parent_code AS continent_code,
            achild_code AS continent_child_code,
            structure_desc AS continent_desc,
            world_id
          FROM (
            SELECT     
              str.parent_code,
              str.achild_code,
              str.structure_desc,
              world_id
            FROM CLS_GEO_STRUCTURE str
              INNER JOIN nf_world wrl ON wrl.world_child_code = str.parent_code  
              WHERE str.structure_level = 'Continents'
            );
            
        INSERT INTO nf_regions
          SELECT 
            seq_region.nextval AS region_id,
            parent_code AS region_code,
            achild_code AS region_child_code,
            structure_desc AS region_desc,
            continent_id
          FROM (
            SELECT     
              str.parent_code,
              str.achild_code,
              str.structure_desc,
              con.continent_id
            FROM CLS_GEO_STRUCTURE str
            INNER JOIN nf_continents con ON con.continent_child_code = str.parent_code  
              WHERE str.structure_level = 'Regions'
            );
        
        INSERT INTO nf_countries
          SELECT 
            cntr.country_id,
            country_desc,
            country_code,
            region_id
          FROM CLS_GEO_countries cntr
          INNER JOIN cls_cntr2structure c2s ON c2s.country_id = cntr.country_id
          INNER JOIN nf_regions reg ON reg.region_desc = c2s.structure_desc;
      
      COMMIT;
    END;
END pkg_system;
/