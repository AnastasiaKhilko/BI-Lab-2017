show user;
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CL_Location', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CL_District', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CL_Region', 'TABLE');
exec  FRAMEWORK.pkg_utl_drop.proc_drop_obj ('CL_Country', 'TABLE');


create table CL_Country
(id_country NUMBER(10) ,--Primary key,
country_name varchar(100) not null,
country_code varchar(100) not null,
id_parent NUMBER(10),
date_update date not null
);


create table CL_Region
(id_region NUMBER(10) ,--Primary key,
region_name varchar(100) not null,
--is_town number(1) not null,
--region_center varchar(100) not null,
id_country NUMBER(10) not null,
date_update date not null
--constraint FK_Region_Country FOREIGN KEY (id_country) REFERENCES CL_Country (id_country)  
);

create table CL_District
(id_district NUMBER(10),-- Primary key,
district_name varchar(100) not null,
--is_town number(1) not null,
id_region NUMBER(10)  not null,
date_update date not null
--,constraint FK_District_Region FOREIGN KEY (id_region) REFERENCES CL_Region (id_region)  
);

create table CL_Location
(id_location NUMBER(10),-- Primary key,
location_name varchar(100) not null,
is_sovet NUMBER(1)  not null,
id_parent NUMBER(10) not null,
date_update date not null
--,constraint FK_Location_Sovet FOREIGN KEY (id_parent) REFERENCES CL_District (id_district)  
);
 




