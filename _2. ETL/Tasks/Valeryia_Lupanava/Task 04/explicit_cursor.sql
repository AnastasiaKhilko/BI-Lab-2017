CREATE OR REPLACE PROCEDURE explicit_cursor
IS
BEGIN
declare
   cursor c_data is
    SELECT a.continent_id, b.continent_desc 
    FROM cls_continents a left outer join BL_3NF.CE_CONTINENTS b on
    a.continent_id = b.CONTINENT_SRCID;
   type t__data is table of c_data%rowtype index by binary_integer;
   t_data t__data;
begin
   open c_data;
   loop
      fetch c_data bulk collect into t_data;
      exit when t_data.count = 0;
      for idx in t_data.first .. t_data.last loop
         if t_data(idx).continent_desc is null then
      INSERT INTO BL_3NF.CE_CONTINENTS
      select BL_3NF.ce_continents_seq.NEXTVAL, continent_id, continent_desc from (
      (SELECT continent_id, continent_desc 
      FROM cls_continents
      MINUS
      SELECT a.continent_id, a.continent_desc 
      FROM cls_continents a, BL_3NF.CE_CONTINENTS b 
      where a.continent_id = b.CONTINENT_SRCID));
         else
            update BL_3NF.CE_CONTINENTS
               set continent_desc = t_data(idx).continent_desc
                   ;
         end if;
      end loop;

   end loop;
   close c_data;
end;
END; 
/
begin
explicit_cursor;
end;