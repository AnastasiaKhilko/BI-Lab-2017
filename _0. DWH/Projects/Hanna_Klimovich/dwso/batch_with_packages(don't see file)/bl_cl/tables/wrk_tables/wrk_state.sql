--==============================================================
-- Table: wrk_state
--==============================================================
execute pckg_drop.DROP_Proc('wrk_state','TABLE');
CREATE TABLE wrk_state
  (
    state_num	NUMBER,
    DEST_STATE_NM VARCHAR2 ( 200 CHAR ),
    country_num NUMBER
  );
TRUNCATE TABLE wrk_state;
/*INSERT INTO wrk_state
SELECT * FROM SA_SRC.EXT_state;*/