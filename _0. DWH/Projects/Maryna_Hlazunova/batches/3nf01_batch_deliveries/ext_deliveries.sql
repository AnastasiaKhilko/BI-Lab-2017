/**===============================================*\
Name...............:   External table ext_deliveries SA_SRC layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
drop table ext_deliveries;
--**********************************************
  create table ext_deliveries
   (nat_code varchar2(3 char), 
	delivery varchar2(100 char)
   ) 
   organization external 
    ( type oracle_loader
      default directory "EXT_SOURCES_DWH"
      access parameters
      ( records delimited by 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are null 
                (nat_code,
                 delivery )
                 )
      location
       ( 'wb_deliveries.txt'
       )
    )
   reject limit unlimited ;
--**********************************************
--select * from ext_deliveries;

