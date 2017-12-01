--PKG_3NF_TO_Fuel_Type.Fuel_Type_DML
CREATE OR REPLACE PACKAGE PKG_3NF_TO_Fuel_Type AS
    PROCEDURE Fuel_Type_DML;
END PKG_3NF_TO_Fuel_Type;
/


CREATE OR REPLACE PACKAGE BODY PKG_3NF_TO_Fuel_Type AS
 PROCEDURE Fuel_Type_DML
 IS
     sql_stat varchar(400);
     before_cnt NUMBER;
     after_cnt NUMBER;
     table_name varchar(100):='cl_FUEL_TYPE';
     table_name2 varchar(100):='BL_DM.DIMFUEL_Type';
 begin
  before_cnt:= FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
  
  insert into cl_FUEL_TYPE
  SELECT 
      --1 FUEL_TYPE_SURR_ID,
      ID_SEQUENCE as ID3NF,  ID_FUEL_CODE,  ENG_TYPE,  RUS_TYPE,  DESCRIPTION,  START_DATE,
       END_DATE,  IS_ACTIVE,  sysdate as insert_date
  FROM BL_3NF.CE_FUEL_TYPE order by id_fuel_code ;
 
  after_cnt:= FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
  dbms_output.put_line('Lola: Inserted rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)'); 
  table_name:=table_name2;
  before_cnt:= FRAMEWORK.PKG_UTL.get_row_count(table_name) ;

  MERGE INTO bl_dm.DIMfuel_type dm USING
          ( SELECT   *   FROM   cl_fuel_type cl  )
      cls ON (
           cls.ID3NF= dm.ID3NF and dm.start_date=cls.start_date
      ) WHEN MATCHED THEN
          UPDATE
              SET  dm.ENG_TYPE=cls.ENG_TYPE,  dm.RUS_TYPE=cls.RUS_TYPE,   dm.DESCRIPTION=cls.DESCRIPTION, 
               dm.END_DATE=cls.START_DATE, dm.is_active=0 
              where  
              decode(dm.ENG_TYPE,cls.ENG_TYPE,0,1)+decode(dm.RUS_TYPE,cls.RUS_TYPE,0,1)+decode(dm.DESCRIPTION,cls.DESCRIPTION,0,1)>0
          WHEN NOT MATCHED THEN INSERT (FUEL_TYPE_SURR_ID ,ID3NF, ID_FUEL_CODE,  ENG_TYPE,  RUS_TYPE,  DESCRIPTION,  START_DATE,  END_DATE,  IS_ACTIVE) VALUES
      ( FRAMEWORK.pkg_utl_seq.seq_getval('BL_DM.SEQ_DM_Fuel_Type_ID'),
       cls.ID3NF, cls.ID_FUEL_CODE,  cls.ENG_TYPE,  cls.RUS_TYPE,  cls.DESCRIPTION,  cls.START_DATE,  cls.END_DATE, cls.is_active);
   --ROLLBACK;
       
   after_cnt:= FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
   dbms_output.put_line('Lola: Inserted rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)');
  end Fuel_Type_DML;
end PKG_3NF_TO_Fuel_Type;