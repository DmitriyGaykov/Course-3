-- ex11

insert into GDV_T(x, s) values (999, '999 Hello world');
insert into GDV_T(x, s) values (-999, '-999 Hello world');
insert into GDV_T(x, s) values (0, '0 Hello world');

commit;

-- ex12

update GDV_T
set s = 'Change Hello world'
where x >= 0;

commit;

-- ex13

select
    power(x, 2),
    s
from
    GDV_T
where x <= 0;

-- ex14

delete GDV_T where x = -999;
commit;

-- ex15

insert into GDV_T1 (FX) values (999);
insert into GDV_T1 (FX) values (999);

commit;

-- ex16

select
    *
from
    GDV_T join GDV_T1
        on x = FX;
----------------
select
    *
from
    GDV_T left join GDV_T1
        on x = FX;
----------------
select
    *
from
    GDV_T right join GDV_T1
        on S = 'Hello';

-- ex18

drop table GDV_T1;
drop table GDV_T;