-- 1.	Определите общий размер области SGA.

select sum(bytes) from v$sgastat;

-- 2.	Определите текущие размеры основных пулов SGA.
select pool, sum(bytes) from v$sgastat group by pool;

-- 3.	Определите размеры гранулы для каждого пула.
select pool, granule_size from v$sgainfo;

-- 4.	Определите максимальный и целевой размер области SGA.
select * from v$sga_dynamic_components;

--6.	Определите размеры пулов КЕЕP, DEFAULT и RECYCLE буферного кэша.
select pool, name, bytes from v$buffer_pool;