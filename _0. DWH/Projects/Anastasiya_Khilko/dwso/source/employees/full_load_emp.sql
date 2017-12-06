connect SA_SRC/123123;
show user;
@D:\epam\dwh\source\employees\ext_employees.sql
@D:\epam\dwh\source\employees\grant_ext_emp_to_bl_cl.sql


connect BL_CL/123456;
show user;
@D:\epam\dwh\source\employees\wrk_employees.sql
@D:\epam\dwh\source\employees\cls_employees.sql

connect BL_3NF/54321;
show user;
@D:\epam\dwh\source\employees\ce_employees.sql
@D:\epam\dwh\source\employees\grant_ce_emp_to_bl_cl.sql
@D:\epam\dwh\source\employees\seq_emp.sql

connect BL_CL/123456;
show user;
@D:\epam\dwh\source\employees\pkg_load_3nf_emp_def.sql
@D:\epam\dwh\source\employees\pkg_load_3nf_emp_impl.sql
@D:\epam\dwh\source\employees\load_emp.sql