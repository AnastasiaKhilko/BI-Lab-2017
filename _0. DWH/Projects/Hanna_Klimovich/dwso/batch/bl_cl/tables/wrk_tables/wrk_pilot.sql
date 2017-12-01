--==============================================================
-- Table: wrk_pilot
--==============================================================
DROP TABLE wrk_pilot;
CREATE TABLE wrk_pilot
  (
    Pilot_Id     NUMBER,
    National_ID  VARCHAR2 ( 200 CHAR ),
    Name         VARCHAR2 ( 200 CHAR ),
    Surname      VARCHAR2 ( 200 CHAR ),
    Gender       VARCHAR2 ( 200 CHAR ),
    Age          NUMBER,
    City         VARCHAR2 ( 200 CHAR ),
    Country      VARCHAR2 ( 200 CHAR ),
    Hours_in_air NUMBER,
    begin_date   VARCHAR2 ( 200 CHAR ),
    end_date     VARCHAR2 ( 200 CHAR )
  );
TRUNCATE TABLE wrk_pilot;
INSERT INTO wrk_pilot
SELECT * FROM SA_SRC.EXT_PILOT;