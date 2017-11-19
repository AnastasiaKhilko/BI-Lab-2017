--Созадние пользователя bl_3nf

CREATE USER bl_3nf IDENTIFIED BY bl_3nf
    DEFAULT TABLESPACE users;

--Права для пользователя bl_3nf
GRANT connect TO bl_cl;
BEGIN
    pkg_grants.user_grant(
        grant_name    => 'select',
        schema_name   => 'bl_cl',
	object_name   => 'cls_cities'
        user_name     => 'bl_3nf'
    );
END;
BEGIN
    pkg_grants.user_grant(
        grant_name    => 'select',
        schema_name   => 'bl_cl',
	object_name   => 'cls_countries'
        user_name     => 'bl_3nf'
    );
END;
BEGIN
    pkg_grants.user_grant(
        grant_name    => 'select',
        schema_name   => 'bl_cl',
	object_name   => 'cls_regions'
        user_name     => 'bl_3nf'
    );
END;
BEGIN
    pkg_grants.user_grant(
        grant_name    => 'select',
        schema_name   => 'bl_cl',
	object_name   => 'cls_subregions'
        user_name     => 'bl_3nf'
    );
END;
