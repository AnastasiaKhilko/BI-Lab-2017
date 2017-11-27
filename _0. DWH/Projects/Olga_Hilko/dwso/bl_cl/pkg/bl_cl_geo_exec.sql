set SERVEROUTPUT ON;

exec PKG_CL_TO_3NF_GEO.CL_TO_3NF_Country ('BL_3NF.CE_Country','BL_3NF.ERROR_CE_Country');
exec PKG_CL_TO_3NF_GEO.CL_TO_3NF_Region ('BL_3NF.CE_Region','BL_3NF.ERROR_CE_Region');
exec PKG_CL_TO_3NF_GEO.CL_TO_3NF_District ('BL_3NF.CE_District','BL_3NF.ERROR_CE_District');
exec PKG_CL_TO_3NF_GEO.CL_TO_3NF_Location ('BL_3NF.CE_Location','BL_3NF.ERROR_CE_Location');
/*select * from BL_3NF.CE_Region;
select * from BL_3NF.ERROR_CE_Region;*/