--WRK_MANUFACTURERS_INSERT.
TRUNCATE TABLE WRK_MANUFACTURERS;
INSERT INTO WRK_MANUFACTURERS
SELECT * FROM SA_SRC.EXT_MANUFACTURERS;
COMMIT;
