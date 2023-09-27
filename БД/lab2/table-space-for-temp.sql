-- Задание 2. Создайте табличное пространство для временных данных со следующими параметрами:
-- 	имя: TS_XXX_TEMP;
-- 	имя файла: TS_XXX_TEMP;
-- 	начальный размер: 5М;
-- 	автоматическое приращение: 3М;
-- 	максимальный размер: 30М.

CREATE TEMPORARY TABLESPACE TS_GDV_TEMP
TEMPFILE 'TS_GDV_TEMP.PBF'
SIZE 5M
AUTOEXTEND ON
NEXT 3M
MAXSIZE 30M;

DROP TABLESPACE TS_GDV_TEMP INCLUDING CONTENTS AND DATAFILES;