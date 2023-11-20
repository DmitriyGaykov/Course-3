-- 1.	Создайте таблицу, имеющую несколько атрибутов, один из которых первичный ключ.

create table STUDENT
(
  STUDENT      varchar(20) primary key,
  STUDENT_NAME varchar(100) unique,
  PULPIT       varchar(20),
  foreign key (PULPIT) references PULPIT (PULPIT)
);

-- 2.	Заполните таблицу строками (10 шт.).

insert into STUDENT
values ('S001', 'Иванов Иван Иванович', 'P001');
insert into STUDENT
values ('S002', 'Петров Петр Петрович', 'P001');
insert into STUDENT
values ('S003', 'Сидоров Сидор Сидорович', 'P001');
insert into STUDENT
values ('S004', 'Гайков Дмитрий Викторович', 'P002');
insert into STUDENT
values ('S005', 'Кузнецов Александр Викторович', 'P002');
insert into STUDENT
values ('S006', 'Коренчук Андрей Васильевич', 'P003');
insert into STUDENT
values ('S007', 'Трубач Дмитрий Сергеевич', 'P003');
insert into STUDENT
values ('S008', 'Авсюкевич Полина Вадимовна', 'P003');
insert into STUDENT
values ('S009', 'Григорыч Дарья Сергеевна', 'P002');
insert into STUDENT
values ('S010', 'Кузнецова Анна Викторовна', 'P002');

select * from STUDENT;

-- 3.	Создайте BEFORE – триггер уровня оператора на события INSERT, DELETE и UPDATE.

grant create trigger to GDV;

create or replace trigger STUDENT_TRIGGER_OPERATORS_BEFORE
  before insert or delete or update
  on STUDENT
begin
  dbms_output.put_line('STUDENT_TRIGGER OPERATORS BEFORE');
end;

-- 4.	Этот и все последующие триггеры должны выдавать сообщение на серверную консоль (DMS_OUTPUT)
-- со своим собственным именем.

insert into STUDENT
values ('S011', 'Кузнецова Анна Викторовна', 'P002');

-- 5.	Создайте BEFORE-триггер уровня строки на события INSERT, DELETE и UPDATE.

create or replace trigger STUDENT_TRIGGER_ROW_BEFORE
  before insert or delete or update
  on STUDENT
  for each row
begin
  dbms_output.put_line('STUDENT_TRIGGER ROW BEFORE');
end;

update STUDENT
set STUDENT_NAME = STUDENT_NAME
where 0 = 0;

-- 6.	Примените предикаты INSERTING, UPDATING и DELETING.

create or replace trigger STUDENT_TRIGGER_ROW_BEFORE
  before insert or delete or update
  on STUDENT
  for each row
begin
  if inserting then
    dbms_output.put_line('STUDENT_TRIGGER ROW INSERTING BEFORE');
  elsif updating then
    dbms_output.put_line('STUDENT_TRIGGER ROW UPDATING BEFORE');
  elsif deleting then
    dbms_output.put_line('STUDENT_TRIGGER ROW DELETING BEFORE');
  end if;
end;

update STUDENT
set STUDENT_NAME = STUDENT_NAME
where 0 = 0;

-- 7.	Разработайте AFTER-триггеры уровня оператора на события INSERT, DELETE и UPDATE.

create or replace trigger STUDENT_TRIGGER_OPERATORS_AFTER
  after insert or delete or update
  on STUDENT
begin
  dbms_output.put_line('STUDENT_TRIGGER OPERATORS AFTER');
end;

update STUDENT
set STUDENT_NAME = STUDENT_NAME
where 0 = 0;

-- 8.	Разработайте AFTER-триггеры уровня строки на события INSERT, DELETE и UPDATE.

create or replace trigger STUDENT_TRIGGER_ROW_AFTER
  after insert or delete or update
  on STUDENT
  for each row
begin
  dbms_output.put_line('STUDENT_TRIGGER ROW AFTER');
end;

update STUDENT
set STUDENT_NAME = STUDENT_NAME
where 0 = 0;

-- 9.	Создайте таблицу с именем AUDIT. Таблица должна содержать поля: OperationDate,
-- OperationType (операция вставки, обновления и удаления),
-- TriggerName(имя триггера),

create table AUDIT_LOG
(
  OperationDate date,
  OperationType varchar(100),
  TriggerName   varchar(100)
);

-- 10.	Измените триггеры таким образом, чтобы они регистрировали все операции с
-- исходной таблицей в таблице AUDIT.

create or replace trigger STUDENT_TRIGGER_OPERATORS_BEFORE
  before insert or delete or update
  on STUDENT
begin
  insert into AUDIT_LOG values (sysdate, 'STUDENT_TRIGGER OPERATORS BEFORE', 'STUDENT_TRIGGER_OPERATORS_BEFORE');
end;

create or replace trigger STUDENT_TRIGGER_ROW_BEFORE
  before insert or delete or update
  on STUDENT
  for each row
begin
  insert into AUDIT_LOG values (sysdate, 'STUDENT_TRIGGER ROW BEFORE', 'STUDENT_TRIGGER_ROW_BEFORE');
end;

create or replace trigger STUDENT_TRIGGER_OPERATORS_AFTER
  after insert or delete or update
  on STUDENT
begin
  insert into AUDIT_LOG values (sysdate, 'STUDENT_TRIGGER OPERATORS AFTER', 'STUDENT_TRIGGER_OPERATORS_AFTER');
end;

create or replace trigger STUDENT_TRIGGER_ROW_AFTER
  after insert or delete or update
  on STUDENT
  for each row
begin
  insert into AUDIT_LOG values (sysdate, 'STUDENT_TRIGGER ROW AFTER', 'STUDENT_TRIGGER_ROW_AFTER');
end;

update STUDENT
set STUDENT_NAME = STUDENT_NAME
where 0 = 0;
select *
from AUDIT_LOG;
truncate table AUDIT_LOG;

-- 11.	Выполните операцию, нарушающую целостность таблицы по первичному ключу. Выясните, зарегистрировал
-- ли триггер это событие. Объясните результат.

insert into STUDENT
values ('S001', 'Иванов Иван Иванович', 'P001');

select *
from DBA_TRIGGERS;
select *
from AUDIT_LOG;

-- 12.	Удалите (drop) исходную таблицу. Объясните результат. Добавьте триггер,
-- запрещающий удаление исходной таблицы.

drop table STUDENT;

flashback table TEACHER to before drop;

create or replace trigger BEFORE_DROP
  before drop on GDV.SCHEMA
begin
  if ORA_DICT_OBJ_NAME <> 'STUDENT' then
    return;
  end if;

  raise_application_error(-20001, 'Нельзя удалять таблицу STUDENT');
end;

-- 13.	Удалите (drop) таблицу AUDIT. Просмотрите состояние триггеров с помощью SQL-DEVELOPER.
-- Объясните результат. Измените триггеры.

drop table AUDIT_LOG;
select TRIGGER_NAME, STATUS from USER_TRIGGERS;

-- 14.	Создайте представление над исходной таблицей. Разработайте INSTEADOF INSERT-триггер.
-- Триггер должен добавлять строку в таблицу.

create view STUDENT_VIEW
as
select *
from STUDENT;

create or replace trigger STUDENT_VIEW_TRIGGER
  instead of insert on STUDENT_VIEW
begin
  insert into AUDIT_LOG values (sysdate, 'STUDENT_VIEW_TRIGGER', 'STUDENT_VIEW_TRIGGER');
  insert into STUDENT values (:new.STUDENT, :new.STUDENT_NAME, :new.PULPIT);
end;

-- 15.	Продемонстрируйте, в каком порядке выполняются триггеры.

delete from STUDENT where STUDENT = 'S011';
truncate table AUDIT_LOG;

insert into STUDENT_VIEW
values ('S011', 'Ахарцова Яна Павловна', 'P002');

select * from AUDIT_LOG;
select * from STUDENT;
