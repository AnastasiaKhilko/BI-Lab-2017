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