-- ex1
select * from dba_pdbs;

-- ex2
select * from V_$INSTANCE;

-- ex3
select * from V_$OPTION;

-- ex6
ALTER SESSION SET CONTAINER = GDV_PDB;

ALTER SESSION SET CONTAINER = CDB$ROOT;

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE TABLESPACE TS_GDV_PDB
DATAFILE 'TS_GDV_PDB.dbf'
SIZE 7M
AUTOEXTEND ON
NEXT 5M
MAXSIZE 20M;

DROP TABLESPACE TS_GDV_PDB INCLUDING CONTENTS AND DATAFILES;


-- alter session set container = gdv_pdb;
--
-- select * from SYS.DBA_USERS;


-- самое послденее задание

SELECT s.sid, s.serial#, s.username, p.name
FROM v$session s
JOIN v$pdbs p ON s.con_id = p.con_id
WHERE s.type = 'USER';


drop pluggable database GDV_PDB including datafiles;