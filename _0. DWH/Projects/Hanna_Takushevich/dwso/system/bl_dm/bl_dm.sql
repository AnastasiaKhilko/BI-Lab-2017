--==============================================================
-- USER: bl_dm
--==============================================================

/**
* Drop user if he already exists
*/
execute pkg_drop_object.drop_proc(Object_Name=>'bl_dm', Object_Type=>'USER');

/**
* Create user
*/
CREATE USER BL_DM IDENTIFIED BY BL_DM
    DEFAULT TABLESPACE users
    QUOTA UNLIMITED ON users
    TEMPORARY TABLESPACE temp
    PROFILE default;
	
/**
* Grants
*/
GRANT connect TO bl_dm;
GRANT CREATE ANY TABLE to bl_dm;
GRANT CREATE ANY SEQUENCE to bl_dm;
GRANT EXECUTE ON  pkg_drop_object TO bl_dm;
GRANT CREATE PUBLIC SYNONYM TO bl_dm;