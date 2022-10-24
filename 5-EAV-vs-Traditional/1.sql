-- 1.1. Створити таблицю опису об'єктних типів.
CREATE TABLE objtype
(
    object_type_id NUMBER(20),
    parent_id      NUMBER(20),
    code           VARCHAR2(20),
    name           VARCHAR2(200),
    description    VARCHAR2(1000)
);

ALTER TABLE objtype
    ADD CONSTRAINT objtype_pk
        PRIMARY KEY (object_type_id);
ALTER TABLE objtype
    ADD CONSTRAINT objtype_code_unique
        UNIQUE (code);
ALTER TABLE objtype
    MODIFY (code NOT NULL);
ALTER TABLE objtype
    ADD CONSTRAINT objtype_fk
        FOREIGN KEY (parent_id) REFERENCES objtype (object_type_id);

-- 1.2 Нехай у лабораторній роботі No1 було створено UML-діаграму концептуальних класів. Для
-- трьох класів з UML-діаграми, пов'язаних між собою, бажано зв'язком «узагальнення», «агрегатна
-- асоціація» та «іменована асоціація», заповнити опис об'єктних типів.
INSERT INTO objtype (object_type_id, parent_id, code, name, description)
    VALUES (1, NULL, 'Client', 'Клієнт', NULL);

INSERT INTO objtype (object_type_id, parent_id, code, name, description)
    VALUES (2, 1, 'Order', 'Замовлення', NULL);

INSERT INTO objtype (object_type_id, parent_id, code, name, description)
    VALUES (3, 2, 'Sale', 'Продаж', NULL);

INSERT INTO objtype (object_type_id, parent_id, code, name, description)
    VALUES (4, 3, 'Furniture', 'Меблі', NULL);

-- Цієї таблиці не мало бути в моїй предметній області, але я її додам для
-- демонстрації зв'язку типу "іменована асоціація"
INSERT INTO objtype (object_type_id, parent_id, code, name, description)
    VALUES (5, NULL, 'Truck', 'Вантажівки', NULL);



-- 1.3 Отримати інформацію про об'єктні типи.
SELECT OBJECT_TYPE_ID,
       PARENT_ID,
       CODE,
       NAME
FROM OBJTYPE;

-- +--------------+---------+---------+----------+
-- |OBJECT_TYPE_ID|PARENT_ID|CODE     |NAME      |
-- +--------------+---------+---------+----------+
-- |1             |null     |Client   |Клієнт    |
-- |2             |1        |Order    |Замовлення|
-- |3             |2        |Sale     |Продаж    |
-- |4             |3        |Furniture|Меблі     |
-- |5             |null     |Truck    |Вантажівки|
-- +--------------+---------+---------+----------+

-- 1.4 Отримати інформацію про об'єктні типи та можливі зв'язки між ними типу «узагальнення»,
-- «агрегатна асоціація».
SELECT p.object_type_id,
       p.code,
       c.object_type_id obj_t_id_link,
       c.code           code_link
FROM objtype c,
     objtype p
WHERE p.object_type_id = c.parent_id(+);

-- +--------------+---------+-------------+---------+
-- |OBJECT_TYPE_ID|CODE     |OBJ_T_ID_LINK|CODE_LINK|
-- +--------------+---------+-------------+---------+
-- |1             |Client   |2            |Order    |
-- |2             |Order    |3            |Sale     |
-- |3             |Sale     |4            |Furniture|
-- |4             |Furniture|null         |null     |
-- |5             |Truck    |null         |null     |
-- +--------------+---------+-------------+---------+