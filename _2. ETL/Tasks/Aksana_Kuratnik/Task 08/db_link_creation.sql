CREATE PUBLIC DATABASE LINK test_link
CONNECT TO test_user IDENTIFIED BY test_user
USING '//localhost:1521/orcl';

select * from dual@test_link;