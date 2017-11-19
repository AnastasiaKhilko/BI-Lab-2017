set SERVEROUTPUT ON;
--set SERVEROUTPUT off;

EXEC BL_CL.PKG_SRC_TO_WRK.SRC_TO_WRK;
COMMIT;
      
EXEC BL_CL.PKG_WKR_TO_CL.WRK_TO_CL_Continents;
EXEC BL_CL.PKG_WKR_TO_CL.WRK_TO_CL_Regions;
EXEC BL_CL.PKG_WKR_TO_CL.WRK_TO_CL_Countries;
commit;

--EXEC BL_CL.PKG_CL_TO_3NF.create_errorlogs(2);
EXEC BL_CL.PKG_CL_TO_3NF.CL_TO_3NF_Continents;
EXEC BL_CL.PKG_CL_TO_3NF.CL_TO_3NF_Regions;
EXEC BL_CL.PKG_CL_TO_3NF.CL_TO_3NF_Countries;
commit;

/*select * from BL_3NF.CONTINENTS;
select * from ERROR_Continents;
select * from BL_3NF.COUNTRIES;
select * from ERROR_COUNTRIES;
select * from BL_3NF.REGIONS;
select * from ERROR_REGIONS;*/