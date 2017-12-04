  DROP TABLE cl_dim_shop CASCADE CONSTRAINTS;
  CREATE TABLE cl_dim_shop
    (
      shop_id    NUMBER(6) NOT NULL,
      shop_code  NUMBER(6) NOT NULL,
      shop_name  VARCHAR2(200) NOT NULL,
      phone      VARCHAR2(200) NOT NULL,
      email      VARCHAR2(200) NOT NULL,
      address_name VARCHAR2(200) NOT NULL,
	  city_name VARCHAR2(200),
	  country_name VARCHAR2(200),
      update_dt  DATE NOT NULL
    );
  GRANT SELECT ON cl_dim_shop TO bl_dm;
  