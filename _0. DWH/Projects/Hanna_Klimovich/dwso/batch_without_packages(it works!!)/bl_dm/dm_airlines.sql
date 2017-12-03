/**===============================================*\
Name...............:   dm_airlines
Contents...........:   dim creation
Author.............:   Hanna Klimovich
Date...............:   30.11.2017
\*=============================================== */
--DROP TABLE dm_airlines;
execute pckg_drop.DROP_Proc('dm_airlines','TABLE');
CREATE TABLE dm_airlines
  (
    airlines_id_seq NUMBER NOT NULL,
    Airline_ID      NUMBER NOT NULL,
    a_name          VARCHAR2 ( 200 CHAR )NOT NULL,
    ICAO            VARCHAR2 ( 10 CHAR )PRIMARY KEY ,
    is_Active       VARCHAR2 ( 10 CHAR )
  );
INSERT INTO dm_airlines
SELECT * FROM BL_3NF.CE_airlines;
COMMENT ON TABLE dm_airlines
IS
  'Table Content: Describe content of a table.   
Refresh Cycle/Window: Which are airlines in discussion?   
';
--GRANT SELECT ON dm_airlines TO new_user;
COMMIT;