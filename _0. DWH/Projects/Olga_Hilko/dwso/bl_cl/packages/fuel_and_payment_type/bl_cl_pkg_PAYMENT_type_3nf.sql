--PKG_WRK_TO_3NF_Payment_Type.Payment_Type_DML
CREATE OR REPLACE PACKAGE PKG_WRK_TO_3NF_Payment_Type AS
    PROCEDURE Payment_Type_DML;
END PKG_WRK_TO_3NF_Payment_Type;
/

CREATE OR REPLACE PACKAGE BODY PKG_WRK_TO_3NF_Payment_Type AS
 PROCEDURE Payment_Type_DML
 IS
     sql_stat varchar(400);
     before_cnt NUMBER;
     after_cnt NUMBER;
     table_name varchar(100):='BL_3NF.ce_Payment_Type';
 begin
     before_cnt:= FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
     FRAMEWORK.PKG_UTL.TRUNC_TAB('wrk_Payment_Type');
    
    insert into wrk_PAYMENT_TYPE
    select * from src.src_PAYMENTTYPE;
    
    FRAMEWORK.PKG_UTL.TRUNC_TAB('cl_PAYMENT_TYPE');
    insert into cl_PAYMENT_TYPE
    SELECT ID_PAYMENT_TYPE , ENG_TYPE , RUS_TYPE , DESCRIPTION,
    to_date(START_DATE,'mm/dd/yyyy'), to_date(end_DATE,'mm/dd/yyyy'),case when dr=1 then 1 else 0 end is_active 
    from  (select ft.* , DENSE_RANK() over (partition by ID_PAYMENT_TYPE order by to_date(START_DATE,'mm/dd/yyyy') desc) dr from wrk_PAYMENT_TYPE  ft) 
    where
    ID_PAYMENT_TYPE is not null and  ENG_TYPE is not null and  RUS_TYPE is not null and DESCRIPTION is not null 
    and START_DATE is not null and END_DATE is not null;
    
    MERGE INTO bl_3nf.ce_payment_type nf USING
        ( SELECT   *   FROM   cl_payment_type cl  )
    cls ON (
        cls.ID_PAYMENT_TYPE= nf.ID_PAYMENT_TYPE and nf.start_date=cls.start_date
    ) WHEN MATCHED THEN
        UPDATE
            SET  nf.ENG_TYPE=cls.ENG_TYPE,  nf.RUS_TYPE=cls.RUS_TYPE,   nf.DESCRIPTION=cls.DESCRIPTION, 
             nf.END_DATE=cls.START_DATE, nf.is_active=0 
            where  
            decode(nf.ENG_TYPE,cls.ENG_TYPE,0,1)+decode(nf.RUS_TYPE,cls.RUS_TYPE,0,1)+decode(nf.DESCRIPTION,cls.DESCRIPTION,0,1)>0
       WHEN NOT MATCHED THEN INSERT ( ID_SEQUENCE, ID_PAYMENT_TYPE,  ENG_TYPE,  RUS_TYPE,  DESCRIPTION,  START_DATE,  END_DATE,  IS_ACTIVE) VALUES
    (     FRAMEWORK.pkg_utl_seq.seq_getval('BL_3NF.SEQ_CE_Payment_Type_ID'),
     cls.ID_PAYMENT_TYPE,  cls.ENG_TYPE,  cls.RUS_TYPE,  cls.DESCRIPTION,  cls.START_DATE,  cls.END_DATE, cls.is_active);
    
     after_cnt:=  FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
     dbms_output.put_line('Lola: Inserted rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)');
  END Payment_Type_DML;
 
END PKG_WRK_TO_3NF_Payment_Type;
/ 
