 CREATE OR REPLACE DIRECTORY ext_tables AS
  '/media/sf_D_DRIVE/SRC/';
  
  
    DROP TABLE src_customer;
    
CREATE TABLE src_customer (
                    ID NUMBER(10),
                    L_NAME VARCHAR2(200),
                    F_NAME VARCHAR2(200),
                    M_PHONE VARCHAR2(200),
                    E_MAIL VARCHAR2(200),
                    STREET VARCHAR2(200),
                    HOUSE VARCHAR2(200),
                    FLAT VARCHAR2(200),
                    PHONE VARCHAR2(200),
                    CITY_NAME VARCHAR2(200),
                    COUNTRY_NAME VARCHAR2(200),
                    COUNTRY_CODE VARCHAR2(200),
                    REGION_NAME VARCHAR2(200),
                    CONTINENT_NAME VARCHAR2(200)
                    )
  ORGANIZATION EXTERNAL
    (TYPE ORACLE_LOADER
    DEFAULT DIRECTORY ext_tables
    ACCESS PARAMETERS
      (RECORDS DELIMITED BY NEWLINE
      nobadfile nodiscardfile nologfile fields terminated by '	'
      missing field values are NULL (
        ID,
        L_NAME,
        F_NAME,
        M_PHONE,
        E_MAIL,
        STREET,
        HOUSE,
        FLAT,
        PHONE,
        CITY_NAME,
        COUNTRY_NAME,
        COUNTRY_CODE,
        REGION_NAME,
        CONTINENT_NAME
        )
      )
    LOCATION ('SRC_CUSTOMERS.tab')
    )
 reject LIMIT unlimited;
    
  
    
select * from src_customer;
    
select * from src_employees;


DROP TABLE src_employees;

CREATE TABLE src_employees (
                  ID NUMBER(30),
                  FIRST_NAME VARCHAR2(200),
                  LAST_NAME VARCHAR2(200),
                  M_PHONE VARCHAR2(200),
                  EMAIL VARCHAR2(200),
                  JOBS VARCHAR2(200),
                  SALARY NUMBER(30),
                  STREET VARCHAR2(200),
                  HOUSE VARCHAR2(200),
                  FLAT VARCHAR2(200),
                  PHONE VARCHAR2(200),
                  CITY_NAME VARCHAR2(200),
                  COUNTRY_NAME VARCHAR2(200),
                  COUNTRY_CODE VARCHAR2(200),
                  REGION_NAME VARCHAR2(200),
                  CONTINENT_NAME VARCHAR2(200)
                    )
  ORGANIZATION EXTERNAL
    (TYPE ORACLE_LOADER
    DEFAULT DIRECTORY ext_tables
    ACCESS PARAMETERS
      (RECORDS DELIMITED BY NEWLINE
      nobadfile nodiscardfile nologfile fields terminated by '	'
      missing field values are NULL (
        ID,
        FIRST_NAME,
        LAST_NAME,
        M_PHONE,
        EMAIL,
        JOBS,
        SALARY,
        STREET,
        HOUSE,
        FLAT,
        PHONE,
        CITY_NAME,
        COUNTRY_NAME,
        COUNTRY_CODE,
        REGION_NAME,
        CONTINENT_NAME 
        )
      )
    LOCATION ('SRC_EMPLOYEES.tab')
    )
 reject LIMIT unlimited;
