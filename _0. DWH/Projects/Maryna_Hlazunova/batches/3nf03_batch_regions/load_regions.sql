SET SERVEROUTPUT ON

BEGIN
    bl_cl.pkg_load_3nf_regions.load_wrk_locations;
    bl_cl.pkg_load_3nf_regions.load_cls_regions;
    bl_cl.pkg_load_3nf_regions.load_ce_regions;
END;