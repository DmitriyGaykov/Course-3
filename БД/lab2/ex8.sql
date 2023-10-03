-- Задание 8. Создайте пользователя с именем XXXCORE со следующими параметрами:
-- - табличное пространство по умолчанию: TS_XXX;
-- - табличное пространство для временных данных: TS_XXX_TEMP;
-- - профиль безопасности PF_XXXCORE;
-- - учетная запись разблокирована;
-- - срок действия пароля истек

CREATE USER C##GDVCORE IDENTIFIED BY 123123
    DEFAULT TABLESPACE TS_GDV
    TEMPORARY TABLESPACE TS_GDV_TEMP
    PROFILE C##PF_GDVCORE
    ACCOUNT UNLOCK
    PASSWORD EXPIRE;

DROP USER C##GDVCORE;

GRANT
    CONNECT,
    CREATE ANY TABLE,
    CREATE ANY VIEW,
    CREATE ANY PROCEDURE,
    DROP ANY TABLE,
    DROP ANY VIEW,
    DROP ANY PROCEDURE
    to C##GDVCORE;

GRANT CREATE SESSION TO C##GDVCORE;
REVOKE CREATE SESSION FROM C##GDVCORE;


