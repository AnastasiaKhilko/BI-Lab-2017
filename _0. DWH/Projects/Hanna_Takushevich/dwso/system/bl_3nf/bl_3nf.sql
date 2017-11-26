--==============================================================
-- USER: bl_3nf
--==============================================================

/**
* Drop user if he already exists
*/
execute pkg_drop_object.drop_proc(Object_Name=>'bl_3nf', Object_Type=>'USER');

/**
* Create user
*/
CREATE USER BL_3NF IDENTIFIED BY BL_3NF
    DEFAULT TABLESPACE users
    QUOTA UNLIMITED ON users
    TEMPORARY TABLESPACE temp
    PROFILE default;
	
/**
* Grants
*/
GRANT connect TO bl_3nf;
GRANT CREATE ANY TABLE to bl_3nf;
GRANT CREATE ANY SEQUENCE to bl_3nf
GRANT EXECUTE ON  pkg_drop_object TO bl_3nf;
GRANT CREATE PUBLIC SYNONYM TO bl_3nf;