create table GDV_T1 (
  fx number(3),
  cdate timestamp default CURRENT_TIMESTAMP,

  foreign key(fx) references GDV_T(x)
);

drop table GDV_T1;