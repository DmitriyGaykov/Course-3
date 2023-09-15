-- Задание 8. Создайте пользователя с именем XXXCORE со следующими параметрами:
-- - табличное пространство по умолчанию: TS_XXX;
-- - табличное пространство для временных данных: TS_XXX_TEMP;
-- - профиль безопасности PF_XXXCORE;
-- - учетная запись разблокирована;
-- - срок действия пароля истек

CREATE USER GDVCORE IDENTIFIED BY 123123
    DEFAULT TABLESPACE TS_GDV
    TEMPORARY TABLESPACE TS_GDV_TEMP
    PROFILE PF_GDVCORE
    ACCOUNT UNLOCK
    PASSWORD EXPIRE
    INCLUDING ;

GRANT CREATE SESSION TO GDVCORE;
GRANT CREATE TABLE, CREATE VIEW, DROP ANY TABLE, DROP ANY VIEW TO GDVCORE;


DROP USER GDVCORE;

