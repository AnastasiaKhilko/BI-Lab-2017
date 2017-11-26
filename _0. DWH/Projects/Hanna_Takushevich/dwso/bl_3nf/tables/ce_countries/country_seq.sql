EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'country_seq', Object_Type=>'SEQUENCE');
CREATE SEQUENCE country_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT
SELECT ON country_seq TO bl_cl;
CREATE PUBLIC SYNONYM country_seq FOR bl_3nf.country_seq;