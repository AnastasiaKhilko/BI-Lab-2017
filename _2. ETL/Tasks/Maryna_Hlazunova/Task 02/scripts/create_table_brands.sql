create table brands
(brand_id number(4) primary key,
brand_description varchar2(150)
);

insert into brands values(1, 'Louis Vuitton');
insert into brands values(2, 'Nike');
insert into brands values(3, 'Hermes');
insert into brands values(4, 'Zara');
insert into brands values(5, 'Paff-Dreams');
commit;


select * from brands;
