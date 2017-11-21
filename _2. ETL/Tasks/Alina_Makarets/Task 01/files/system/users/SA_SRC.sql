-- Create a new user.
CREATE USER sa_src IDENTIFIED BY "123" DEFAULT TABLESPACE tbs_pdb_test;

-- Grant Connect Role and Resource Role.
GRANT CONNECT TO sa_src;
GRANT RESOURCE TO sa_src;