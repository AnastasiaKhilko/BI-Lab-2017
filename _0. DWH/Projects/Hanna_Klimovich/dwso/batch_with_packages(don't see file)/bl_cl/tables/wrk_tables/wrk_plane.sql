--==============================================================
-- Table: wrk_plane
--==============================================================
execute pckg_drop.DROP_Proc('wrk_plane','TABLE');
CREATE TABLE wrk_plane
  (
    AC_TYPEID    NUMBER,
    SSD_NAME     VARCHAR2 ( 200 CHAR ),
    MANUFACTURER VARCHAR2 ( 200 CHAR ),
    LONG_NAME    VARCHAR2 ( 200 CHAR ),
    SHORT_NAME   VARCHAR2 ( 200 CHAR ),
    BEGIN_DATE   VARCHAR2 ( 200 CHAR ),
    END_DATE     VARCHAR2 ( 200 CHAR )
  );
TRUNCATE TABLE wrk_plane;
/*INSERT INTO WRK_PLANE
SELECT * FROM SA_SRC.EXT_PLANE;*/