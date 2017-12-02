/**===============================================*\
Name...............:   dm_plane
Contents...........:   dim creation
Author.............:   Hanna Klimovich
Date...............:   30.11.2017
\*=============================================== */
--DROP TABLE dm_plane;
execute pckg_drop.DROP_Proc('dm_plane','TABLE');
CREATE TABLE dm_plane
  (
    plane_id_seq NUMBER PRIMARY KEY NOT NULL,
    model_name   VARCHAR2 (200 CHAR) NOT NULL,
    manufacturer VARCHAR2 (200 CHAR)NOT NULL,
    long_name    VARCHAR2 (200 CHAR),
    short_name   VARCHAR2 (200 CHAR),
    begin_date   VARCHAR2 (200 CHAR),
    end_date     VARCHAR2 (200 CHAR)
  );
INSERT INTO dm_plane
SELECT * FROM BL_3NF.CE_plane;
COMMENT ON TABLE dm_plane
IS
  'Table Content: Describe content of a table.   
Refresh Cycle/Window: Which vehicles are used to fly?  
';
--GRANT SELECT ON dm_plane TO new_user;
  COMMIT;