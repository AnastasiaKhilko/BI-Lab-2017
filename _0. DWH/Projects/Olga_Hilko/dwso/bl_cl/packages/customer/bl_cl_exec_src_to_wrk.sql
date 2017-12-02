set serveroutput on;
--select  FRAMEWORK.PKG_UTL.get_row_count('WRK_Individual') from dual;
exec  FRAMEWORK.PKG_UTL.TRUNC_TAB('WRK_Individual');
exec  FRAMEWORK.PKG_UTL.TRUNC_TAB('WRK_Organization');
exec  FRAMEWORK.PKG_UTL.TRUNC_TAB('WRK_Customer');
exec  FRAMEWORK.PKG_UTL.TRUNC_TAB('CL_Customer_Type');

exec PKG_WRK_TO_CL_CUST.SRC_TO_WRK_Indiv;
exec PKG_WRK_TO_CL_CUST.SRC_TO_WRK_Org;

exec PKG_WRK_TO_CL_CUST.CL_Customer_Type_Insert;
exec PKG_WRK_TO_CL_CUST.CL_TO_3NF_Customer_Type;

/*exec PKG_WRK_TO_CL_CUST.WRK_TO_CL_Indiv;
exec PKG_WRK_TO_CL_CUST.WRK_TO_CL_Org;*/
/*
select  FRAMEWORK.PKG_UTL.get_row_count('WRK_Organization') from dual;
select  FRAMEWORK.PKG_UTL.get_row_count('WRK_Individual') from dual;
select  FRAMEWORK.PKG_UTL.get_row_count('WRK_Customer') from dual;*/
