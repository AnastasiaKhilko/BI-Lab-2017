/**===============================================*\
Name...............:   dm_location
Contents...........:   dim creation
Author.............:   Hanna Klimovich
Date...............:   30.11.2017
\*=============================================== */
--DROP TABLE dm_location;
execute pckg_drop.DROP_Proc('dm_location','TABLE');
CREATE TABLE dm_location AS (SELECT st.state_num,
  st.dest_state_nm,
  ctr.country_name,
  rg.region_name
FROM bl_3nf.ce_state st
INNER JOIN bl_3nf.ce_country ctr
ON ctr.country_ID_SEQ = st.COUNTRY_NUM 
INNER JOIN bl_3nf.ce_region rg ON rg.region_id_seq = ctr.region_id
);
ALTER TABLE dm_location 
ADD CONSTRAINT state_num_pk PRIMARY KEY (state_num);
COMMENT ON TABLE dm_location
IS
  'Table Content: Describe content of a table.   
  Refresh Cycle/Window: Which places are in dwh?';
--GRANT SELECT ON dm_location TO new_user;
  COMMIT;
  
