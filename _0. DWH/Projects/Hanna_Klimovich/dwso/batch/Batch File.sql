/* needed to be connected under user - system */
--to create user 
CONNECT system/123456;
show USER;
@sa_src\create_grant_user.sql
--to create directories and give grants
CONNECT system/123456;
show USER;
@sa_src\derictories\derictories.sql
@sa_src\external_tables\ext_grants.sql
--to create ext tables and load data from directories
CONNECT SA_SRC/123;
show USER;
@sa_src\external_tables\ext_airlines.sql
@sa_src\external_tables\ext_countries.sql
@sa_src\external_tables\ext_flight.sql
@sa_src\external_tables\ext_pilot.sql
@sa_src\external_tables\ext_plane.sql
@sa_src\external_tables\ext_state.sql
--to create tables on wrk and load data from ext to wrk
CONNECT BL_CL/123;
show USER;
@bl_cl\tables\wrk_tables\wrk_airlines.sql
@bl_cl\tables\wrk_tables\wrk_countries.sql
@bl_cl\tables\wrk_tables\wrk_flight.sql
@bl_cl\tables\wrk_tables\wrk_pilot.sql
@bl_cl\tables\wrk_tables\wrk_plane.sql
@bl_cl\tables\wrk_tables\wrk_state.sql
--to create tables on cl and load data from wrk to cl
CONNECT BL_CL/123;
show USER;
@bl_cl\tables\cl_tables\cl_table_creation.sql
@bl_cl\tables\cl_tables\cl_pilot.sql
@bl_cl\tables\cl_tables\cl_plane.sql
@bl_cl\tables\cl_tables\cl_region.sql
@bl_cl\tables\cl_tables\cl_country.sql
@bl_cl\tables\cl_tables\cl_state.sql
@bl_cl\tables\cl_tables\cl_airlines.sql
@bl_cl\tables\cl_tables\cl_flight.sql
--to create tables on 3nf
CONNECT BL_3NF/123;
show USER;
/*
----if this obects were created----
connect BL_3NF/123;
show user;
drop table ce_flight;
drop table ce_airlines;
drop table ce_state;
drop table ce_country;
drop table ce_region;
drop table ce_pilot;
drop table ce_plane;
drop sequence state_seq;
drop sequence airlines_seq;
drop sequence country_seq;
drop sequence pilot_seq;
drop sequence plane_seq;
drop sequence region_seq;
drop sequence flight_seq;
*/
@bl_3nf\ce_create_table\ce_airlines.sql
@bl_3nf\ce_create_table\ce_region.sql
@bl_3nf\ce_create_table\ce_country.sql
@bl_3nf\ce_create_table\ce_state.sql
@bl_3nf\ce_create_table\ce_pilot.sql
@bl_3nf\ce_create_table\ce_plane.sql
@bl_3nf\ce_create_table\ce_flight.sql
-- to merge data from cl to 3nf
CONNECT BL_CL/123;
show USER;
@bl_3nf\ce_insert_merge\m_region.sql
@bl_3nf\ce_insert_merge\m_country.sql
@bl_3nf\ce_insert_merge\m_state.sql
@bl_3nf\ce_insert_merge\m_plane.sql
@bl_3nf\ce_insert_merge\m_pilot.sql
@bl_3nf\ce_insert_merge\m_airlines.sql
@bl_3nf\ce_insert_merge\in_flight.sql
-- to load to dm
CONNECT BL_DM/123;
show USER;
@bl_dm\fact_delete.sql
@bl_dm\dm_airlines.sql
@bl_dm\dm_location.sql
@bl_dm\dm_pilot.sql
@bl_dm\dm_plane.sql
@bl_dm\f_flight.sql

