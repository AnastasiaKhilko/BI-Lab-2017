--==============================================================
-- Table: t_ext_passengers
--==============================================================    
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ext_passengers', Object_Type=>'TABLE');

CREATE TABLE ext_passengers (
    num_pass varchar2(10),
    give_name     VARCHAR2(100),
    middle_name VARCHAR2(30),
    last_name VARCHAR2(100),
    city varchar2(100),
    country_abbr varchar2(6),
    email varchar2(150),
    phone varchar2(50),
    birthday varchar2(30)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL (
                num_pass CHAR(10),
                give_name     CHAR(100),
                middle_name CHAR(30),
                last_name CHAR(100),
                city CHAR(100),
                country_abbr CHAR(6),
                email CHAR(150),
                phone CHAR(50),
                birthday CHAR(30)
            )
        ) LOCATION ( 'FakeName1.csv', 'FakeName1.csv' )
    ) REJECT LIMIT UNLIMITED;   