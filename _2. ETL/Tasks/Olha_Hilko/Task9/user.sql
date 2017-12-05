-- Create a new user.

CREATE USER user_view 
IDENTIFIED BY 123456
DEFAULT TABLESPACE users;

-- Grant DBA, Connect Role and Resource Role.

GRANT CONNECT TO user_view;
GRANT RESOURCE TO user_view;
GRANT DBA TO user_view;