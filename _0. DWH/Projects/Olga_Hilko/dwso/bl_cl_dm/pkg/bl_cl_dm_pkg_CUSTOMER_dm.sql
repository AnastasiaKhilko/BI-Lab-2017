--PKG_3NF_TO_Fuel_Type.Fuel_Type_DML
CREATE OR REPLACE PACKAGE PKG_3NF_TO_DM_CUSTOMER AS
    PROCEDURE Customer_DML;
END PKG_3NF_TO_DM_CUSTOMER;
/


CREATE OR REPLACE PACKAGE BODY PKG_3NF_TO_DM_CUSTOMER AS
 PROCEDURE Customer_DML
 IS
     sql_stat varchar(400);
     before_cnt NUMBER;
     after_cnt NUMBER;
     table_name varchar(100):='cl_Customer';
     table_name2 varchar(100):='BL_DM.DIMCustomer';
 begin
  before_cnt:= FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
  
  insert into cl_CUSTOMER
  SELECT
       c.ID_CUSTOMER as ID3NF,   c.CUSTOMER_NK,  c.ID_CUSTOMER_TYPE,  ct.DESCRIPTION as CUSTOMER_TYPE_DESCRIPTION,
       c.ID_LOCATION,  c.ADDRESS,  c.PHONE,  c.POSTALCODE,  c.EMAIL, 
       
       case c.ID_CUSTOMER_TYPE when 1 then i.FIRST_NAME when 2 then 'na' end FIRST_NAME,  
       case c.ID_CUSTOMER_TYPE when 1 then i.LAST_NAME when 2 then 'na' end LAST_NAME,  
       case c.ID_CUSTOMER_TYPE when 1 then i.MIDDLE_NAME when 2 then 'na' end MIDDLE_NAME,   
       case c.ID_CUSTOMER_TYPE when 1 then i.BIRTHDAY when 2 then to_date('01/01/1900','mm/dd/yyyy') end BIRTHDAY,  
       case c.ID_CUSTOMER_TYPE when 1 then i.SEX when 2 then -98 end SEX,  
       case when c.ID_CUSTOMER_TYPE = 1 and i.VEHICLE_DESC is not null then i.VEHICLE_DESC 
            when c.ID_CUSTOMER_TYPE = 1 and i.VEHICLE_DESC is null then 'nd' 
            else 'na' end VEHICLE_DESC,  
       case when c.ID_CUSTOMER_TYPE = 1 and i.VEHICLE_YEAR is not null then i.VEHICLE_YEAR 
            when c.ID_CUSTOMER_TYPE = 1 and i.VEHICLE_YEAR is null then -99 
            else -98 end VEHICLE_YEAR,  
       case c.ID_CUSTOMER_TYPE when 2 then o.TAX_ID when 1 then 'na' end TAX_ID,
       case c.ID_CUSTOMER_TYPE when 2 then o.RUS_FULL_NAME when 1 then 'na' end RUS_FULL_NAME,
       case c.ID_CUSTOMER_TYPE when 2 then  o.MNS_NAME when 1 then 'na' end MNS_NAME,
       case c.ID_CUSTOMER_TYPE when 2 then  o.MNS_NUM when 1 then -98 end MNS_NUM,
       
       c.UPDATE_DATE, sysdate as insert_date
      FROM BL_3NF.CE_CUSTOMER c inner join BL_3NF.CE_CUSTOMER_TYPE ct on ct.ID_CUSTOMER_TYPE=c.ID_CUSTOMER_TYPE
      left join BL_3NF.CE_INDIVIDUAL i on i.ID_CUSTOMER=c.ID_CUSTOMER
      left join BL_3NF.CE_ORGANIZATION o on o.ID_CUSTOMER=c.ID_CUSTOMER
      --)
      ;
 
  after_cnt:= FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
  dbms_output.put_line('Lola: Inserted rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)'); 
  table_name:=table_name2;
  before_cnt:= FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
 
  MERGE INTO bl_dm.DIMCUSTOMER dm USING
          ( SELECT   *   FROM   cl_CUSTOMER cl  )
      cls ON (
           cls.ID3NF= dm.ID3NF 
      ) WHEN MATCHED THEN
          UPDATE
              SET  dm.ID_CUSTOMER_TYPE=cls.ID_CUSTOMER_TYPE, dm.CUSTOMER_TYPE_DESCRIPTION=cls.CUSTOMER_TYPE_DESCRIPTION, 
              dm.ID_LOCATION=cls.ID_LOCATION, dm.ADDRESS=cls.ADDRESS, 
              dm.PHONE=cls.PHONE, dm.POSTALCODE=cls.POSTALCODE, dm.EMAIL=cls.EMAIL, dm.FIRST_NAME=cls.FIRST_NAME, 
              dm.LAST_NAME=cls.LAST_NAME, dm.MIDDLE_NAME=cls.MIDDLE_NAME, dm.BIRTHDAY=cls.BIRTHDAY, 
              dm.SEX=cls.SEX, dm.VEHICLE_DESC=cls.VEHICLE_DESC, dm.VEHICLE_YEAR=cls.VEHICLE_YEAR, 
              dm.TAX_ID=cls.TAX_ID, dm.RUS_FULL_NAME=cls.RUS_FULL_NAME, dm.MNS_NAME=cls.MNS_NAME, 
              dm.MNS_NUM=cls.MNS_NUM, dm.UPDATE_DATE=cls.UPDATE_DATE 
          where  
               decode(dm.ID_CUSTOMER_TYPE,cls.ID_CUSTOMER_TYPE,0,1)+
               decode(dm.CUSTOMER_TYPE_DESCRIPTION,cls.CUSTOMER_TYPE_DESCRIPTION,0,1)+
               decode(dm.ID_LOCATION,cls.ID_LOCATION,0,1)+
               decode(dm.ADDRESS,cls.ADDRESS,0,1)+
               decode(dm.PHONE,cls.PHONE,0,1)+
               decode(dm.POSTALCODE,cls.POSTALCODE,0,1)+
               decode(dm.EMAIL,cls.EMAIL,0,1)+
               decode(dm.FIRST_NAME,cls.FIRST_NAME,0,1)+
               decode(dm.LAST_NAME,cls.LAST_NAME,0,1)+
               decode(dm.MIDDLE_NAME,cls.MIDDLE_NAME,0,1)+
               decode(dm.BIRTHDAY,cls.BIRTHDAY,0,1)+
               decode(dm.SEX,cls.SEX,0,1)+
               decode(dm.VEHICLE_DESC,cls.VEHICLE_DESC,0,1)+
               decode(dm.VEHICLE_YEAR,cls.VEHICLE_YEAR,0,1)+
               decode(dm.TAX_ID,cls.TAX_ID,0,1)+
               decode(dm.RUS_FULL_NAME,cls.RUS_FULL_NAME,0,1)+
               decode(dm.MNS_NAME,cls.MNS_NAME,0,1)+
               decode(dm.MNS_NUM,cls.MNS_NUM,0,1)>0
          WHEN NOT MATCHED THEN INSERT (CUSTOMER_SURR_ID,ID3NF, CUSTOMER_NK, ID_CUSTOMER_TYPE,
          CUSTOMER_TYPE_DESCRIPTION, ID_LOCATION, ADDRESS, PHONE, POSTALCODE, EMAIL, FIRST_NAME,
          LAST_NAME, MIDDLE_NAME, BIRTHDAY, SEX, VEHICLE_DESC, VEHICLE_YEAR, TAX_ID, RUS_FULL_NAME, 
          MNS_NAME, MNS_NUM, UPDATE_DATE, INSERT_DATE) VALUES
      ( FRAMEWORK.pkg_utl_seq.seq_getval('BL_DM.SEQ_DM_Fuel_Type_ID'),
       cls.ID3NF, cls.CUSTOMER_NK, cls.ID_CUSTOMER_TYPE, cls.CUSTOMER_TYPE_DESCRIPTION, cls.ID_LOCATION, 
       cls.ADDRESS, cls.PHONE, cls.POSTALCODE, cls.EMAIL, cls.FIRST_NAME, cls.LAST_NAME, cls.MIDDLE_NAME, 
       cls.BIRTHDAY, cls.SEX, cls.VEHICLE_DESC, cls.VEHICLE_YEAR, cls.TAX_ID, cls.RUS_FULL_NAME, 
       cls.MNS_NAME, cls.MNS_NUM, sysdate, sysdate);
       
   after_cnt:= FRAMEWORK.PKG_UTL.get_row_count(table_name) ;
   dbms_output.put_line('Lola: Inserted rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)');
  end Customer_DML;
end PKG_3NF_TO_DM_CUSTOMER;