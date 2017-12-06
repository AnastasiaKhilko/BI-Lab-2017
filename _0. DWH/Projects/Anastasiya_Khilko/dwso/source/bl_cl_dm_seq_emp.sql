grant select on dim_employees to bl_cl_dm;
grant insert on dim_employees to bl_cl_dm;
grant update on dim_employees to bl_cl_dm;

create sequence seq_employees 
    increment by 1
    start with 1
    minvalue 1
    nocycle;

grant select on seq_employees to bl_cl_dm;