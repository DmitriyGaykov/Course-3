-- Задание 10. Создайте соединение с помощью SQL Developer для пользователя XXXCORE.
-- Создайте любую таблицу и любое представление.


CREATE TABLE ANYTABLE
(
  ID NUMBER
);

CREATE VIEW ANYVIEW AS SELECT * FROM ANYTABLE;

DROP TABLE ANYTABLE;
DROP VIEW ANYVIEW;