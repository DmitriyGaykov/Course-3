select sum(value)
from v$sga;

-- 2.Определите текущие размеры основных пулов SGA.
select component, CURRENT_SIZE
from v$sga_dynamic_components;

-- 3.Определите размеры гранулы для каждого пула.
select component, granule_size
from v$sga_dynamic_components;

-- 4.Определите объем доступной свободной памяти в SGA.
select current_size
from v$sga_dynamic_free_memory;

-- 5.Определите максимальный и целевой размер области SGA.
SELECT name, value
FROM v$parameter
WHERE name = 'sga_max_size';
SELECT name, value
FROM v$parameter
WHERE name = 'sga_target';

-- 6.Определите размеры пулов КЕЕP, DEFAULT и RECYCLE буферного кэша.
select component,
       CURRENT_SIZE
from v$sga_dynamic_components
where component like 'KEEP buff%'
   or component like 'DEFAULT buff%'
   or component like 'RECYCLE buff%';

-- 7.Создайте таблицу, которая будет помещаться в пул КЕЕP. Продемонстрируйте сегмент таблицы.
create table KT
(
  k int
) storage
(
  buffer_pool keep
);
select segment_name, segment_type, buffer_pool
from user_segments
where segment_name = 'KT';

-- 8.Создайте таблицу, которая будет кэшироваться в пуле DEFAULT. Продемонстрируйте сегмент таблицы.
create table DT
(
  k int
) cache;
select segment_name, segment_type, buffer_pool
from user_segments
where segment_name = 'DT';

-- 9.Найдите размер буфера журналов повтора.
show parameter log_buffer;

--10.Найдите размер свободной памяти в большом пуле.
SELECT bytes
FROM v$sgastat
WHERE pool = 'large pool'
  AND name = 'free memory';

--11.Определите режимы текущих соединений с инстансом (dedicated, shared).
SELECT server
FROM v$session;

-- 12.Получите полный список работающих в настоящее время фоновых процессов.
SELECT *
FROM v$bgprocess;

-- 13.Получите список работающих в настоящее время серверных процессов.
select *
from v$process
where addr != '00';

-- 14.Определите, сколько процессов DBWn работает в настоящий момент.
select count(*)
from v$process
where pname like '%DBW%';

-- 15.Определите сервисы (точки подключения экземпляра).
select name
from v$services;

-- 16.Получите известные вам параметры диспетчеров.
select *
from v$parameter
where name like '%dispatcher%';
show parameter dispatcher;

-- 17.Укажите в списке Windows-сервисов сервис, реализующий процесс LISTENER.
-- В службы

-- 18.Продемонстрируйте и поясните содержимое файла LISTENER.ORA.
-- C:\WINDOWS.X64_193000_db_home\network\admin

-- 19.Запустите утилиту lsnrctl и поясните ее основные команды.
-- lsnrctl help

-- 20.Получите список служб инстанса, обслуживаемых процессом LISTENER.
-- lsnrctl services

create or replace view segment_summary as
select owner,
       segment_type,
       count(*)          as segment_count,
       sum(extents)      as total_extents,
       sum(blocks)       as total_blocks,
       sum(bytes) / 1024 as total_size_kb
from dba_segments
group by owner, segment_type;

select *
from segment_summary;


