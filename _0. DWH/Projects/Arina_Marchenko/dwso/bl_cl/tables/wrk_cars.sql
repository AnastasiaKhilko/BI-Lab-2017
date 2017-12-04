drop table wrk_cars;

Create table wrk_cars (
car_number varchar2(200) not null,
car_name varchar2(200) not null,
reg_date date not null,
vehicle_type varchar2(200) DEFAULT ON NULL 'not defined',
engine_type varchar2(200) DEFAULT ON NULL 'not defined',
gearbox_type varchar2(200) DEFAULT ON NULL 'not defined',
model varchar2(200) DEFAULT ON NULL 'not defined',
brand varchar2(200) DEFAULT ON NULL 'not defined' ,
repaired_status varchar2(200) DEFAULT ON NULL 'not defined',
powerps number DEFAULT ON NULL '-98',
km number(6) DEFAULT ON NULL '-98'
);

