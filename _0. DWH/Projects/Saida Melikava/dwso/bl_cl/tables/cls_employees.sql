EXECUTE pckg_drop.drop_proc(object_name=>'cls_employees', object_type=>'table');
CREATE TABLE cls_employees
  (
    code       VARCHAR2 ( 200 CHAR ),
    surname    VARCHAR2 ( 200 CHAR ),
    name       VARCHAR2 ( 200 CHAR ),
    phone      VARCHAR2 ( 200 CHAR ),
    email      VARCHAR2 ( 200 CHAR ),
    dep_id VARCHAR2 ( 200 CHAR ),
    man_id VARCHAR2 ( 200 CHAR ),
    insert_DT        DATE DEFAULT(sysdate) NOT NULL ,
    update_DT        DATE DEFAULT('31-DEC_9999') NOT NULL,
    is_active AS (
    CASE
      WHEN update_DT=to_date('31-DEC-9999')
      THEN 'Y'
      ELSE 'N'
    END) 
  );
  
  