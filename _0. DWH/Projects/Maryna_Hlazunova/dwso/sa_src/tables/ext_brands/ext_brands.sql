/**===============================================*\
Name...............:   External table ext_brands SA_SRC layer
Contents...........:   Create table description
Author.............:   Maryna Hlazunova
Date...............:   23-Nov-2017
\*=============================================== */
drop table ext_brands;
--**********************************************
  create table ext_brands
   (nat_code varchar2(6 char), 
	brand_desc varchar2(100 char)
   ) 
   organization external 
    ( type oracle_loader
      default directory "EXT_SOURCES_DWH"
      access parameters
      ( records delimited by 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ';'
             missing field values are null 
                (nat_code,
                 brand_desc )
                 )
      location
       ( 'wb_brands.txt'
       )
    )
   reject limit unlimited ;
--**********************************************
--select * from ext_brands;




