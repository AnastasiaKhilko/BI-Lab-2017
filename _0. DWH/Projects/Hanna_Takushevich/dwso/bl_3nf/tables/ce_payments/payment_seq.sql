EXECUTE system.pkg_drop_object.drop_proc(Object_Name=>'payment_seq', Object_Type=>'SEQUENCE');
CREATE SEQUENCE payment_seq INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
GRANT
SELECT ON payment_seq TO bl_cl;
CREATE PUBLIC SYNONYM payment_seq FOR bl_3nf.payment_seq;