-- 1. Добавьте в таблицу TEACHERS два столбца BIRTHDAYи SALARY, заполните их значениями.

alter table teacher
  add birthday timestamp default CURRENT_TIMESTAMP;
alter table teacher
  add salary number default 1000;

select *
from TEACHER;

insert into teacher (teacher, teacher_name, pulpit, birthday, salary)
values ('T015', 'Крышталь Владислав Вечеславович', 'P001', TO_TIMESTAMP('2004-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        1900);

-- 2. Получите список преподавателей в виде Фамилия И.О.

CREATE OR REPLACE FUNCTION format_teacher_name(p_teacher_name VARCHAR2) RETURN VARCHAR2 IS
  v_last_name   VARCHAR2(50);
  v_first_name  VARCHAR2(50);
  v_middle_name VARCHAR2(50);
BEGIN
  -- Разбиваем полное имя на фамилию, имя и отчество
  v_last_name := SUBSTR(p_teacher_name, 1, INSTR(p_teacher_name, ' ') - 1);
  v_first_name := SUBSTR(p_teacher_name, INSTR(p_teacher_name, ' ') + 1,
                         INSTR(p_teacher_name, ' ', 1, 2) - INSTR(p_teacher_name, ' ') - 1);
  v_middle_name := SUBSTR(p_teacher_name, INSTR(p_teacher_name, ' ', 1, 2) + 1);

  -- Форматируем ФИО в виде "Фамилия И.О."
  RETURN INITCAP(v_last_name) || ' ' || INITCAP(SUBSTR(v_first_name, 1, 1)) || '.' ||
         INITCAP(SUBSTR(v_middle_name, 1, 1)) || '.';
END format_teacher_name;
/

select format_teacher_name(TEACHER_NAME), BIRTHDAY
from teacher;

-- 3. Получите список преподавателей, родившихся в понедельник.

select format_teacher_name(TEACHER_NAME),
       to_char(BIRTHDAY, 'DD.MM.YYYY')
from teacher
where to_char(BIRTHDAY, 'D') = '1';

-- 4. Создайте представление, в котором поместите список преподавателей, которые родились в следующем месяце.

create view teacher_next_month as
select format_teacher_name(TEACHER_NAME) as teacher_name,
       to_char(BIRTHDAY, 'DD.MM.YYYY')   as birthday
from teacher
where to_char(BIRTHDAY, 'MM') = to_char(sysdate, 'MM') + 1;

select *
from teacher_next_month;

-- 5. Создайте представление, в котором поместите количество преподавателей, которые родились в каждом месяце.

create global temporary table months
(
  month_name   varchar(20),
  month_number varchar(2)
) on commit preserve rows;

drop table months;

insert into months (month_name, month_number)
values ('Январь', '01');
insert into months (month_name, month_number)
values ('Февраль', '02');
insert into months (month_name, month_number)
values ('Март', '03');
insert into months (month_name, month_number)
values ('Апрель', '04');
insert into months (month_name, month_number)
values ('Май', '05');
insert into months (month_name, month_number)
values ('Июнь', '06');
insert into months (month_name, month_number)
values ('Июль', '07');
insert into months (month_name, month_number)
values ('Август', '08');
insert into months (month_name, month_number)
values ('Сентябрь', '09');
insert into months (month_name, month_number)
values ('Октябрь', '10');
insert into months (month_name, month_number)
values ('Ноябрь', '11');
insert into months (month_name, month_number)
values ('Декабрь', '12');

create view teacher_count_by_month as
select month_name,
       (select count(*) from TEACHER where to_char(birthday, 'MM') = month_number) as count
from months;

select *
from teacher_count_by_month;

-- 6. Создать курсор и вывести список преподавателей, у которых в следующем году юбилей.

declare
  cursor c1 is
    select format_teacher_name(TEACHER_NAME) as teacher_name,
           to_char(BIRTHDAY, 'DD.MM.YYYY')   as birthday
    from teacher
    where MOD((to_number(to_char(sysdate, 'YYYY')) - to_number(to_char(BIRTHDAY, 'YYYY')) + 1), 5) = 0;
begin
  for i in c1
    loop
      dbms_output.put_line(i.teacher_name || ' ' || i.birthday);
    end loop;
end;

-- 7. Создать курсор и вывести среднюю заработную плату по кафедрам с округлением вниз до целых,
-- вывести средние итоговые значения для каждого факультета и для всех факультетов в целом.

select *
from TEACHER;

select * from PULPIT;

select *
from FACULTY;
insert into PULPIT (PULPIT, PULPIT_NAME, FACULTY)
VALUES ('P003', 'Экономическая супер кафедра', 'F004');
insert into TEACHER (TEACHER, TEACHER_NAME, PULPIT, BIRTHDAY, SALARY)
VALUES ('T027', 'Смелов Григорий Григорьевич', 'P003', TO_TIMESTAMP('2004-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        100);

select * from TEACHER where PULPIT = 'P003';

declare
  cursor c1 is
    select distinct P.PULPIT,
                    F.FACULTY,
                    (select avg(T1.SALARY) from TEACHER T1 where T1.PULPIT = P.PULPIT)          as avg_pulpit_salary,
                    (select avg(T2.SALARY)
                     from TEACHER T2
                            join PULPIT P2 on T2.PULPIT = P2.PULPIT and F.FACULTY = P2.FACULTY) as avg_faculty_salary,
                    (select avg(T3.SALARY) from TEACHER T3)                                     as avg_all_salary
    from TEACHER
           join PULPIT P on P.PULPIT = TEACHER.PULPIT
           join FACULTY F on F.FACULTY = P.FACULTY;
begin
  for i in c1
    loop
      DBMS_OUTPUT.PUT_LINE('Faculty: ' || i.FACULTY || ' | Pulpit: ' || i.PULPIT || ' | Avg pulpit: ' ||
                           round(i.avg_pulpit_salary, 0) || ' | Avg faculty: ' || round(i.avg_faculty_salary, 0) ||
                           ' | Avg all faculty: ' || round(i.avg_all_salary, 0));
    end loop;
end;

-- 8. Создайте собственный тип PL/SQL-записи (record) и продемонстрируйте работу с ним.
-- Продемонстрируйте работу с вложенными записями. Продемонстрируйте и объясните операцию присвоения.

declare
  teacher_rec teacher%rowtype;
  type teacher_rec_type is record
                           (
                             teacher varchar(100),
                             salary  number
                           );
begin
  select *
  into teacher_rec
  from teacher
  where teacher = 'T001';

  select format_teacher_name(TEACHER_NAME), salary
  into teacher_rec.teacher, teacher_rec.salary
  from teacher
  where teacher = 'T001';

  dbms_output.put_line(teacher_rec.teacher_name);
  dbms_output.put_line(teacher_rec.salary);
end;
