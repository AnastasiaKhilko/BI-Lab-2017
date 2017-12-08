create or replace PACKAGE pkg_load_cust_dwh AS
    PROCEDURE load_cls2_cust;
    PROCEDURE load_dwh;
END pkg_load_cust_dwh;
/
create or replace PACKAGE BODY pkg_load_cust_dwh AS

PROCEDURE load_cls2_cust
        IS


    BEGIN


        EXECUTE IMMEDIATE 'truncate table cls_customers';

      insert  into cls_customers
      select customer_3nf_id,
        customer_id,
        gender,
        name,
        surname,
        title,
        email,
        telephone_number,
        age,
        age_group,
        birthday,
        occupation,
        company,
        ADDRESS ,-- number references dim_addresses(address_id),
        CITY_NAME ,
       nvl(COUNTRY_NAME,'n/a') as country_name,
       nvl(SUBREGION_NAME,'n/a') as SUBREGION_NAME,
        nvl(REGION_NAME,'n/a') as REGION_NAME,
        h.update_dt
        from bl_3nf.CE_customers h left join bl_3nf.CE_addresses ad
        on h.ADDRESS_ID = ad.ADDRESS_ID
        left join bl_3nf.CE_cities c on ad.CITY_ID  = c.CITY_3NF_ID
        left join bl_3nf.CE_countries cc on c.COUNTRY_ID = cc.COUNTRY_3NF_ID
        left join bl_3nf.CE_subregions r on cc.SUBREGION_ID = r.SUBREGION_3nf_ID
        left join bl_3nf.CE_regions ss on r.REGION_ID = ss.REGION_3NF_ID;
        
        commit;

       -- dbms_output.put_line('The data in the table WRK_PROD_TYPES is loaded successfully!');
        

    END load_cls2_cust;

PROCEDURE load_dwh
       IS
       begin
       MERGE INTO bl_dwh.dwh_customers d USING
( SELECT  customer_3nf_id,
        customer_id,
        gender,
        name,
        surname,
        title,
        email,
        telephone_number,
        age,
        age_group,
        birthday,
        occupation,
        company,
        ADDRESS ,-- number references dim_addresses(address_id),
        CITY_NAME ,
        COUNTRY_NAME,
        SUBREGION_NAME,
        REGION_NAME,
        update_dt FROM cls_customers
MINUS
SELECT  customer_3nf_id,
        customer_id,
        gender,
        name,
        surname,
        title,
        email,
        telephone_number,
        age,
        age_group,
        birthday,
        occupation,
        company,
        ADDRESS ,-- number references dim_addresses(address_id),
        CITY_NAME ,
        COUNTRY_NAME,
        SUBREGION_NAME,
        REGION_NAME,
        update_dt 
FROM bl_dwh.dwh_customers
) cls 
ON ( cls.customer_3nf_id = d.customer_3nf_id )
WHEN MATCHED THEN
  UPDATE
  SET 
        d.customer_id = cls.customer_id,
        d.gender = cls.gender,
        d.name = cls.name,
        d.surname = cls.surname,
        d.title = cls.title,
        d.email = cls.email,
        d.telephone_number = cls.telephone_number,
        d.age = cls.age,
        d.age_group = cls.age_group,
        d.birthday = cls.birthday,
        d.occupation = cls.occupation,
        d.company = cls.company,
        d.ADDRESS = cls.ADDRESS ,-- number references dim_addresses(address_id),
        d.CITY_NAME  = cls.CITY_NAME ,
        d.COUNTRY_NAME = cls.COUNTRY_NAME,
        d.SUBREGION_NAME = cls.SUBREGION_NAME,
        d.REGION_NAME = cls.REGION_NAME,
        d.update_dt  = cls.update_dt 
    WHEN NOT MATCHED THEN
  INSERT

    VALUES
    (
          bl_dwh.seq_hotels_dwh.nextval ,
          cls.customer_3nf_id,
        cls.customer_id,
        cls.gender,
        cls.name,
        cls.surname,
        cls.title,
        cls.email,
        cls.telephone_number,
        cls.age,
        cls.age_group,
        cls.birthday,
        cls.occupation,
        cls.company,
        cls.ADDRESS ,-- number references dim_addresses(address_id),
        cls.CITY_NAME ,
        cls.COUNTRY_NAME,
        cls.SUBREGION_NAME,
        cls.REGION_NAME,
        sysdate
    ) ;
    --end;
   commit;
    end load_dwh;


END pkg_load_cust_dwh;
/



select * from cls_customers;
exec pkg_load_cust_dwh.load_cls2_cust;
exec pkg_load_cust_dwh.load_dwh;