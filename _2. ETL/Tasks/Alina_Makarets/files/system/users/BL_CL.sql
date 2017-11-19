-- Create a new user.
CREATE USER bl_cl IDENTIFIED BY "123" DEFAULT TABLESPACE tbs_pdb_test;

-- Grant Connect Role and Resource Role.
GRANT CONNECT TO  bl_cl;
GRANT RESOURCE TO  bl_cl;
