--INSERT TO WRK_COUNTRIES.
TRUNCATE TABLE WRK_COUNTRIES;
INSERT INTO WRK_COUNTRIES
SELECT * FROM SA_SRC.EXT_COUNTRIES;
commit;