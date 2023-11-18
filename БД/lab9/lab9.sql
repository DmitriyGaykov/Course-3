create table AUDITORIUM_TYPE
(
  AUDITORIUM_TYPE     varchar(20) primary key,
  AUDIOTRIUM_TYPENAME varchar(100) unique
);

create table AUDITORIUM
(
  AUDITORIUM          varchar(20) primary key,
  AUDITORIUM_NAME     varchar(100) unique,
  AUDITORIUM_CAPACITY int,
  AUDITORIUM_TYPE     varchar(20),
  foreign key (AUDITORIUM_TYPE) references AUDITORIUM_TYPE (AUDITORIUM_TYPE)
);

create table FACULTY
(
  FACULTY      varchar(20) primary key,
  FACULTY_NAME varchar(100) unique
);

create table PULPIT
(
  PULPIT      varchar(20) primary key,
  PULPIT_NAME varchar(100) unique,
  FACULTY     varchar(20),
  foreign key (FACULTY) references FACULTY (FACULTY)
);

create table TEACHER
(
  TEACHER      varchar(20) primary key,
  TEACHER_NAME varchar(100) unique,
  PULPIT       varchar(20),
  foreign key (PULPIT) references PULPIT (PULPIT)
);

create table SUBJECT
(
  SUBJECT      varchar(20) primary key,
  SUBJECT_NAME varchar(100) unique,
  PULPIT       varchar(20),
  foreign key (PULPIT) references PULPIT (PULPIT)
);

-- Заполняем таблицу AUDITORIUM_TYPE
INSERT INTO AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDIOTRIUM_TYPENAME)
VALUES ('Lecture', 'Лекционная аудитория');
INSERT INTO AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDIOTRIUM_TYPENAME)
VALUES ('Laboratory', 'Лаборатория');
INSERT INTO AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDIOTRIUM_TYPENAME)
VALUES ('Auditorium', 'Аудитория');
INSERT INTO AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDIOTRIUM_TYPENAME)
VALUES ('Seminar', 'Семинарская комната');
INSERT INTO AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDIOTRIUM_TYPENAME)
VALUES ('Conference', 'Конференц-зал');

-- Заполняем таблицу AUDITORIUM
-- Здесь предполагается, что у вас есть реальные данные об аудиториях
-- Пример:
INSERT INTO AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
VALUES ('A101', 'Аудитория 101', 100, 'Auditorium');
INSERT INTO AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
VALUES ('A102', 'Аудитория 102', 100, 'Auditorium');
INSERT INTO AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
VALUES ('A103', 'Аудитория 103', 100, 'Auditorium');
INSERT INTO AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
VALUES ('A104', 'Аудитория 104', 100, 'Auditorium');

-- ...

-- Заполняем таблицу FACULTY
INSERT INTO FACULTY (FACULTY, FACULTY_NAME)
VALUES ('F001', 'Факультет информатики');
INSERT INTO FACULTY (FACULTY, FACULTY_NAME)
VALUES ('F002', 'Факультет естественных наук');
INSERT INTO FACULTY (FACULTY, FACULTY_NAME)
VALUES ('F003', 'Факультет искусств');
INSERT INTO FACULTY (FACULTY, FACULTY_NAME)
VALUES ('F004', 'Факультет экономики');
INSERT INTO FACULTY (FACULTY, FACULTY_NAME)
VALUES ('F005', 'Факультет медицины');



-- Заполняем таблицу PULPIT
-- Здесь также предполагается, что у вас есть реальные данные о кафедрах и факультетах
-- Пример:
INSERT INTO PULPIT (PULPIT, PULPIT_NAME, FACULTY)
VALUES ('P001', 'Кафедра информационных технологий', 'F001');
-- ...

-- Заполняем таблицу TEACHER
-- Примеры:
INSERT INTO TEACHER (TEACHER, TEACHER_NAME, PULPIT)
VALUES ('T001', 'Иванов Иван Иванович', 'P001');
INSERT INTO TEACHER (TEACHER, TEACHER_NAME, PULPIT)
VALUES ('T002', 'Петров Петр Петрович', 'P001');
INSERT INTO TEACHER (TEACHER, TEACHER_NAME, PULPIT)
VALUES ('T003', 'Сидорова Екатерина Владимировна', 'P001');
INSERT INTO TEACHER (TEACHER, TEACHER_NAME, PULPIT)
VALUES ('T004', 'Смирнова Анна Александровна', 'P001');
-- ...

-- Заполняем таблицу SUBJECT
-- Примеры:

INSERT INTO SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT)
VALUES ('S001', 'Программирование', 'P001');
INSERT INTO SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT)
VALUES ('S002', 'Биология', 'P001');
INSERT INTO SUBJECT (SUBJECT, SUBJECT_NAME, PULPIT)
VALUES ('S003', 'Искусствоведение', 'P001');

DECLARE
  i integer := 0;
BEGIN
  FOR i IN 1..100000
    LOOP
      INSERT INTO AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
      VALUES ('A' || i, 'Аудитория ' || i, 100, 'Auditorium');
    END LOOP;
end;

-- 1. Разработайте АБ, демонстрирующий работу оператора SELECT с точной выборкой.

SELECT *
FROM AUDITORIUM_TYPE
WHERE AUDITORIUM_TYPE = 'Lecture';

-- 2. Разработайте АБ, демонстрирующий работу оператора SELECT с неточной точной выборкой.
-- Используйте конструкцию WHEN OTHERS секции исключений и встроенную функции SQLERRM, SQLCODE
-- для диагностирования неточной выборки.

DECLARE
  v_AUDITORIUM_TYPE     AUDITORIUM_TYPE.AUDITORIUM_TYPE%TYPE;
  v_AUDIOTRIUM_TYPENAME AUDITORIUM_TYPE.AUDIOTRIUM_TYPENAME%TYPE;
BEGIN
  SELECT AUDITORIUM_TYPE,
         AUDIOTRIUM_TYPENAME
  INTO
    v_AUDITORIUM_TYPE,
    v_AUDIOTRIUM_TYPENAME
  FROM AUDITORIUM_TYPE
  WHERE AUDITORIUM_TYPE = 'Lecture';

  DBMS_OUTPUT.PUT_LINE('AUDITORIUM_TYPE: ' || v_AUDITORIUM_TYPE || ', AUDIOTRIUM_TYPENAME: ' || v_AUDIOTRIUM_TYPENAME);
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLCODE || ' ' || SQLERRM);
end;

-- 3. Разработайте АБ, демонстрирующий работу конструкции WHEN TO_MANY_ROWS секции
-- исключений для диагностирования неточной выборки.

DECLARE
  v_AUDITORIUM          AUDITORIUM.AUDITORIUM%TYPE;
  v_AUDITORIUM_NAME     AUDITORIUM.AUDITORIUM_NAME%TYPE;
  v_AUDITORIUM_CAPACITY AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;
BEGIN
  SELECT AUDITORIUM,
         AUDITORIUM_NAME,
         AUDITORIUM_CAPACITY
  INTO
    v_AUDITORIUM,
    v_AUDITORIUM_NAME,
    v_AUDITORIUM_CAPACITY
  FROM AUDITORIUM
  WHERE AUDITORIUM_TYPE = 'Auditorium';

  DBMS_OUTPUT.PUT_LINE('AUDITORIUM: ' || v_AUDITORIUM || ', AUDITORIUM_NAME: ' || v_AUDITORIUM_NAME ||
                       ', AUDITORIUM_CAPACITY: ' || v_AUDITORIUM_CAPACITY);
EXCEPTION
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLCODE || ' ' || SQLERRM);
end;

-- 4. Разработайте АБ, демонстрирующий возникновение и обработку исключения NO_DATA_FOUND.
-- Разработайте АБ, демонстрирующий применение атрибутов неявного курсора.

DECLARE
  v_AUDITORIUM          AUDITORIUM.AUDITORIUM%TYPE;
  v_AUDITORIUM_NAME     AUDITORIUM.AUDITORIUM_NAME%TYPE;
  v_AUDITORIUM_CAPACITY AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;
BEGIN
  SELECT AUDITORIUM,
         AUDITORIUM_NAME,
         AUDITORIUM_CAPACITY
  INTO
    v_AUDITORIUM,
    v_AUDITORIUM_NAME,
    v_AUDITORIUM_CAPACITY
  FROM AUDITORIUM
  WHERE AUDITORIUM_TYPE = 'Auditoriums';

  DBMS_OUTPUT.PUT_LINE('AUDITORIUM: ' || v_AUDITORIUM || ', AUDITORIUM_NAME: ' || v_AUDITORIUM_NAME ||
                       ', AUDITORIUM_CAPACITY: ' || v_AUDITORIUM_CAPACITY);

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLCODE || ' ' || SQLERRM);
end;

-- 5. Разработайте АБ, демонстрирующий применение оператора UPDATE совместно с операторами COMMIT/ROLLBACK.

DECLARE
  v_CAPACITY AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;
BEGIN
  UPDATE AUDITORIUM
  SET AUDITORIUM_NAME = 'Аудитория 1'
  WHERE AUDITORIUM = 'A1'
  RETURNING AUDITORIUM_CAPACITY INTO v_CAPACITY;

  IF v_CAPACITY <> 100 THEN
    DBMS_OUTPUT.PUT_LINE('Обновление прошло успешно');
    COMMIT;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Обновление не прошло');
    ROLLBACK;
  END IF;
END;

-- 6. Продемонстрируйте оператор UPDATE, вызывающий нарушение целостности в базе данных.
-- Обработайте возникшее исключение.

DECLARE
BEGIN
  UPDATE AUDITORIUM
  SET AUDITORIUM = 'Аудитория 11111111111111111111111    111111111111111111111111111111111111111111111111'
  WHERE AUDITORIUM = 'A101';
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLCODE || ' ' || SQLERRM);
    ROLLBACK;
end;

-- 7. Разработайте АБ, демонстрирующий применение оператора INSERT совместно с операторами COMMIT/ROLLBACK.

DECLARE
  v_AUDITORIUM          AUDITORIUM.AUDITORIUM%TYPE;
  v_AUDITORIUM_NAME     AUDITORIUM.AUDITORIUM_NAME%TYPE;
  v_AUDITORIUM_CAPACITY AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;
BEGIN
  INSERT INTO AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
  VALUES ('A1', 'Аудитория 1', 100, 'Auditorium')
  RETURNING AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY INTO v_AUDITORIUM, v_AUDITORIUM_NAME, v_AUDITORIUM_CAPACITY;

  DBMS_OUTPUT.PUT_LINE('AUDITORIUM: ' || v_AUDITORIUM || ', AUDITORIUM_NAME: ' || v_AUDITORIUM_NAME ||
                       ', AUDITORIUM_CAPACITY: ' || v_AUDITORIUM_CAPACITY);
  COMMIT;

  INSERT INTO AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
  VALUES ('A2', 'Аудитория 2', 100, 'Auditorium')
  RETURNING AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY INTO v_AUDITORIUM, v_AUDITORIUM_NAME, v_AUDITORIUM_CAPACITY;

  DBMS_OUTPUT.PUT_LINE('AUDITORIUM: ' || v_AUDITORIUM || ', AUDITORIUM_NAME: ' || v_AUDITORIUM_NAME ||
                       ', AUDITORIUM_CAPACITY: ' || v_AUDITORIUM_CAPACITY);

  ROLLBACK;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLCODE || ' ' || SQLERRM);
    ROLLBACK;
end;

-- 8. Продемонстрируйте оператор INSERT, вызывающий нарушение целостности в базе данных.
-- Обработайте возникшее исключение.

DECLARE
BEGIN
  INSERT INTO AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
  VALUES ('A1', 'Аудитория 1', 100, 'Auditorium');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLCODE || ' ' || SQLERRM);
    ROLLBACK;
end;

-- 9. Разработайте АБ, демонстрирующий применение оператора DELETE совместно с операторами COMMIT/ROLLBACK.

DECLARE
  v_AUDITORIUM          AUDITORIUM.AUDITORIUM%TYPE;
  v_AUDITORIUM_NAME     AUDITORIUM.AUDITORIUM_NAME%TYPE;
  v_AUDITORIUM_CAPACITY AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;
BEGIN
  DELETE
  FROM AUDITORIUM
  WHERE AUDITORIUM = 'A1'
  RETURNING AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY
  INTO v_AUDITORIUM, v_AUDITORIUM_NAME, v_AUDITORIUM_CAPACITY;

  DBMS_OUTPUT.PUT_LINE('AUDITORIUM: ' || v_AUDITORIUM || ', AUDITORIUM_NAME: ' || v_AUDITORIUM_NAME ||
                       ', AUDITORIUM_CAPACITY: ' || v_AUDITORIUM_CAPACITY);
  COMMIT;

  DELETE
  FROM AUDITORIUM
  WHERE AUDITORIUM = 'A2'
  RETURNING AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY INTO v_AUDITORIUM, v_AUDITORIUM_NAME, v_AUDITORIUM_CAPACITY;

  DBMS_OUTPUT.PUT_LINE('AUDITORIUM: ' || v_AUDITORIUM || ', AUDITORIUM_NAME: ' || v_AUDITORIUM_NAME ||
                       ', AUDITORIUM_CAPACITY: ' || v_AUDITORIUM_CAPACITY);

  ROLLBACK;
end;

-- 10. Продемонстрируйте оператор DELETE, вызывающий нарушение целостности в базе данных.
-- Обработайте возникшее исключение.

insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
values ('A1_3', 'Аудитория 1', 100, 'Lecture');

DECLARE
BEGIN
  DELETE
  FROM AUDITORIUM_TYPE
  WHERE AUDITORIUM_TYPE = 'Lecture';
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Ошибка: ' || SQLCODE || ' ' || SQLERRM);
    ROLLBACK;
end;

-- 11. Создайте анонимный блок, распечатывающий таблицу TEACHER с применением явного курсора LOOP-цикла.
-- Считанные данные должны быть записаны в переменные, объявленные с применением опции %TYPE.

DECLARE
  v_TEACHER      TEACHER.TEACHER%TYPE;
  v_TEACHER_NAME TEACHER.TEACHER_NAME%TYPE;
  v_PULPIT       TEACHER.PULPIT%TYPE;
  CURSOR c_TEACHER IS
    SELECT TEACHER,
           TEACHER_NAME,
           PULPIT
    FROM TEACHER;
BEGIN
  FOR i IN c_TEACHER
    LOOP
      v_TEACHER := i.TEACHER;
      v_TEACHER_NAME := i.TEACHER_NAME;
      v_PULPIT := i.PULPIT;
      DBMS_OUTPUT.PUT_LINE('TEACHER: ' || v_TEACHER || ', TEACHER_NAME: ' || v_TEACHER_NAME || ', PULPIT: ' ||
                           v_PULPIT);
    END LOOP;
end;

-- 12. Создайте АБ, распечатывающий таблицу SUBJECT с применением явного курсора и WHILE-цикла.
-- Считанные данные должны быть записаны в запись (RECORD), объявленную с применением опции %ROWTYPE.

DECLARE
  v_SUBJECT SUBJECT%ROWTYPE;
  CURSOR c_SUBJECT IS
    SELECT *
    FROM SUBJECT;
BEGIN
  OPEN c_SUBJECT;
  WHILE TRUE
    LOOP
      FETCH c_SUBJECT INTO v_SUBJECT;
      EXIT WHEN c_SUBJECT%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('SUBJECT: ' || v_SUBJECT.SUBJECT || ', SUBJECT_NAME: ' || v_SUBJECT.SUBJECT_NAME ||
                           ', PULPIT: ' || v_SUBJECT.PULPIT);
    END LOOP;
end;

-- 13. Создайте АБ, распечатывающий все кафедры (таблица PULPIT) и фамилии всех преподавателей (TEACHER)
-- использовав, соединение (JOIN) PULPIT и TEACHER и с применением явного курсора и FOR-цикла.

DECLARE
  v_PULPIT         PULPIT.PULPIT%TYPE;
  v_PULPIT_NAME    PULPIT.PULPIT_NAME%TYPE;
  v_FACULTY        PULPIT.FACULTY%TYPE;
  v_TEACHER        TEACHER.TEACHER%TYPE;
  v_TEACHER_NAME   TEACHER.TEACHER_NAME%TYPE;
  v_PULPIT_TEACHER PULPIT.PULPIT%TYPE;
  CURSOR c_PULPIT_TEACHER IS
    SELECT PULPIT.PULPIT,
           PULPIT.PULPIT_NAME,
           PULPIT.FACULTY,
           TEACHER.TEACHER,
           TEACHER.TEACHER_NAME
    FROM PULPIT
           JOIN TEACHER ON PULPIT.PULPIT = TEACHER.PULPIT;
BEGIN
  FOR i IN c_PULPIT_TEACHER
    LOOP
      v_PULPIT := i.PULPIT;
      v_PULPIT_NAME := i.PULPIT_NAME;
      v_FACULTY := i.FACULTY;
      v_TEACHER := i.TEACHER;
      v_TEACHER_NAME := i.TEACHER_NAME;
      DBMS_OUTPUT.PUT_LINE('PULPIT: ' || v_PULPIT || ', PULPIT_NAME: ' || v_PULPIT_NAME || ', FACULTY: ' || v_FACULTY ||
                           ', TEACHER: ' || v_TEACHER || ', TEACHER_NAME: ' || v_TEACHER_NAME);
    END LOOP;
end;

-- 14. Создайте АБ, распечатывающий следующие списки аудиторий: все аудитории (таблица AUDITORIUM)
-- с вместимостью меньше 20, от 21-30, от 31-60, от 61 до 80, от 81 и выше. Примените курсор
-- с параметрами и три способа организации цикла по строкам курсора.

declare
begin
  for i in 0..100
    loop
      -- random capacity
      insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
      values ('A' || (i + 1000), 'Аудитория ' || (i + 1000), round(dbms_random.value(1, 100)), 'Auditorium');
    end loop;
end;

DECLARE
  v_AUDITORIUM          AUDITORIUM.AUDITORIUM%TYPE;
  v_AUDITORIUM_NAME     AUDITORIUM.AUDITORIUM_NAME%TYPE;
  v_AUDITORIUM_CAPACITY AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;
  isFirst20 boolean := true;
  isFirst30 boolean := true;
  isFirst60 boolean := true;
  isFirst80 boolean := true;
  isFirstFull boolean := true;
  CURSOR c_AUDITORIUM IS
    SELECT AUDITORIUM,
           AUDITORIUM_NAME,
           AUDITORIUM_CAPACITY
    FROM AUDITORIUM
    ORDER BY AUDITORIUM_CAPACITY;
BEGIN
  OPEN c_AUDITORIUM;
  LOOP
    FETCH c_AUDITORIUM INTO v_AUDITORIUM, v_AUDITORIUM_NAME, v_AUDITORIUM_CAPACITY;
    EXIT WHEN c_AUDITORIUM%NOTFOUND;
    IF v_AUDITORIUM_CAPACITY >= 0 and v_AUDITORIUM_CAPACITY <= 20 THEN
      IF isFirst20 then
        DBMS_OUTPUT.PUT_LINE('------------------ 0 > 20 ----------------');
        isFirst20 := false;
      end if;
      DBMS_OUTPUT.PUT_LINE('AUDITORIUM: ' || v_AUDITORIUM || ', AUDITORIUM_NAME: ' || v_AUDITORIUM_NAME ||
                           ', AUDITORIUM_CAPACITY: ' || v_AUDITORIUM_CAPACITY);
    END IF;

    IF v_AUDITORIUM_CAPACITY >= 21 and v_AUDITORIUM_CAPACITY <= 30 THEN
      IF isFirst30 then
        DBMS_OUTPUT.PUT_LINE('------------------ 21 > 30  ----------------');
        isFirst30 := false;
      end if;
      DBMS_OUTPUT.PUT_LINE('AUDITORIUM: ' || v_AUDITORIUM || ', AUDITORIUM_NAME: ' || v_AUDITORIUM_NAME ||
                           ', AUDITORIUM_CAPACITY: ' || v_AUDITORIUM_CAPACITY);
    END IF;

    IF v_AUDITORIUM_CAPACITY >= 31 and v_AUDITORIUM_CAPACITY <= 60 THEN
      IF isFirst60 then
        DBMS_OUTPUT.PUT_LINE('------------------ 31 > 60 ----------------');
        isFirst60 := false;
      end if;
      DBMS_OUTPUT.PUT_LINE('AUDITORIUM: ' || v_AUDITORIUM || ', AUDITORIUM_NAME: ' || v_AUDITORIUM_NAME ||
                           ', AUDITORIUM_CAPACITY: ' || v_AUDITORIUM_CAPACITY);
    END IF;

    IF v_AUDITORIUM_CAPACITY >= 61 and v_AUDITORIUM_CAPACITY <= 80 THEN
      IF isFirst80 then
        DBMS_OUTPUT.PUT_LINE('------------------ 61 > 80 ----------------');
        isFirst80 := false;
      end if;
      DBMS_OUTPUT.PUT_LINE('AUDITORIUM: ' || v_AUDITORIUM || ', AUDITORIUM_NAME: ' || v_AUDITORIUM_NAME ||
                           ', AUDITORIUM_CAPACITY: ' || v_AUDITORIUM_CAPACITY);
    END IF;

    IF v_AUDITORIUM_CAPACITY >= 81 THEN
      IF isFirstFull then
        DBMS_OUTPUT.PUT_LINE('------------------ > 81 ----------------');
        isFirstFull := false;
      end if;
      DBMS_OUTPUT.PUT_LINE('AUDITORIUM: ' || v_AUDITORIUM || ', AUDITORIUM_NAME: ' || v_AUDITORIUM_NAME ||
                           ', AUDITORIUM_CAPACITY: ' || v_AUDITORIUM_CAPACITY);
    END IF;



  END LOOP;

  CLOSE c_AUDITORIUM;
end; --ППППППППППППППППП

-- 15. Создайте AБ. Объявите курсорную переменную с помощью системного типа refcursor.
-- Продемонстрируйте ее применение для курсора c параметрами.

DECLARE
  v_AUDITORIUM          AUDITORIUM.AUDITORIUM%TYPE;
  v_AUDITORIUM_NAME     AUDITORIUM.AUDITORIUM_NAME%TYPE;
  v_AUDITORIUM_CAPACITY AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;
  c_AUDITORIUM          SYS_REFCURSOR;
BEGIN
  OPEN c_AUDITORIUM FOR
    SELECT AUDITORIUM,
           AUDITORIUM_NAME,
           AUDITORIUM_CAPACITY
    FROM AUDITORIUM
    WHERE AUDITORIUM_TYPE = 'Auditorium';

  LOOP
    FETCH c_AUDITORIUM INTO v_AUDITORIUM, v_AUDITORIUM_NAME, v_AUDITORIUM_CAPACITY;
    EXIT WHEN c_AUDITORIUM%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('AUDITORIUM: ' || v_AUDITORIUM || ', AUDITORIUM_NAME: ' || v_AUDITORIUM_NAME ||
                         ', AUDITORIUM_CAPACITY: ' || v_AUDITORIUM_CAPACITY);
  END LOOP;

  CLOSE c_AUDITORIUM;
end;

-- 16. Создайте AБ. Продемонстрируйте понятие курсорный подзапрос?

DECLARE
  v_AUDITORIUM          AUDITORIUM.AUDITORIUM%TYPE;
  v_AUDITORIUM_NAME     AUDITORIUM.AUDITORIUM_NAME%TYPE;
  v_AUDITORIUM_CAPACITY AUDITORIUM.AUDITORIUM_CAPACITY%TYPE;
BEGIN
  FOR i IN (SELECT AUDITORIUM,
                   AUDITORIUM_NAME,
                   AUDITORIUM_CAPACITY
            FROM AUDITORIUM
            WHERE AUDITORIUM_TYPE = 'Auditorium')
    LOOP
      v_AUDITORIUM := i.AUDITORIUM;
      v_AUDITORIUM_NAME := i.AUDITORIUM_NAME;
      v_AUDITORIUM_CAPACITY := i.AUDITORIUM_CAPACITY;
      DBMS_OUTPUT.PUT_LINE('AUDITORIUM: ' || v_AUDITORIUM || ', AUDITORIUM_NAME: ' || v_AUDITORIUM_NAME ||
                           ', AUDITORIUM_CAPACITY: ' || v_AUDITORIUM_CAPACITY);
    END LOOP;
end;

-- 17. Создайте AБ. Уменьшите вместимость всех аудиторий (таблица AUDITORIUM) вместимостью от 40 до 80 на 10%.
-- Используйте явный курсор с параметрами, цикл FOR, конструкцию UPDATE CURRENT OF.

DECLARE
  CURSOR c_AUDITORIUM IS
    SELECT *
    FROM AUDITORIUM
    WHERE AUDITORIUM_CAPACITY >= 40
      and AUDITORIUM_CAPACITY <= 80
      FOR UPDATE;
BEGIN
  FOR i IN c_AUDITORIUM
    LOOP
      UPDATE AUDITORIUM
      SET AUDITORIUM_CAPACITY = AUDITORIUM_CAPACITY * 0.9
      WHERE CURRENT OF c_AUDITORIUM;
    END LOOP;
end;

-- 18. Создайте AБ. Удалите все аудитории (таблица AUDITORIUM) вместимостью от 0 до 20.
-- Используйте явный курсор с параметрами, цикл WHILE, конструкцию UPDATE CURRENT OF.

DECLARE
  v_AUDITORIUM AUDITORIUM.AUDITORIUM%TYPE;
  CURSOR c_AUDITORIUM IS
    SELECT AUDITORIUM
    FROM AUDITORIUM
    WHERE AUDITORIUM_CAPACITY >= 0
      and AUDITORIUM_CAPACITY <= 20
      FOR UPDATE;
BEGIN
  OPEN c_AUDITORIUM;
  LOOP
    FETCH c_AUDITORIUM INTO v_AUDITORIUM;
    EXIT WHEN c_AUDITORIUM%NOTFOUND;
    DELETE
    FROM AUDITORIUM
    WHERE CURRENT OF c_AUDITORIUM;
  END LOOP;

  CLOSE c_AUDITORIUM;
end;

-- 19. Создайте AБ. Продемонстрируйте применение псевдостолбца ROWID в операторах UPDATE и DELETE.

DECLARE
  CURSOR c_AUDITORIUM IS
    SELECT ROWID
    FROM AUDITORIUM
    WHERE AUDITORIUM_CAPACITY >= 0
      and AUDITORIUM_CAPACITY <= 20
      FOR UPDATE;
BEGIN
  FOR i IN c_AUDITORIUM
    LOOP
      UPDATE AUDITORIUM
      SET AUDITORIUM_CAPACITY = AUDITORIUM_CAPACITY * 0.9
      WHERE ROWID = i.ROWID;
      DELETE
      FROM AUDITORIUM
      WHERE ROWID = i.ROWID;
    END LOOP;
end;

-- 20. Распечатайте в одном цикле всех преподавателей (TEACHER), разделив группами по три
-- (отделите группы линией -------------).

DECLARE
  v_TEACHER      TEACHER.TEACHER%TYPE;
  v_TEACHER_NAME TEACHER.TEACHER_NAME%TYPE;
  v_PULPIT       TEACHER.PULPIT%TYPE;
  CURSOR c_TEACHER IS
    SELECT TEACHER,
           TEACHER_NAME,
           PULPIT
    FROM TEACHER;
BEGIN
  OPEN c_TEACHER;
  LOOP
    FETCH c_TEACHER INTO v_TEACHER, v_TEACHER_NAME, v_PULPIT;
    EXIT WHEN c_TEACHER%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('TEACHER: ' || v_TEACHER || ', TEACHER_NAME: ' || v_TEACHER_NAME || ', PULPIT: ' ||
                         v_PULPIT);
    IF MOD(c_TEACHER%ROWCOUNT, 3) = 0 THEN
      DBMS_OUTPUT.PUT_LINE('-----------------');
    END IF;
  END LOOP;

  CLOSE c_TEACHER;
end;
