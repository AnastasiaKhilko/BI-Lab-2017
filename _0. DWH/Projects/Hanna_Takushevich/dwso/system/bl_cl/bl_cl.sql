--==============================================================
-- USER: bl_cl
--==============================================================

/**
* Drop user if he already exists
*/
execute pkg_drop_object.drop_proc(Object_Name=>'bl_cl', Object_Type=>'USER');

/**
* Create user
*/
CREATE USER BL_CL IDENTIFIED BY BL_CL
    DEFAULT TABLESPACE users
    QUOTA UNLIMITED ON users
    TEMPORARY TABLESPACE temp
    PROFILE default;
	
/**
* Grants
*/
GRANT connect TO bl_cl;
GRANT CREATE ANY TABLE to bl_cl;
GRANT EXECUTE ON  pkg_drop_object TO bl_cl;
GRANT CREATE PROCEDURE to bl_cl;
GRANT CREATE PUBLIC SYNONYM TO bl_cl;