--==============================================================
-- Table: t_ext_service_classes
--==============================================================    
EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'ext_service_classes', Object_Type=>'TABLE');

CREATE TABLE ext_service_classes (
    class_name     VARCHAR2(20),
    seat_letter VARCHAR2(1),
    menu VARCHAR2(50),
    max_luggage varchar2(3),
    class_desc varchar2(100)
)
    ORGANIZATION EXTERNAL ( TYPE oracle_loader
        DEFAULT DIRECTORY ext_references ACCESS PARAMETERS (
            RECORDS DELIMITED BY NEWLINE
                NOBADFILE
                NODISCARDFILE
                NOLOGFILE
            FIELDS TERMINATED BY '	' MISSING FIELD VALUES ARE NULL (
                class_name     CHAR(20),
                seat_letter CHAR(1),
                menu CHAR(50),
                max_luggage CHAR(3),
                class_desc CHAR(100)
            )
        ) LOCATION ( 'serv_classes.txt' )
    ) REJECT LIMIT UNLIMITED;   