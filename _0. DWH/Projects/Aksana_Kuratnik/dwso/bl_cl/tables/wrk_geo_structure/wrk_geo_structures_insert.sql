--INSERT TO WRK_GEO_STRUCTURES.
TRUNCATE TABLE WRK_GEO_STRUCTURES;
INSERT INTO WRK_GEO_STRUCTURES
SELECT * FROM SA_SRC.EXT_GEO_STRUCTURES;
commit;