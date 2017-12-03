--framework for dropping objects
@D:\Hanna_Takushevich\dwso\frameworks\pkg_drop_object.sql

--create users
@D:\Hanna_Takushevich\dwso\system\sa_src\sa_src.sql
@D:\Hanna_Takushevich\dwso\system\bl_dm\bl_dm.sql
@D:\Hanna_Takushevich\dwso\system\bl_cl\bl_cl.sql
@D:\Hanna_Takushevich\dwso\system\bl_3nf\bl_3nf.sql

connect sa_src/SA_SRC;
show user;

@D:\Hanna_Takushevich\dwso\sa_src\init_directory.sql

@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_aircrafts\ext_aircrafts.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_aircrafts\ext_aircrafts-grants.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_aircrafts\ext_aircrafts-syn.sql

@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_airlines\ext_airlines.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_airlines\ext_airlines_grants.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_airlines\ext_airlines_syn.sql

@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_airports\ext_airports.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_airports\ext_airports_grants.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_airports\ext_airports_syn.sql

@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_flight_aircraft\ext_flight_aircraft.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_flight_aircraft\ext_flight_aircraft-grants.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_flight_aircraft\ext_flight_aircraft-syn.sql

@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_flights\ext_flights.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_flights\ext_flights-grants.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_flights\ext_flights-syn.sql

@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_geo_cities\ext_geo_cities.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_geo_cities\ext_geo_cities-grants.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_geo_cities\ext_geo_cities-syn.sql

@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_geo_countries\ext_geo_countries.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_geo_countries\ext_geo_countries-grants.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_geo_countries\ext_geo_countries-syn.sql

@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_geo_regions\ext_geo_regions.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_geo_regions\ext_geo_regions-grants.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_geo_regions\ext_geo_regions-syn.sql

@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_geo_subregions\ext_geo_subregions.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_geo_subregions\ext_geo_subregions-grants.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_geo_subregions\ext_geo_subregions-syn.sql

@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_passengers\ext_passengers.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_passengers\ext_passengers-grants.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_passengers\ext_passengers-syn.sql

@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_payments\ext_paynents.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_payments\ext_payments-grants.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_payments\ext_payments-syn.sql

@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_routes\ext_routes.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_routes\ext_routes-grants.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_routes\ext_routes-syn.sql

@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_service_classes\ext_service_classes.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_service_classes\ext_service_classes-grants.sql
@D:\Hanna_Takushevich\dwso\sa_src\external tables\ext_service_classes\ext_service_classes-syn.sql

connect bl_cl/BL_CL;
show user;

@D:\Hanna_Takushevich\dwso\bl_cl\tables\wrk_aircrafts\wrk_aircrafts.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\wrk_airlines\wrk_airlines.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\wrk_airports\wrk_airports.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\wrk_cities\wrk_cities.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\wrk_countries\wrk_countries.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\wrk_flight_aircraft\wrk_flight_aircraft.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\wrk_flights\wrk_flights.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\wrk_passengers\wrk_passengers.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\wrk_payments\wrk_payments.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\wrk_regions\wrk_regions.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\wrk_routes\wrk_routes.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\wrk_service_classes\wrk_service_classes.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\wrk_subregions\wrk_subregions.sql

@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_aircrafts\cls_aircrafts.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_airlines\cls_airlines.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_airports\cls_airports.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_cities\cls_cities.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_countries\clas_countries.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_flights\cls_flights.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_passengers\cls_passengers.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_payments\cls_payments.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_purchaces\cls_purchaces.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_regions\cls_regions.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_routes\cls_routes.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_service_classes\cls_service_classes.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_subregions\cls_subregions.sql

connect bl_3nf/BL_3NF;
show user;

@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_regions\ce_regions.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_regions\ce_regions-grants.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_regions\ce_regions-syn.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_regions\region_seq.sql

@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_subregions\ce_subregions.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_subregions\ce_subregions-grants.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_subregions\ce_subregions-syn.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_subregions\subregion_seq.sql

@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_countries\ce_countries.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_countries\ce_countries-grants.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_countries\ce_countries-syn.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_countries\country_seq.sql

@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_cities\ce_cities.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_cities\ce_cities-grants.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_cities\ce_cities-syn.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_cities\city_seq.sql

@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_airports\ce_airports.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_airports\ce_airports-grants.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_airports\ce_airports-syn.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_airports\airport_seq.sql

@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_routes\ce_routes.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_routes\ce_routes-grants.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_routes\ce_routes-syn.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_routes\route_seq.sql

@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_aircrafts\ce_aircrafts.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_aircrafts\ce_aircrafts-grants.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_aircrafts\ce_aircrafts-syn.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_aircrafts\aircraft_seq.sql

@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_airlines\ce_airlines.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_airlines\ce_airlines-grants.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_airlines\ce_airlines-syn.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_airlines\airline_seq.sql

@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_flights\ce_flights.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_flights\ce_flights-grants.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_flights\ce_flights-syn.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_flights\flight_seq.sql

@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_passengers\ce_passengers.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_passengers\ce_passengers-grants.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_passengers\ce_passengers-syn.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_passengers\passenger_seq.sql

@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_service_classes\ce_service_classes.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_service_classes\ce_service_classes-grants.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_service_classes\ce_service_classes-syn.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_service_classes\service_class_seq.sql

@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_payments\ce_payments.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_payments\ce_payments-grants.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_payments\ce_payments-syn.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_payments\payment_seq.sql

@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_purchaces\ce_purchaces.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_purchaces\ce_purchaces-grants.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_purchaces\ce_purchaces-syn.sql
@D:\Hanna_Takushevich\dwso\bl_3nf\tables\ce_purchaces\purchace_seq.sql




connect bl_cl/BL_CL;
show user;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_regions\pkg_etl_regions-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_regions\pkg_etl_regions-impl.sql
execute pkg_etl_regions.load_to_wrk;
execute pkg_etl_regions.load_to_cls;
execute pkg_etl_regions.load_to_3nf;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_subregions\pkg_etl_subregions-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_subregions\pkg_etl_subregions-impl.sql
execute pkg_etl_subregions.load_to_wrk;
execute pkg_etl_subregions.load_to_cls;
execute pkg_etl_subregions.load_to_3nf;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_countries\pkg_etl_countries-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_countries\pkg_etl_countries-impl.sql
execute pkg_etl_countries.load_to_wrk;
execute pkg_etl_countries.load_to_cls;
execute pkg_etl_countries.load_to_3nf;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_cities\pkg_etl_cities-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_cities\pkg_etl_cities-impl.sql
execute pkg_etl_cities.load_to_wrk;
execute pkg_etl_cities.load_to_cls;
execute pkg_etl_cities.load_to_3nf;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_airports\pkg_etl_airports-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_airports\pkg_etl_airports-impl.sql
execute pkg_etl_airports.load_to_wrk;
execute pkg_etl_airports.load_to_cls;
execute pkg_etl_airports.load_to_3nf;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_routes\pkg_etl_routes-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_routes\pkg_etl_routes-impl.sql
execute pkg_etl_routes.load_to_wrk;
execute pkg_etl_routes.load_to_cls;
execute pkg_etl_routes.load_to_3nf;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_aircrafts\pkg_etl_aircrafts-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_aircrafts\pkg_etl_aircrafts-impl.sql
execute pkg_etl_aircrafts.load_to_wrk;
execute pkg_etl_aircrafts.load_to_cls;
execute pkg_etl_aircrafts.load_to_3nf;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_airlines\pkg_etl_airlines-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_airlines\pkg_etl_airlines-impl.sql
execute pkg_etl_airlines.load_to_wrk;
execute pkg_etl_airlines.load_to_cls;
execute pkg_etl_airlines.load_to_3nf;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_flights\pkg_etl_flights-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_flights\pkg_etl_flights-impl.sql
execute pkg_etl_flights.load_to_wrk;
execute pkg_etl_flights.load_to_cls;
execute pkg_etl_flights.load_to_3nf;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_passengers\pkg_etl_passengers-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_passengers\pkg_etl_passengers-impl.sql
execute pkg_etl_passengers.load_to_wrk;
execute pkg_etl_passengers.load_to_cls;
execute pkg_etl_passengers.load_to_3nf;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_service_classes\pkg_etl_service_classes-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_service_classes\pkg_etl_service_classes-impl.sql
execute pkg_etl_service_classes.load_to_wrk;
execute pkg_etl_service_classes.load_to_cls;
execute pkg_etl_service_classes.load_to_3nf;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_payments\pkg_etl_payments-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_payments\pkg_etl_payments-impl.sql
execute pkg_etl_payments.load_to_wrk;
execute pkg_etl_payments.load_to_cls;
execute pkg_etl_payments.load_to_3nf;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_purchaces\pkg_etl_purchaces-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_purchaces\pkg_etl_purchaces-impl.sql
execute pkg_etl_purchaces.load_to_cls;
execute pkg_etl_purchaces.load_to_3nf;

@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_dim_airlnes\cls_dim_airlines.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_dim_airports\cls_dim_airports.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_dim_flights\cls_dim_flights.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_dim_passengers\cls_dim_passengers.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_dim_service_classes\cls_dim_service_classes.sql
@D:\Hanna_Takushevich\dwso\bl_cl\tables\cls_fact_purchaces\cls_fact_purchaces.sql

connect bl_dm/BL_DM;
show user;

@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_airlines\dim_airlines.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_airlines\dim_airlines_init.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_airlines\dim_airlines-grants.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_airlines\dim_airlines-syn.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_airlines\dim_airline_seq.sql

@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_airports\dim_airports.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_airports\dim_airports-init.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_airports\dim_airports-grants.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_airports\dim_airports-syn.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_airports\dim_airport_seq.sql

@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_date\dim_date.sql

@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_flights\dim_flights.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_flights\dim_flights-init.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_flights\dim_flights-grants.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_flights\dim_flights-syn.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_flights\dim_flights_seq.sql

@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_passengers\dim_passengers.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_passengers\dim_passengers-init.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_passengers\dim_passengers-grants.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_passengers\dim_passengers-syn.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_passengers\dim_passenger_seq.sql

@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_service_classes_scd\dim_service_classes_scd.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_service_classes_scd\dim_service_classes_scd-init.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_service_classes_scd\dim_service_classes_scd-grants.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_service_classes_scd\dim_service_classes_scd-syn.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\dim_service_classes_scd\dim_service_classes_scd_seq.sql

@D:\Hanna_Takushevich\dwso\bl_dm\tables\fact_purchaces\fact_purchaces.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\fact_purchaces\fact_purchaces-grants.sql
@D:\Hanna_Takushevich\dwso\bl_dm\tables\fact_purchaces\fact_purchaces-syn.sql

connect bl_cl/BL_CL;
show user;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_dim_airlines\pkg_etl_dim_airlines-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_dim_airlines\pkg_etl_dim_airlines-impl.sql
execute pkg_etl_dim_airlines.load_to_dim;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_dim_airports\pkg_etl_dim_airports-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_dim_airports\pkg_etl_dim_airports-impl.sql
execute pkg_etl_dim_airports.load_to_dim;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_dim_flights\pkg_etl_dim_airports-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_dim_flights\pkg_etl_dim_airports-impl.sql
execute pkg_etl_dim_flights.load_to_dim;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_dim_passengers\pkg_etl_dim_passengers-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_dim_passengers\pkg_etl_dim_passengers-impl.sql
execute pkg_etl_dim_passengers.load_to_dim;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_dim_service_classes\pkg_etl_dim_service_classes-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_dim_service_classes\pkg_etl_dim_service_classes-impl.sql
execute pkg_etl_dim_service_classes.load_to_dim;

@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_fact_purchaces\pkg_etl_fact_purchaces-def.sql
@D:\Hanna_Takushevich\dwso\bl_cl\packages\pkg_etl_fact_purchaces\pkg_etl_fact_purchaces-impl.sql
execute pkg_etl_fact_purchaces.load_to_fact;

