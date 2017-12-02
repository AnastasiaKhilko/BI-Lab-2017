set SERVEROUTPUT ON;
--connect BL_3NF/123456;
show user;

/*@fuel_and_payment_type.
bl_cl_payment_fuel_ddl_dml.sql*/

--fuel_and_payment_type

--BL_CL
connect BL_CL/123456;



EXEC PKG_WRK_TO_3NF_FUEL_TYPE.Fuel_Type_DML  ;  


exec BL_CL.PKG_WRK_TO_3NF_CUST.WRK_to_3NF_CUST;
--types to 3nf
exec BL_CL.PKG_WRK_TO_3NF_Fuel_Type.Fuel_Type_DML;
EXEC BL_CL.PKG_WRK_TO_3NF_Payment_Type.Payment_Type_DML;

--BL_3NF
connect BL_3NF/123456;
exec FRAMEWORK.PKG_UTL.TRUNC_TAB('BL_3nf.CE_PAYMENT');
exec FRAMEWORK.PKG_UTL.TRUNC_TAB('BL_3nf.CE_FUEL_TYPE');
delete * from BL_3nf.CE_FUEL_TYPE;

--fact generate
 connect BL_CL/123456;
 exec FRAMEWORK.PKG_UTL.TRUNC_TAB('BL_CL.cl_PAYMENT');
 EXEC PKG_FACT_PAYMENT.Generate;  
 --select count(*) from CL_PAYMENT;
  select * from bl_3nf.CE_FUEL_TYPE;
 EXEC PKG_FACT_PAYMENT.CL_TO_3NF  ;      
--commit;
rollback;
select * from BL_3nf.CE_Fuel_Type;
select * from BL_3nf.CE_PAyment;
--commit;
--generate dimDate
EXEC PKG_DWH_DIMDATE.Proc_DimDate_Recreate('DimDate', to_date('01.01.1990', 'DD.MM.YYYY'),  to_date('31.12.2030', 'DD.MM.YYYY'), TRUE);




--customers dml
exec PKG_WRK_TO_3NF_CUST.WRK_to_3NF_CUST;
commit;


/*DM*/
connect BL_CL_DM/123456;
exec FRAMEWORK.PKG_UTL.TRUNC_TAB('CL_PAYMENT_TYPE'); 
exec PKG_3NF_TO_DM_Payment_Type.Payment_Type_DML;

exec FRAMEWORK.PKG_UTL.TRUNC_TAB('cl_FUEL_TYPE');
exec PKG_3NF_TO_Fuel_Type.Fuel_Type_DML;
commit;
exec FRAMEWORK.PKG_UTL.TRUNC_TAB('cl_CUSTOMER');
exec PKG_3NF_TO_DM_CUSTOMER.CUSTOMER_DML;

exec FRAMEWORK.PKG_UTL.TRUNC_TAB('cl_AZS');
exec PKG_3NF_TO_DM_AZS.AZS_DML;


select count(*)from  BL_DM.DIMPAYMENT_TYPE;
commit;

exec PKG_FACT_PAYMENT.FACT_3NF_TO_DM;
select * from BL_DM.FCTPAYMENT;
--rollback;



@bl_3nf/bl_3nf_geo_ddl.sql;
@bl_3nf/BL_3NF_dim_tables_ddl.sql;