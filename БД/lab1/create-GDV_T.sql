create table GDV_T (
    x number(3),
    s varchar(50)
);

drop table GDV_T;
--ex15

alter table GDV_T
add constraint PK_OF_GDV_T
primary key(x);