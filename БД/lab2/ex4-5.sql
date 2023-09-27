-- Задание 4. Создайте роль с именем RL_XXXCORE. Назначьте ей следующие системные привилегии:
-- 	разрешение на соединение с сервером;
-- 	разрешение создавать и удалять таблицы, представления, процедуры и функции.

-- ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE ROLE C##RL_GDVCORE;

GRANT
    CONNECT,
    CREATE TABLE,
    CREATE VIEW,
    CREATE PROCEDURE,
    DROP ANY TABLE,
    DROP ANY VIEW,
    DROP ANY PROCEDURE
TO C##RL_GDVCORE;

DROP ROLE C##RL_GDVCORE;

-- Задание 5. Найдите с помощью select-запроса роль в словаре.
-- Найдите с помощью select-запроса все системные привилегии, назначенные роли.

SELECT * FROM DBA_ROLES WHERE ROLE ='C##RL_GDVCORE';
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'C##RL_GDVCORE';

