  DROP TABLE cl_dim_seller CASCADE CONSTRAINTS;
  CREATE TABLE cl_dim_seller
    (
      seller_id   NUMBER(6) NOT NULL,
      seller_code NUMBER(6) NOT NULL,
      name        VARCHAR2(200) NOT NULL,
      surname     VARCHAR2(200) NOT NULL,
      phone       VARCHAR2(200) NOT NULL,
      email       VARCHAR2(200) NOT NULL,
      city_name     VARCHAR2(200) NOT NULL,
	  country_name     VARCHAR2(200) NOT NULL,
      update_dt   DATE NOT NULL
    );
		
  GRANT SELECT ON cl_dim_seller TO bl_dm;
  