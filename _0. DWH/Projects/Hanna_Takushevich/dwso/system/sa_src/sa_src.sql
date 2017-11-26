--==============================================================
-- USER: sa_src
--==============================================================

/**
* Drop user if he already exists
*/
execute pkg_drop_object.drop_proc(Object_Name=>'sa_src', Object_Type=>'USER');

/**
* Create user
*/
CREATE USER SA_SRC IDENTIFIED BY SA_SRC
    DEFAULT TABLESPACE users
    QUOTA UNLIMITED ON users
    TEMPORARY TABLESPACE temp
    PROFILE default;
	
/**
* Grants
*/
GRANT connect TO sa_src;
GRANT CREATE ANY DIRECTORY TO sa_src;
GRANT CREATE ANY TABLE to sa_src;
GRANT EXECUTE ON  pkg_drop_object TO sa_src;
GRANT CREATE PUBLIC SYNONYM TO sa_src;