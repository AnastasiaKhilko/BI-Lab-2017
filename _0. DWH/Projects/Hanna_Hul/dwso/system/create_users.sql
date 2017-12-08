CREATE USER sa_src 
  IDENTIFIED BY 123456 
  DEFAULT TABLESPACE users 
  QUOTA UNLIMITED ON users; 
--  GRANT conn TO BL_CL;

CREATE USER BL_CL 
  IDENTIFIED BY 123456 
  DEFAULT TABLESPACE users 
  QUOTA UNLIMITED ON users; 
--  GRANT conn TO BL_CL;

grant create session to BL_CL;
grant DBA to BL_CL;

drop user bl_3nf;
CREATE USER BL_3NF 
  IDENTIFIED BY 123456 
  DEFAULT TABLESPACE users 
  QUOTA UNLIMITED ON users; 
--  GRANT conn TO BL_3NF;
grant create session to BL_3NF;
--GRANT EXECUTE ON grants_mgmt TO BL_3NF;

drop user bl_cl2;
create user bl_cl2 identified by 123456 default tablespace users;
GRANT UNLIMITED TABLESPACE TO bl_cl2;
grant create session to BL_cl2;
grant connect to bl_cl2;
grant resource to bl_cl2;
  
drop user bl_dwh;
create user bl_dwh identified by 123456 default tablespace users;
GRANT UNLIMITED TABLESPACE TO bl_dwh;
grant create session to BL_DWH;
grant connect to bl_dwh;
grant resource to bl_dwh;



