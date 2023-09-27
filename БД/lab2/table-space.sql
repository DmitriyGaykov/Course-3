-- Задание 1. Создайте табличное пространство для постоянных данных со следующими параметрами:
-- - имя: TS_XXX;
-- - имя файла: TS_XXX;
-- - начальный размер: 7М;
-- - автоматическое приращение: 5М;
-- - максимальный размер: 20М.

CREATE TABLESPACE TS_GDV
DATAFILE 'TS_GDV.dbf'
SIZE 7M
AUTOEXTEND ON
NEXT 5M
MAXSIZE 20M;

DROP TABLESPACE TS_GDV INCLUDING CONTENTS AND DATAFILES;