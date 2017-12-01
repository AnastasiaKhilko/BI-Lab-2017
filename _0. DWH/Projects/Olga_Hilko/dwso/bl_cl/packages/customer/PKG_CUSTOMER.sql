create or replace PACKAGE PKG_WRK_TO_3NF_CUST AS
/* PROCEDURE WRK_TO_CL_Cust_Org_Ind ;
 PROCEDURE SRC_TO_WRK_Indiv ;
 PROCEDURE SRC_TO_WRK_Org ;
 PROCEDURE CL_Customer_Type_Insert;
 PROCEDURE CL_TO_3NF_Customer_Type;
 PROCEDURE CL_To_3NF_Cust_Org_Ind;*/
 PROCEDURE WRK_to_3NF_CUST;
END PKG_WRK_TO_3NF_CUST;
/
create or replace PACKAGE BODY PKG_WRK_TO_3NF_CUST is --PKG_WRK_TO_CL_CUST.WRK_TO_CL_Indiv
procedure SRC_TO_WRK_Indiv
 is
 sql_stat varchar(400);
 before_cnt NUMBER;
 after_cnt NUMBER;
 table_name varchar(100):='WRK_CUSTOMER';
 table_name2 varchar(100):='WRK_INDIVIDUAL';
 begin

    -- FRAMEWORK.PKG_UTL.TRUNC_TAB(table_name);
     before_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);
     
     INSERT INTO WRK_CUSTOMER   (    CUSTOMER_NK,    ID_CUSTOMER_TYPE,    ID_LOCATION,    ADDRESS,    PHONE,
    POSTALCODE,    EMAIL,    START_DATE,    END_DATE  )
    SELECT --FRAMEWORK.pkg_utl_seq.seq_getval('BL_CL2.SEQ_BL_3NF_Customer_ID_CUST') ID_CUSTOMER, 
      NATIONALID as CUSTOMER_NK, 
      1 ID_CUSTOMER_TYPE,
      0 ID_LOCATION,
      STREETADDRESS as ADDRESS,
      TELEPHONENUMBER as PHONE,
      220000+trunc(to_number(substr(replace(TELEPHONENUMBER,' ',''),4,4))) POSTALCODE,--,
      c.EMAILADDRESS as EMAIL,
      to_date(STARTDATE,'mm/dd/yyyy') START_DATE,
      to_date(ENDDATE,'mm/dd/yyyy') END_DATE
    FROM  -- left join  BL_3NF2.INDIVIDUAL ind on c.ID_CUSTOMER=ind.ID_CUSTOMER;
     (select s.* from (select w.*, DENSE_RANK() OVER (partition by w.nationalid ORDER BY w.birthday DESC) r from src.SRC_INDIVIDUAL w) s where r=1) c;
     after_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);
     dbms_output.put_line('Lola: Inserted rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)');   
     
     
     
     table_name:=table_name2;
    -- FRAMEWORK.PKG_UTL.TRUNC_TAB(table_name);
     before_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);
     
      insert into WRK_INDIVIDUAL (CUSTOMER_NK,LAST_NAME,  FIRST_NAME, MIDDLE_NAME, 
      BIRTHDAY,   VEHICLE_DESC,VEHICLE_YEAR,  SEX )
    --BL_3NF2.INDIVIDUAL (ID_CUSTOMER, FIRST_NAME, LAST_NAME, MIDDLE_NAME,   BITRHDAY,   SEX)
    SELECT --c.ID_CUSTOMER, 
      NATIONALID as CUSTOMER_NK, 
      SURNAME as LAST_NAME,
      GIVENNAME as FIRST_NAME,
      MIDDLEINITIAL as MIDDLE_NAME,
      to_date(BIRTHDAY,'mm/dd/yyyy') BIRTHDAY_DATE,
      substr(VEHICLE,5,length(VEHICLE)) VEHICLE_DESC, 
      cast(substr(VEHICLE,0,4) as number) VEHICLE_YEAR,
      case when GENDER='male' then 1 when GENDER='female' then 2 end SEX
    FROM (select s.* from (select w.*, DENSE_RANK() OVER (partition by w.nationalid ORDER BY w.birthday DESC) r from src.SRC_INDIVIDUAL w) s where r=1) ;
    --ROLLBACK;
     after_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);
     dbms_output.put_line('Lola: Inserted rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)');
         
     
end SRC_TO_WRK_Indiv;
procedure SRC_TO_WRK_Org
 is
  --cursor cur is (select LONGITUDE,   LATITUDE, ID_DISTRICT,DISTRICT_NAME  from 
 --(select a.* ,dense_rank() over(partition by LONGITUDE,LATITUDE order by ID_DISTRICT ) r from CL_AZS_MAP_ADDRESS a) t where t.r=1);
-- TYPE t_address
  -- IS TABLE OF employees%ROWTYPE
    --  INDEX BY PLS_INTEGER;
  -- l_employees employees_aat;
 sql_stat varchar(400);
 before_cnt NUMBER;
 after_cnt NUMBER;
 table_name varchar(100):='WRK_CUSTOMER';
 table_name2 varchar(100):='WRK_ORGANIZATION';
 begin

    -- FRAMEWORK.PKG_UTL.TRUNC_TAB(table_name);
     before_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);
    INSERT INTO WRK_CUSTOMER   (    CUSTOMER_NK,    ID_CUSTOMER_TYPE,    ID_LOCATION,    ADDRESS,    PHONE,
    POSTALCODE,    EMAIL,    START_DATE,    END_DATE  )
    SELECT --FRAMEWORK.pkg_utl_seq.seq_getval('BL_CL2.SEQ_BL_3NF_Customer_ID_CUST') ID_CUSTOMER, 
      to_char(TAX) as CUSTOMER_NK, 
      2 ID_CUSTOMER_TYPE,
      0 ID_LOCATION,
      'nd' as ADDRESS,
      'nd' as PHONE,
      0 as POSTALCODE,--,
      'nd' as EMAIL,
      START_DATE,
      END_DATE
    FROM  src.SRC_ORG ;
     --(select s.* from (select w.*, DENSE_RANK() OVER (partition by w.nationalid ORDER BY w.birthday DESC) r from src.SRC_ORG w) s where r=1) c;
     after_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);
     dbms_output.put_line('Lola: Inserted rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)');   

     table_name:=table_name2;
      before_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);
       INSERT INTO WRK_ORGANIZATION   (  TAX_ID,    RUS_FULL_NAME,  --  CONTACT,    MANAGER_FIRST_NAME,    MANAGER_LAST_NAME,    MANAGER_MIDDLE_NAME,
       MNS_NAME,    MNS_NUM )
      SELECT to_char(TAX), trim(NAME),   
      substr(TAX_GOV,5,length(TAX_GOV)) MNS_DECS, to_number(substr(TAX_GOV,1,3)) MNS_ID FROM SRC.SRC_ORG ;
    --  rollback;
      --(select s.* from (select w.*, DENSE_RANK() OVER (partition by w.nationalid ORDER BY w.birthday DESC) r from src.SRC_INDIVIDUAL w) s where r=1) ;
    --ROLLBACK;
     after_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);
     dbms_output.put_line('Lola: Inserted rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)');
         
     
end SRC_TO_WRK_Org;    
procedure CL_Customer_Type_Insert
 is
 begin
 --CUSTOMER_TYPE
  insert into CL_CUSTOMER_TYPE (ID_CUSTOMER_TYPE, DESCRIPTION) values (1,'Физические лица');
  insert into CL_CUSTOMER_TYPE (ID_CUSTOMER_TYPE, DESCRIPTION) values (2,'Юридические лица');
 end CL_Customer_Type_Insert;
PROCEDURE CL_TO_3NF_Customer_Type
    IS
    before_err_cnt NUMBER;
    after_err_cnt NUMBER;
    table_name varchar2(50):='BL_3NF.CE_Customer_Type';
    src_table_name varchar2(50):='CL_Customer_Type';
    error_table varchar2(50):='BL_3NF.ERROR_CE_Customer_Type';
    sql_stmt varchar2(256);
    BEGIN
     before_err_cnt:=FRAMEWORK.PKG_UTL.get_row_count(error_table);
    
     INSERT INTO  BL_3NF.CE_Customer_Type --(ID_COUNTRY, COUNTRY_NAME, COUNTRY_CODE,  ID_PARENT,  DATE_UPDATE) 
     SELECT  * from CL_Customer_Type
    
     LOG ERRORS INTO BL_3NF.ERROR_CE_Customer_Type
     REJECT LIMIT UNLIMITED;
      after_err_cnt:=FRAMEWORK.PKG_UTL.get_row_count(error_table);
     -- SELECT count(1) INTO after_err_cnt FROM BL_3NF.ERROR_CE_Country;
      IF before_err_cnt != after_err_cnt THEN
        dbms_output.put_line('Lola: Insered rows in '||table_name ||' table:' || to_char(after_err_cnt-before_err_cnt) || ' row(s)');
      ELSE 
        dbms_output.put_line('Lola: No rows inserted in '||table_name );
      END IF; 
   
    END CL_TO_3NF_Customer_Type;
 
procedure WRK_TO_CL_Cust_Org_Ind
 is
 sql_stat varchar(400);
 before_cnt NUMBER;
 after_cnt NUMBER;
 table_name varchar(100):='CL_CUSTOMER';
 table_name3 varchar(100):='CL_INDIVIDUAL';
 table_name2 varchar(100):='CL_Organization';
 begin

before_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);
INSERT INTO Cl_CUSTOMER  (     CUSTOMER_NK,    ID_CUSTOMER_TYPE,    ID_LOCATION,    ADDRESS,    PHONE,
    POSTALCODE,    EMAIL,    start_DATE  )
SELECT CUSTOMER_NK,  ID_CUSTOMER_TYPE,  ID_LOCATION,  ADDRESS,  PHONE,  POSTALCODE,  EMAIL,  START_DATE
FROM wrk_CUSTOMER  where START_DATE is not null;
after_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);
dbms_output.put_line('Lola: Insered rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)');
table_name:=table_name2;
before_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);

INSERT INTO CL_ORGANIZATION  (    RUS_FULL_NAME,    TAX_ID,    MNS_NAME,    MNS_NUM  )
SELECT  RUS_FULL_NAME,    TAX_ID,   MNS_NAME,   MNS_NUM  FROM WRK_ORGANIZATION ;
after_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);
dbms_output.put_line('Lola: Insered rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)');
table_name:=table_name3;
before_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);

INSERT  INTO CL_INDIVIDUAL  (    CUSTOMER_NK,    FIRST_NAME,    LAST_NAME,    MIDDLE_NAME,    BIRTHDAY,    SEX,    VEHICLE_DESC,
    VEHICLE_YEAR  )
  SELECT CUSTOMER_NK,  FIRST_NAME,  LAST_NAME,  MIDDLE_NAME,  BIRTHDAY,  SEX,  VEHICLE_DESC,  VEHICLE_YEAR
FROM WRK_INDIVIDUAL ;
after_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);
dbms_output.put_line('Lola: Insered rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)');

end WRK_TO_CL_Cust_Org_Ind;
procedure CL_To_3NF_Cust_Org_Ind
 is
 sql_stat varchar(400);
 before_cnt NUMBER;
 after_cnt NUMBER;
 table_name varchar(100):='BL_3NF.CE_CUSTOMER';
 table_name2 varchar(100):='BL_3NF.CE_individual';
 table_name3 varchar(100):='BL_3NF.CE_ORGANIZATION';
 begin
before_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);
 MERGE INTO bl_3nf.ce_customer nf USING
        (  SELECT CUSTOMER_NK,  ID_CUSTOMER_TYPE,  ID_LOCATION,  ADDRESS,  PHONE,  POSTALCODE,  EMAIL,  START_DATE
          FROM   Cl_CUSTOMER  )     cls ON (
        cls.CUSTOMER_NK= nf.CUSTOMER_NK --and nf.start_date=cls.start_date
    ) WHEN MATCHED THEN
        UPDATE
            SET   
              nf.ID_CUSTOMER_TYPE=cls.ID_CUSTOMER_TYPE,    nf.ID_LOCATION=cls.ID_LOCATION,    nf.ADDRESS=cls.ADDRESS,   
              nf.PHONE=cls.PHONE,   nf.POSTALCODE=cls.POSTALCODE,    nf.EMAIL=cls.EMAIL,   nf.update_DATE=cls.start_DATE
            where  
            decode(cls.ID_CUSTOMER_TYPE,nf.ID_CUSTOMER_TYPE,0,1)+decode(cls.ID_LOCATION,nf.ID_LOCATION,0,1)+
            decode(cls.ADDRESS,nf.ADDRESS,0,1)+decode(cls.PHONE,nf.PHONE,0,1)+decode(cls.POSTALCODE,nf.POSTALCODE,0,1)+
            decode(cls.EMAIL,nf.EMAIL,0,1)>0
       WHEN NOT MATCHED THEN INSERT ( ID_CUSTOMER, CUSTOMER_NK,    ID_CUSTOMER_TYPE,    ID_LOCATION,    ADDRESS,    PHONE,
    POSTALCODE,    EMAIL,    update_DATE) VALUES
    (     FRAMEWORK.pkg_utl_seq.seq_getval('BL_3NF.SEQ_CE_Customer_ID'),
    cls.CUSTOMER_NK, cls.ID_CUSTOMER_TYPE,cls.ID_LOCATION,cls.ADDRESS,cls.PHONE,cls.POSTALCODE, cls.EMAIL,  cls.start_DATE);
 after_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);
dbms_output.put_line('Lola: Insered rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)');


table_name:=table_name2;
before_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);  
    
    MERGE INTO bl_3nf.ce_individual nf USING
        (  SELECT c.ID_CUSTOMER, i.CUSTOMER_NK, i.FIRST_NAME,    i.LAST_NAME,   i.MIDDLE_NAME,    i.BIRTHDAY,    i.SEX,
        i.VEHICLE_DESC,    i.VEHICLE_YEAR 
          FROM  cl_individual i inner join  bl_3nf.CE_CUSTOMER c on c.CUSTOMER_NK=i.CUSTOMER_NK)     cls ON (
        cls.CUSTOMER_NK= nf.CUSTOMER_NK --and nf.start_date=cls.start_date
    ) WHEN MATCHED THEN
        UPDATE
            SET   
              nf.FIRST_NAME=cls.FIRST_NAME,nf.LAST_NAME=cls.LAST_NAME,
              nf.MIDDLE_NAME=cls.MIDDLE_NAME, nf.BIRTHDAY=cls.BIRTHDAY, nf.SEX=cls.SEX,
              nf.VEHICLE_DESC=cls.VEHICLE_DESC,   nf.VEHICLE_YEAR=cls.VEHICLE_YEAR
            where  
            decode(nf.FIRST_NAME,cls.FIRST_NAME,0,1)+
            decode(nf.LAST_NAME,cls.LAST_NAME,0,1)+decode(nf.MIDDLE_NAME,cls.MIDDLE_NAME,0,1)+decode( nf.BIRTHDAY,cls.BIRTHDAY,0,1)+
            decode( nf.SEX,cls.SEX,0,1)+decode( nf.VEHICLE_DESC,cls.VEHICLE_DESC,0,1)+decode(nf.VEHICLE_YEAR,cls.VEHICLE_YEAR,0,1)>0
       WHEN NOT MATCHED THEN INSERT ( ID_CUSTOMER, CUSTOMER_NK,    FIRST_NAME,    LAST_NAME,    MIDDLE_NAME,    BIRTHDAY,    SEX, 
       VEHICLE_DESC,  VEHICLE_YEAR) VALUES
    (    cls.ID_CUSTOMER,   cls.CUSTOMER_NK, cls.FIRST_NAME,   cls.LAST_NAME,  cls.MIDDLE_NAME,    cls.BIRTHDAY,    cls.SEX,
        cls.VEHICLE_DESC,   cls.VEHICLE_YEAR);
 after_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);
dbms_output.put_line('Lola: Insered rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)');

table_name:=table_name3;
before_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);       
        MERGE INTO bl_3nf.ce_organization nf USING
        ( SELECT c.ID_CUSTOMER,
          i.RUS_FULL_NAME,    to_char(i.TAX_ID) as TAX_ID,    i.MNS_NAME,    i.MNS_NUM  
          FROM  cl_organization i inner join  bl_3nf.CE_CUSTOMER c on c.CUSTOMER_NK=to_char(i.TAX_ID))     cls ON (
        cls.TAX_ID= nf.TAX_ID 
        ) WHEN MATCHED THEN
        UPDATE
            SET   
               nf.RUS_FULL_NAME=cls.RUS_FULL_NAME,   nf.MNS_NAME=cls.MNS_NAME,   nf.MNS_NUM=cls.MNS_NUM  
            where  
              decode(nf.RUS_FULL_NAME,cls.RUS_FULL_NAME,0,1)+decode(nf.TAX_ID,cls.TAX_ID,0,1)+
              decode(nf.MNS_NAME,cls.MNS_NAME,0,1)+decode(nf.MNS_NUM,cls.MNS_NUM,0,1)>0
       WHEN NOT MATCHED THEN INSERT ( ID_CUSTOMER,  RUS_FULL_NAME,   TAX_ID,    MNS_NAME,    MNS_NUM  ) VALUES
    (    cls.ID_CUSTOMER,  cls.RUS_FULL_NAME,   cls.TAX_ID,    cls.MNS_NAME,    cls.MNS_NUM );   
 after_cnt:=FRAMEWORK.PKG_UTL.get_row_count(table_name);
 dbms_output.put_line('Lola: Insered rows in '||table_name ||' table:' || to_char(after_cnt-before_cnt) || ' row(s)');
 
 end CL_To_3NF_Cust_Org_Ind;

procedure WRK_to_3NF_CUST is
begin
   FRAMEWORK.PKG_UTL.TRUNC_TAB('WRK_Individual');
   FRAMEWORK.PKG_UTL.TRUNC_TAB('WRK_Organization');
   FRAMEWORK.PKG_UTL.TRUNC_TAB('WRK_Customer');
   FRAMEWORK.PKG_UTL.TRUNC_TAB('CL_Customer_Type');

   SRC_TO_WRK_Indiv;
   SRC_TO_WRK_Org;
  
   CL_Customer_Type_Insert;
   CL_TO_3NF_Customer_Type;
   
   FRAMEWORK.PKG_UTL.TRUNC_TAB('CL_CUSTOMER');
   FRAMEWORK.PKG_UTL.TRUNC_TAB('CL_INDIVIDUAL');
   FRAMEWORK.PKG_UTL.TRUNC_TAB('CL_Organization');
   WRK_TO_CL_Cust_Org_Ind;
   
   CL_To_3NF_Cust_Org_Ind;
   
end WRK_to_3NF_CUST;

END PKG_WRK_TO_3NF_CUST;
/
/*


DECLARE
   TYPE ids_t IS TABLE OF cl_AZS %ROWTYPE;

   l_ids   ids_t := ids_t (100, 200, 300);
BEGIN
   FORALL indx IN 1 .. l_ids.COUNT
   LOOP
      UPDATE plch_employees
         SET last_name = UPPER (last_name)
       WHERE employee_id = l_ids (indx);
   END LOOP;       
END;



PROCEDURE process_all_rows
IS
   TYPE employees_aat 
   IS TABLE OF employees%ROWTYPE
      INDEX BY PLS_INTEGER;
   l_employees employees_aat;
BEGIN
   SELECT *
   BULK COLLECT INTO l_employees
      FROM employees;
     
   FOR indx IN 1 .. l_employees.COUNT 
   LOOP
       analyze_compensation 
      (l_employees(indx));
   END LOOP;
END process_all_rows;




 CREATE OR REPLACE Function TotalIncome
   ( dep_id IN number ) return cursor
   IS
   total_val number(6);
   cursor c1 is (select * from HR.EMPLOYEES where DEPARTMENT_ID=dep_id);
 begin
   total_val := 0;

   FOR employee_rec in c1
   LOOP
      total_val := total_val + employee_rec.monthly_income;
   END LOOP;

   RETURN total_val;
 end;
 
 */