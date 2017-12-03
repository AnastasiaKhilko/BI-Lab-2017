SET SERVEROUTPUT ON

BEGIN
    bl_cl.pkg_load_3nf_districts.load_cls_districts;
    bl_cl.pkg_load_3nf_districts.load_ce_districts;
END;