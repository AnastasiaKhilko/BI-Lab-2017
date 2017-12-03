--PKG_3NF_TO_DM_Payment_Type.Payment_Type_DML
CREATE OR REPLACE PACKAGE PKG_3NF_TO_DM_Payment_Type AS
    PROCEDURE Payment_Type_DML;
END PKG_3NF_TO_DM_Payment_Type;
/

CREATE OR REPLACE PACKAGE BODY PKG_3NF_TO_DM_Payment_Type AS
 PROCEDURE Payment_Type_DML
 IS
     sql_stat varchar(400);
     before_cnt NUMBER;
     after_cnt NUMBER;
     table_name varchar(100):='cl_PAYMENT_TYPE';
     table_name2 varchar(100):='BL_DM.DIMPayment_Type';
 begin
     before_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
 -- rollback;
    insert into cl_PAYMENT_TYPE
    SELECT 
    --1 PAYMENT_TYPE_SURR_ID,
    ID_SEQUENCE as ID3NF,  ID_PAYMENT_TYPE,  ENG_TYPE,  RUS_TYPE,  DESCRIPTION,
      START_DATE,  END_DATE,  IS_ACTIVE,  sysdate as insert_date
    FROM BL_3NF.CE_PAYMENT_TYPE ;
    
     after_cnt:=  FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
     dbms_output.put_line('Lola: Inserted rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)');
     table_name:=table_name2;
     before_cnt:= FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
    
   
   MERGE INTO bl_dm.DIMpayment_type dm USING
        ( SELECT   *   FROM   cl_payment_type )
    cls ON (
        cls.ID3NF= dm.ID3NF and dm.start_date=cls.start_date
    ) WHEN MATCHED THEN
        UPDATE
            SET  dm.ENG_TYPE=cls.ENG_TYPE,  dm.RUS_TYPE=cls.RUS_TYPE,   dm.DESCRIPTION=cls.DESCRIPTION, 
             dm.END_DATE=cls.START_DATE, dm.is_active=0 
            where  
            decode(dm.ENG_TYPE,cls.ENG_TYPE,0,1)+decode(dm.RUS_TYPE,cls.RUS_TYPE,0,1) +decode(dm.DESCRIPTION,cls.DESCRIPTION,0,1)>0
       WHEN NOT MATCHED THEN INSERT (
           PAYMENT_TYPE_SURR_ID ,ID3NF, ID_PAYMENT_TYPE,  ENG_TYPE,  RUS_TYPE,  DESCRIPTION,  START_DATE,  END_DATE,  IS_ACTIVE) VALUES
    (     FRAMEWORK.pkg_utl_seq.seq_getval('BL_DM.SEQ_DM_Payment_Type_ID'),
     cls.ID3NF, cls.ID_PAYMENT_TYPE,  cls.ENG_TYPE,  cls.RUS_TYPE,  cls.DESCRIPTION,  cls.START_DATE,  cls.END_DATE, cls.is_active);

    
      after_cnt:=  FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
      dbms_output.put_line('Lola: Inserted rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)');
  END Payment_Type_DML;
 
END PKG_3NF_TO_DM_Payment_Type;
/ 
