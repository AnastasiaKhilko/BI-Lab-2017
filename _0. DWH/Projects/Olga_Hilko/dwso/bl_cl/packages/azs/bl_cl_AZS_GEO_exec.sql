set SERVEROUTPUT ON;
/*load azs*/

exec  FRAMEWORK.PKG_UTL.TRUNC_TAB('wrk_AZS');
exec  FRAMEWORK.PKG_UTL.TRUNC_TAB('wrk_GEO');
  
exec  FRAMEWORK.PKG_UTL.TRUNC_TAB('Cl_AZS');
exec  FRAMEWORK.PKG_UTL.TRUNC_TAB('CL_MAP_AZS_ADDRESS');
  
exec  FRAMEWORK.PKG_UTL.TRUNC_TAB('CL_Location');
exec  FRAMEWORK.PKG_UTL.TRUNC_TAB('CL_District');
exec  FRAMEWORK.PKG_UTL.TRUNC_TAB('CL_Region');
exec  FRAMEWORK.PKG_UTL.TRUNC_TAB('CL_Country');
  
/*delete from BL_3NF.CE_AZS;
commit;*/


exec PKG_CL_TO_3NF_GEO.SRC_TO_WRK_AZS_GEO;
exec PKG_CL_TO_3NF_GEO.SRC_TO_CL_GEO;


exec PKG_CL_TO_3NF_GEO.CL_TO_3NF_Country ('BL_3NF.CE_Country','BL_3NF.ERROR_CE_Country');
exec PKG_CL_TO_3NF_GEO.CL_TO_3NF_Region ('BL_3NF.CE_Region','BL_3NF.ERROR_CE_Region');
exec PKG_CL_TO_3NF_GEO.CL_TO_3NF_District ('BL_3NF.CE_District','BL_3NF.ERROR_CE_District');
exec PKG_CL_TO_3NF_GEO.CL_TO_3NF_Location ('BL_3NF.CE_Location','BL_3NF.ERROR_CE_Location');

/*select * from CL_AZS_MAP_ADDRESS;
--select * from Cl_AZS;
select * from cl_Country;
select * from cl_Region;
select * from cl_District;

select * from bl_3NF.CE_Country;
select * from bl_3NF.CE_Region;
select * from BL_3NF.CE_District;
select * from BL_3NF.CE_Location;*/



exec PKG_CL_TO_3NF_GEO.CL_TO_3NF_AZS;

 
select * from BL_3NF.CE_AZS;