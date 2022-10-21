-- 2.1. Створити таблицю описів атрибутних типів.
CREATE TABLE attrtype
(
    attr_id            NUMBER(20),
    object_type_id     NUMBER(20),
    object_type_id_ref NUMBER(20),
    code               VARCHAR2(20),
    name               VARCHAR2(200)
);

ALTER TABLE attrtype
    ADD CONSTRAINT attrtype_pk
        PRIMARY KEY (attr_id);
ALTER TABLE attrtype
    ADD CONSTRAINT attrtype_object_type_id_fk
        FOREIGN KEY (object_type_id) REFERENCES objtype (object_type_id);
ALTER TABLE attrtype
    ADD CONSTRAINT attrtype_object_type_id_ref_fk
        FOREIGN KEY (object_type_id_ref) REFERENCES objtype (object_type_id);

-- 2.2 Для раніше використаних класів UML-діаграми заповнити описи атрибутних типів.
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (1, 1, NULL, 'NAME', 'Імя');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (2, 1, NULL, 'ADRESS', 'Адреса');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (3, 1, NULL, 'PHONE', 'Телефон');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (4, 1, NULL, 'BIRTHDAY', 'День народження');

INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (5, 2, NULL, 'CREATION_DATE', 'Дата створення');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (6, 2, NULL, 'DEADLINE_DATE', 'Дата закінчення');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (7, 2, NULL, 'SUMMARY_PRICE', 'Остаточна вартість');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (8, 2, NULL, 'IS_PAID', 'Чи оплачено');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (9, 2, NULL, 'IS_DONE', 'Чи виконано');

INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (10, 3, NULL, 'AMOUNT', 'Кількість');

INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (11, 4, NULL, 'NAME', 'Назва');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (12, 4, NULL, 'PRODUCER', 'Виробник');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (13, 4, NULL, 'IS_PRESENT', 'Чи є в наявності');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (14, 4, NULL, 'AMOUNT', 'Кількість');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (15, 4, NULL, 'PRODUCTION_TIME', 'Час виробництва');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (16, 4, NULL, 'PRICE', 'Ціна');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (19, 4, 5, 'TRANSPORTATION', 'Перевезення');

INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (17, 5, NULL, 'MAX WEIGHT', 'Максимальна вага');
INSERT INTO attrtype (attr_id, object_type_id, object_type_id_ref, code, name)
    VALUES (18, 5, NULL, 'SPEED', 'Швидкість');


-- 2.3 Отримати інформацію про атрибутні типи.

SELECT O.CODE,A.ATTR_ID,A.CODE,A.NAME
FROM OBJTYPE O, ATTRTYPE A
WHERE O.OBJECT_TYPE_ID = A.OBJECT_TYPE_ID
ORDER BY A.OBJECT_TYPE_ID,A.ATTR_ID;

-- +---------+-------+---------------+------------------+
-- |CODE     |ATTR_ID|CODE           |NAME              |
-- +---------+-------+---------------+------------------+
-- |Client   |1      |NAME           |Імя               |
-- |Client   |2      |ADRESS         |Адреса            |
-- |Client   |3      |PHONE          |Телефон           |
-- |Client   |4      |BIRTHDAY       |День народження   |
-- |Order    |5      |CREATION_DATE  |Дата створення    |
-- |Order    |6      |DEADLINE_DATE  |Дата закінчення   |
-- |Order    |7      |SUMMARY_PRICE  |Остаточна вартість|
-- |Order    |8      |IS_PAID        |Чи оплачено       |
-- |Order    |9      |IS_DONE        |Чи виконано       |
-- |Sale     |10     |AMOUNT         |Кількість         |
-- |Furniture|11     |NAME           |Назва             |
-- |Furniture|12     |PRODUCER       |Виробник          |
-- |Furniture|13     |IS_PRESENT     |Чи є в наявності  |
-- |Furniture|14     |AMOUNT         |Кількість         |
-- |Furniture|15     |PRODUCTION_TIME|Час виробництва   |
-- |Furniture|16     |PRICE          |Ціна              |
-- |Furniture|19     |TRANSPORTATION |Перевезення       |
-- |Truck    |17     |MAX WEIGHT     |Максимальна вага  |
-- |Truck    |18     |SPEED          |Швидкість         |
-- +---------+-------+---------------+------------------+

-- 2.4 Отримати інформацію про атрибутні типи та можливі зв'язки між ними типу «іменована
-- асоціація».

SELECT o.code, a.attr_id, a.code, a.name, o_ref.code o_ref
FROM objtype o,
     attrtype a
         LEFT JOIN objtype o_ref ON
         (a.object_type_id_ref = o_ref.object_type_id)
WHERE o.object_type_id = a.object_type_id
ORDER BY a.object_type_id, a.attr_id;

-- +---------+-------+---------------+------------------+-----+
-- |CODE     |ATTR_ID|CODE           |NAME              |O_REF|
-- +---------+-------+---------------+------------------+-----+
-- |Client   |1      |NAME           |Імя               |null |
-- |Client   |2      |ADRESS         |Адреса            |null |
-- |Client   |3      |PHONE          |Телефон           |null |
-- |Client   |4      |BIRTHDAY       |День народження   |null |
-- |Order    |5      |CREATION_DATE  |Дата створення    |null |
-- |Order    |6      |DEADLINE_DATE  |Дата закінчення   |null |
-- |Order    |7      |SUMMARY_PRICE  |Остаточна вартість|null |
-- |Order    |8      |IS_PAID        |Чи оплачено       |null |
-- |Order    |9      |IS_DONE        |Чи виконано       |null |
-- |Sale     |10     |AMOUNT         |Кількість         |null |
-- |Furniture|11     |NAME           |Назва             |null |
-- |Furniture|12     |PRODUCER       |Виробник          |null |
-- |Furniture|13     |IS_PRESENT     |Чи є в наявності  |null |
-- |Furniture|14     |AMOUNT         |Кількість         |null |
-- |Furniture|15     |PRODUCTION_TIME|Час виробництва   |null |
-- |Furniture|16     |PRICE          |Ціна              |null |
-- |Furniture|19     |TRANSPORTATION |Перевезення       |Truck|
-- |Truck    |17     |MAX WEIGHT     |Максимальна вага  |null |
-- |Truck    |18     |SPEED          |Швидкість         |null |
-- +---------+-------+---------------+------------------+-----+