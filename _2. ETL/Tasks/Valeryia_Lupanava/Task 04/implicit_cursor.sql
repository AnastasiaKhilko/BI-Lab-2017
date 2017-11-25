CREATE OR REPLACE PROCEDURE implicit_cursor
BEGIN   
    DECLARE
     CURSOR my_cursor IS
       SELECT a.continent_id as continent_id,
      a.continent_desc as continent_desc
    FROM cls_continents a
    LEFT OUTER JOIN BL_3NF.CE_CONTINENTS b
    ON a.continent_id = b.CONTINENT_SRCID
    WHERE b.CONTINENT_SRCID IS NULL;
   BEGIN
     FOR my_cursor_val IN my_cursor LOOP
       INSERT INTO BL_3NF.CE_CONTINENTS (continent_id, continent_srcid, continent_desc)
         VALUES (BL_3NF.ce_continents_seq.NEXTVAL, my_cursor_val.continent_id, my_cursor_val.continent_desc);
 
     END LOOP;
 
     COMMIT;
   END;
END;
/
begin
implicit_cursor;
end;