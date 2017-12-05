-----BL_CL------

EXECUTE pckg_drop.drop_proc(object_name=>'seq_reg_3nf', object_type=>'sequence');
CREATE SEQUENCE SEQ_REG_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

EXECUTE pckg_drop.drop_proc(object_name=>'seq_distr_3nf', object_type=>'sequence');
CREATE SEQUENCE SEQ_DISTR_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

EXECUTE pckg_drop.drop_proc(object_name=>'seq_cit_3nf', object_type=>'sequence');
CREATE SEQUENCE SEQ_CIT_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

EXECUTE pckg_drop.drop_proc(object_name=>'seq_genre', object_type=>'sequence');
CREATE SEQUENCE SEQ_GENRE INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
EXECUTE pckg_drop.drop_proc(object_name=>'seq_genre_3nf', object_type=>'sequence');
CREATE SEQUENCE SEQ_GENRE_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

EXECUTE pckg_drop.drop_proc(object_name=>'seq_auth', object_type=>'sequence');
CREATE SEQUENCE SEQ_AUTH INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
EXECUTE pckg_drop.drop_proc(object_name=>'seq_auth_3nf', object_type=>'sequence');
CREATE SEQUENCE SEQ_AUTH_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

EXECUTE pckg_drop.drop_proc(object_name=>'seq_categ_3nf', object_type=>'sequence');
CREATE SEQUENCE SEQ_CATEG_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

EXECUTE pckg_drop.drop_proc(object_name=>'seq_cat_3nf', object_type=>'sequence');
CREATE SEQUENCE SEQ_CAT_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

EXECUTE pckg_drop.drop_proc(object_name=>'seq_cust_3nf', object_type=>'sequence');
CREATE SEQUENCE SEQ_CUST_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

EXECUTE pckg_drop.drop_proc(object_name=>'seq_emp_3nf', object_type=>'sequence');

CREATE SEQUENCE SEQ_EMP_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

EXECUTE pckg_drop.drop_proc(object_name=>'seq_dep_3nf', object_type=>'sequence');
CREATE SEQUENCE SEQ_DEP_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

EXECUTE pckg_drop.drop_proc(object_name=>'seq_pay_3nf', object_type=>'sequence');
CREATE SEQUENCE SEQ_PAY_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

EXECUTE pckg_drop.drop_proc(object_name=>'seq_store_3nf', object_type=>'sequence');
CREATE SEQUENCE SEQ_STORE_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

EXECUTE pckg_drop.drop_proc(object_name=>'seq_addr', object_type=>'sequence');
CREATE SEQUENCE SEQ_ADDR INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;
EXECUTE pckg_drop.drop_proc(object_name=>'seq_addr_3nf', object_type=>'sequence');
CREATE SEQUENCE SEQ_ADDR_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;

/*EXECUTE pckg_drop.drop_proc(object_name=>'seq_fct_3nf', object_type=>'sequence');
CREATE SEQUENCE SEQ_FCT_3NF INCREMENT BY 1 START WITH 1 MINVALUE 1 NOCYCLE;*/