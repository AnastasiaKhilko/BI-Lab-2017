/**===============================================*\
Name...............:   dm_pilot
Contents...........:   dim creation
Author.............:   Hanna Klimovich
Date...............:   30.11.2017
\*=============================================== */
DROP TABLE dm_pilot;
CREATE TABLE dm_pilot
  (
    pilot_id_seq NUMBER PRIMARY KEY NOT NULL,
    pilot_id     NUMBER NOT NULL,
    national_id  VARCHAR2 (200 CHAR),
    p_name       VARCHAR2(200 CHAR),
    surname      VARCHAR2(200 CHAR),
    gender       VARCHAR2(200 CHAR),
    age          NUMBER,
    hours_in_air NUMBER
  );
INSERT INTO dm_pilot
SELECT * FROM BL_3NF.CE_PILOT;
COMMENT ON TABLE dm_pilot
IS
  'Table Content: Describe content of a table.   
Refresh Cycle/Window: Who rules the airplane?  
';
--GRANT SELECT ON dm_pilot TO new_user;
  COMMIT;