-- Задание 6. Создайте профиль безопасности с именем PF_XXXCORE, имеющий опции, аналогичные примеру из лекции.

CREATE PROFILE C##PF_GDVCORE LIMIT
    FAILED_LOGIN_ATTEMPTS 7
    SESSIONS_PER_USER 3
    PASSWORD_LIFE_TIME 60
    PASSWORD_REUSE_TIME 365
    PASSWORD_LOCK_TIME 1
    CONNECT_TIME 180;

DROP PROFILE C##PF_GDVCORE;


-- Задание 7. Получите список всех профилей БД. Получите значения всех параметров профиля PF_XXXCORE.
-- Получите значения всех параметров профиля DEFAULT.

SELECT * FROM DBA_PROFILES;
SELECT * FROM DBA_PROFILES WHERE PROFILE = 'C##PF_GDVCORE';
SELECT * FROM DBA_PROFILES WHERE PROFILE = 'DEFAULT';