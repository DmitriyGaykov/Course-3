-- Задание 11. Создайте табличное пространство с именем XXX_QDATA (10m).
-- При создании установите его в состояние offline.
-- Затем переведите табличное пространство в состояние online.
-- Выделите пользователю XXX квоту 2m в пространстве XXX_QDATA.
-- От имени пользователя XXX создайте таблицу в пространстве XXX_T1. В таблицу добавьте 3 строки.

CREATE TABLESPACE GDV_QDATA
    DATAFILE 'GDV_QDATA.DBF'
    SIZE 10M
    OFFLINE;

SELECT TABLESPACE_NAME, STATUS, CONTENTS FROM DBA_TABLESPACES;

ALTER TABLESPACE GDV_QDATA ONLINE;

ALTER USER GDVCORE QUOTA 2M ON GDV_QDATA;

DROP TABLESPACE GDV_QDATA INCLUDING CONTENTS;

-- переключи сессию и роль на GDVCORE!

CREATE TABLE GDV_T1
(
    ID NUMBER,
    NAME VARCHAR2(10)
) TABLESPACE GDV_QDATA;

INSERT INTO GDV_T1 VALUES (1, 'A');
INSERT INTO GDV_T1 VALUES (2, 'B');
INSERT INTO GDV_T1 VALUES (3, 'C');

SELECT * FROM GDV_T1;

DROP TABLE GDV_T1;

