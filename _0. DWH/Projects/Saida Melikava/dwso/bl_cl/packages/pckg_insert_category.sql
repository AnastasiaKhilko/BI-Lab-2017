------------------------------------------------------------------------------
-- Author  : Melikava Saida
-- Created : 23/11/2017
-- Modified: 23/11/2017
-- Purpose : Insert data about categories from source to DWH.
------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE pckg_insert_category
AS
  PROCEDURE insert_bl_cls;
  PROCEDURE insert_bl_3NF;
END pckg_insert_category;
/
CREATE OR REPLACE PACKAGE BODY pckg_insert_category
AS
  /*************WRK->CLS****************/
  /*************************************/
PROCEDURE insert_bl_cls
IS
  sql_stmt_trunc   VARCHAR2(250);
  sql_stmt_insert1 VARCHAR2(950);
  sql_stmt_insert2 VARCHAR2(950);
BEGIN
  sql_stmt_trunc  :='TRUNCATE TABLE cls_category';
  sql_stmt_insert1:=q'<INSERT
INTO cls_category VALUES  
(    
'1',    
'Печатные книги',    
' 
В отличие от электронных книг, при чтении печатного издания наш мозг воспринимает поступающую информацию в несколько раз быстрее,
а значит и скорость чтения увеличивается.
'  
)
>';
sql_stmt_insert2:=q'< 
INSERT
INTO cls_category VALUES  
(    
'2',    
'Электронные книги',    
'Ваш дом превратился в филиал городской библиотеки? Освободите пространство для жизни.
Вы можете позволить себе иметь десятки тысяч любимых книг, но при этом они все уместятся на Вашей ладони.
'  
)>';
  EXECUTE immediate sql_stmt_trunc;
  EXECUTE immediate sql_stmt_insert1;
  EXECUTE immediate sql_stmt_insert2;
  dbms_output.put_line('Data in the table is successfully loaded: '||SQL%ROWCOUNT|| ' rows were inserted.');
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END;
/********CLS->3NF*************/
/*****************************/
PROCEDURE insert_bl_3NF
IS
BEGIN
  MERGE INTO bl_3nf.ce_categories ce USING
  ( SELECT category_name, category_desc FROM cls_category
  MINUS
  SELECT category_name, category_description FROM bl_3nf.ce_categories
  ) cls ON ( cls.category_name = ce.category_name )
WHEN MATCHED THEN
  UPDATE
  SET ce.category_description = cls.category_desc,
    ce.update_dt=sysdate 
    WHEN NOT MATCHED THEN
  INSERT
    (
      category_id ,
      category_name ,
      category_description
    )
    VALUES
    (
      seq_categ_3nf.nextval ,
      cls.category_name ,
      cls.category_desc
    ) ;
  COMMIT;
EXCEPTION
WHEN OTHERS THEN
  RAISE;
END;
END pckg_insert_category;
/
 
