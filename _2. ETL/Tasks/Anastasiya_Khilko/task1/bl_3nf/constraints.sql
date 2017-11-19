ALTER TABLE ce_continents 
ADD FOREIGN KEY (world_id) REFERENCES ce_world (world_id) ON DELETE CASCADE;
ALTER TABLE ce_regions
ADD FOREIGN KEY (continent_id) REFERENCES ce_continents(continent_id) ON DELETE CASCADE;

ALTER TABLE ce_countries 
ADD FOREIGN KEY (region_id) REFERENCES ce_regions (region_id) ON DELETE CASCADE;