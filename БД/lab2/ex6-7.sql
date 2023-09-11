-- Задание 6. Создайте профиль безопасности с именем PF_XXXCORE, имеющий опции, аналогичные примеру из лекции.

CREATE PROFILE PF_GDVCORE LIMIT
    FAILED_LOGIN_ATTEMPTS 7 -- количество попыток входа в систему
    SESSIONS_PER_USER 3 -- количество сессий на пользователя
    PASSWORD_LIFE_TIME 60 -- время жизни пароля
    PASSWORD_REUSE_TIME 365 -- время до повторного использования пароля
    PASSWORD_LOCK_TIME 1 -- время блокировки пароля
    CONNECT_TIME 180 -- время подключения
    IDLE_TIME 30; -- время простоя


-- Задание 7. Получите список всех профилей БД. Получите значения всех параметров профиля PF_XXXCORE.
-- Получите значения всех параметров профиля DEFAULT.

SELECT * FROM DBA_PROFILES;
SELECT * FROM DBA_PROFILES WHERE PROFILE = 'PF_GDVCORE';
SELECT * FROM DBA_PROFILES WHERE PROFILE = 'DEFAULT';