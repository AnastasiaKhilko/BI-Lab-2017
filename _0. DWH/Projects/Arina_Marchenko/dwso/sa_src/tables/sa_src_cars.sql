drop table cars;
CREATE TABLE cars
        (car_id number(6),
        car_number VARCHAR2 ( 200 CHAR ),
        car_name   VARCHAR2 ( 200 CHAR ),
        seller   VARCHAR2 ( 200 CHAR ),
        offer_type  VARCHAR2 ( 200 CHAR ),
        price   VARCHAR2 ( 200 CHAR ),
        abtest VARCHAR2 ( 200 CHAR ),
        vehicle_type  VARCHAR2 ( 200 CHAR ),
        yearregistr varchar2(200),
        gearbox varchar2(200),
        powerPS varchar2(200),
        model varchar2(200),
        km varchar2(200),
        mnthrepair varchar2(200),
        fueltype varchar2(200),
        brand varchar2(200),
        repairedstatus varchar2(200) ,
        postalcode varchar2(200),
        Registration_date varchar2(200)
         )
    ORGANIZATION EXTERNAL
        (TYPE ORACLE_LOADER
         DEFAULT DIRECTORY ext_tables
         ACCESS PARAMETERS
            (RECORDS DELIMITED BY 0x'0D0A'
             nobadfile nodiscardfile nologfile fields terminated by ','
             missing field values are NULL 
                (car_id integer external (6),
                car_number char (200),
                car_name   char (200),
				seller   char (200),
				offer_type  char (200),
				price  char (200),
				abtest char (200),
				vehicle_type char (200),
				yearregistr char (200),
				gearbox char (200),
				powerPS char (200),
				model char (200),
				km char (200),
				mnthrepair char (200),
				fueltype char (200),
				brand char (200),
				repairedstatus char (200),
				postalcode char (200),
				Registration_date CHAR(100) )
             )
         LOCATION ('cars_v2.csv')
    )
    reject LIMIT unlimited;
    select count (*) from cars;
    commit;
  
  GRANT SELECT ON cars to bl_cl;