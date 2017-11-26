EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ext_payments', Object_Type=>'TABLE');

CREATE TABLE ext_payments
  (
    payment_code       VARCHAR2(15),
    service_class_name VARCHAR2(100),
    route_code         VARCHAR2(10),
    price              VARCHAR2(100)
  )
  ORGANIZATION EXTERNAL
  (
    TYPE oracle_loader DEFAULT DIRECTORY ext_references ACCESS PARAMETERS ( 
    RECORDS DELIMITED BY 
    NEWLINE 
    NOBADFILE 
    NODISCARDFILE 
    NOLOGFILE 
    FIELDS 
    TERMINATED BY ',' 
    MISSING FIELD VALUES ARE NULL 
    ( payment_code CHAR(15), service_class_name CHAR(100), route_code CHAR(10), price CHAR(100) ) ) LOCATION ( 'pay1.csv' )
  )
  REJECT LIMIT UNLIMITED; 