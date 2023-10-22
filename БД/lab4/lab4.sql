---------1----------
select * from SYS.DBA_TABLESPACES;
-- 1. Получите список всех файлов табличных пространств (перманентных  и временных).

select TABLESPACE_NAME, FILE_NAME from SYS.DBA_DATA_FILES;
select TABLESPACE_NAME, FILE_NAME from SYS.DBA_TEMP_FILES;
---------2------------
-- 2. Создайте табличное пространство с именем XXX_QDATA (10m).
-- При создании установите его в состояние offline.
-- Затем переведите табличное пространство в состояние online.
-- Выделите пользователю XXX квоту 2m в пространстве XXX_QDATA.
-- От имени XXX в  пространстве XXX_T1создайте таблицу из двух столбцов,
-- один из которых будет являться первичным ключом. В таблицу добавьте 3 строки.

create tablespace GDV_QDATA
    datafile 'gdvqdata.dbf'
    SIZE 10M
    AUTOEXTEND ON
    NEXT 5M
    MAXSIZE 20M
    offline;

alter tablespace GDV_QDATA online;

alter user C##GDV quota 2m on GDV_QDATA;

-- переключение на C##GDV

create table GDV_T1 (
    x integer primary key,
    y integer
) tablespace GDV_QDATA;

insert into GDV_T1(x, y) values (1, 2);
insert into GDV_T1(x, y) values (2, 3);
insert into GDV_T1(x, y) values (3, 4);

select * from GDV_T1;

-- 3. Получите список сегментов табличного пространства  XXX_QDATA.
-- Определите сегмент таблицы XXX_T1. Определите остальные сегменты.

select * from dba_segments where tablespace_name = 'GDV_QDATA';

-- 4. Удалите (DROP) таблицу XXX_T1. Получите список сегментов табличного пространства
-- XXX_QDATA. Определите сегмент таблицы XXX_T1. Выполните SELECT-запрос к представлению
-- USER_RECYCLEBIN, поясните результат

drop table GDV_T1;
select * from dba_segments where tablespace_name = 'GDV_QDATA';
select * from USER_RECYCLEBIN;

-- 5. Восстановите (FLASHBACK) удаленную таблицу.

flashback table GDV_T1 to before drop;

-- 6. Выполните PL/SQL-скрипт, заполняющий таблицу XXX_T1 данными (10000 строк).

declare
    i integer := 4;
begin
    while i < 10004 loop
        insert into GDV_T1(x, y) values (i, i);
        i := i + 1;
    end loop;
end;

-- 7. Определите сколько в сегменте таблицы XXX_T1 экстентов, их размер в блоках и байтах.
-- Получите перечень всех экстентов.

select extents, bytes, blocks from dba_segments where segment_name = 'GDV_T1';
select * from dba_extents where segment_name = 'GDV_T1';

-- 8. Удалите табличное пространство XXX_QDATA и его файл.

drop tablespace GDV_QDATA including contents and datafiles;

-- 9. Получите перечень всех групп журналов повтора. Определите текущую группу журналов повтора.

select group# from v$logfile;
select group# from v$log where status = 'CURRENT';

-- 10. Получите перечень файлов всех журналов повтора инстанса.

select member from v$logfile;

-- 11. EX. С помощью переключения журналов повтора пройдите полный цикл переключений.
-- Запишите серверное время в момент вашего первого переключения (оно понадобится для
-- выполнения следующих заданий).

alter system switch logfile; -- выполнить 2 раза и следить, где в v$log status = 'CURRENT'
select group#, status from v$log;
select group# from v$log where status = 'CURRENT';
select current_timestamp from sys.dual;

-- 12. EX. Создайте дополнительную группу журналов повтора с тремя файлами журнала.
-- Убедитесь в наличии группы и файлов, а также в работоспособности группы (переключением).
-- Проследите последовательность SCN.

--alter database add logfile group 4 ('redo04.log') size 50m,
--    group 5 ('redo05.log') size 50m,
--    group 6 ('redo06.log') size 50m;

alter database add logfile group 4 ('redo04.log') size 50m;

alter database add logfile member 'redo05.log' to group 4;
alter database add logfile member 'redo06.log' to group 4;

-- alter database add logfile group 4 ('redo04.log') size 50m;
-- alter database add logfile group 5 ('redo05.log') size 50m;
-- alter database add logfile group 6 ('redo06.log') size 50m;

select group#, member, status from V_$LOGFILE;
alter system switch logfile;
select group#, status from v$log;

-- 13. EX. Удалите созданную группу журналов повтора.
-- Удалите созданные вами файлы журналов на сервере.

alter database drop logfile group 4;

-- Не работает
alter database drop logfile member 'C:\WINDOWS.X64_193000_DB_HOME\DATABASE\REDO04.LOG';

-- 14. Определите, выполняется или нет архивирование журналов повтора
-- (архивирование должно быть отключено, иначе дождитесь, пока другой студент
-- выполнит задание и отключит).

select log_mode from v$database;

-- 15. Определите номер последнего архива.

select max(sequence#) from v$archived_log;

-- 16. EX.  Включите архивирование.

-- в sqlplus
shutdown immediate;
startup mount;
alter database archivelog;
alter database open;

-- 17. EX. Принудительно создайте архивный файл. Определите его номер.
-- Определите его местоположение и убедитесь в его наличии. Проследите
-- последовательность SCN в архивах и журналах повтора.

alter system switch logfile;
select max(sequence#) from v$archived_log;
select * from v$archived_log;
select * from v$log;

-- 18. EX. Отключите архивирование. Убедитесь, что архивирование отключено.

-- в sqlplus
shutdown immediate;
startup mount;
alter database noarchivelog;
alter database open;

-- 19. Получите список управляющих файлов.

select NAME from v$controlfile;

-- 20. Получите и исследуйте содержимое управляющего файла.
-- Поясните известные вам параметры в файле.

-- в sqlplus

show parameter control_files;

-- C:\ORACLEDB\ORADATA\ORCL\CONTROL02.CTL

-- 21. Определите местоположение файла параметров инстанса.
-- Убедитесь в наличии этого файла.

show parameter pfile;

-- 22. Сформируйте PFILE с именем XXX_PFILE.ORA. Исследуйте его содержимое.
-- Поясните известные вам параметры в файле

create pfile = 'C:\ORACLEDB\ORADATA\ORCL\GDV_PFILE.ORA' from spfile;

-- 23. Определите местоположение файла паролей инстанса. Убедитесь в наличии этого файла.

show parameter password;

-- 24. Получите перечень директориев для файлов сообщений и диагностики.

show parameter background_dump_dest;

-- 25. EX. Найдите и исследуйте содержимое протокола работы инстанса (LOG.XML),
-- найдите в нем команды переключения журналов которые вы выполняли.

-- C:\OracleDB\diag\rdbms\orcl\orcl\alert

-- 26. Проверьте! После вашей работы не должно остаться ни одного файла,
-- созданного вами в процессе выполнения лабораторной работы.

