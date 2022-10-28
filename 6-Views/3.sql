-- 3.1 Створити нового користувача, ім'я якого = «ваше_прізвище_латиницею»+'EAV',
-- наприклад, blazhko_eav, з правами, достатніми для створення та заповнення таблиць БД EAV.

CREATE USER poshtarenko_eav IDENTIFIED BY password;
GRANT CONNECT TO poshtarenko_eav;
GRANT CREATE TABLE TO poshtarenko_eav;
GRANT CREATE SEQUENCE TO poshtarenko_eav;
GRANT RESOURCE TO poshtarenko_eav;
ALTER USER poshtarenko_eav QUOTA UNLIMITED ON users;

-- 3.2 Створити таблиці БД EAV та заповнити таблиці об'єктних типів та атрибутних типів,
-- взявши рішення з лабораторної роботи No5.

-- 1) Об'єктні типи
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

INSERT INTO objtype (object_type_id, parent_id, code, name, description)
VALUES (1, NULL, 'Client', 'Клієнт', NULL);

INSERT INTO objtype (object_type_id, parent_id, code, name, description)
VALUES (2, 1, 'Order', 'Замовлення', NULL);

INSERT INTO objtype (object_type_id, parent_id, code, name, description)
VALUES (3, 2, 'Sale', 'Продаж', NULL);

INSERT INTO objtype (object_type_id, parent_id, code, name, description)
VALUES (4, 3, 'Furniture', 'Меблі', NULL);

-- 2) Атрибути

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

-- 3) Об'єкти

CREATE TABLE objects
(
    object_id      NUMBER(20),
    parent_id      NUMBER(20),
    object_type_id NUMBER(20),
    name           VARCHAR2(2000),
    description    VARCHAR2(4000)
);

ALTER TABLE OBJECTS ADD CONSTRAINT OBJECTS_PK
    PRIMARY KEY (OBJECT_ID);
ALTER TABLE OBJECTS ADD CONSTRAINT OBJECTS_PARENT_ID_FK
    FOREIGN KEY (PARENT_ID) REFERENCES OBJECTS (OBJECT_ID);
ALTER TABLE OBJECTS ADD CONSTRAINT OBJECTS_OBJECT_TYPE_ID_FK
    FOREIGN KEY (OBJECT_TYPE_ID) REFERENCES OBJTYPE (OBJECT_TYPE_ID);

-- 3.3 Створити генератор послідовності таблиці OBJECTS БД EAV, ініціалізувавши його
-- початковим значенням з урахуванням вже заповнених значень.
CREATE SEQUENCE objects_id_seq;

-- 3.4 Налаштувати права доступу нового користувача до таблиць схеми даних із таблицями
-- реляційної БД вашої предметної області, створеної в лабораторній роботі No2.

GRANT SELECT ON poshtarenko.client TO poshtarenko_eav;
GRANT SELECT ON poshtarenko."ORDER" TO poshtarenko_eav;
GRANT SELECT ON poshtarenko.sale TO poshtarenko_eav;
GRANT SELECT ON poshtarenko.furniture TO poshtarenko_eav;
GRANT SELECT ON poshtarenko.type TO poshtarenko_eav;

-- 3.5 Створити множину запитів типу INSERT INTO ... SELECT, які автоматично заповнять
-- таблицю OBJECTS, взявши потрібні дані з реляційної бази даних вашої предметної області.

INSERT
INTO objects (object_id, parent_id, object_type_id, name)
SELECT objects_id_seq.nextval, NULL, ot.object_type_id, c.name
FROM objtype ot,
     poshtarenko.client c
WHERE ot.code = 'Client';


INSERT
INTO objects (object_id, parent_id, object_type_id, name)
SELECT objects_id_seq.nextval, ob.object_id, ot.object_type_id, 'ORDER №' || orders.id
FROM objtype ot,
     poshtarenko.client client,
     poshtarenko."ORDER" orders,
     objects ob
WHERE ot.code = 'Order'
  AND client.id = orders.client_id
  AND client.name = ob.name;

INSERT
INTO objects (object_id, parent_id, object_type_id, name)
SELECT objects_id_seq.nextval, ob.object_id, ot.object_type_id, 'SALE №' || sale.id
FROM objtype ot,
     poshtarenko."ORDER" orders,
     poshtarenko.sale sale,
     objects ob
WHERE ot.code = 'Sale'
  AND orders.id = sale.order_id
  AND 'ORDER №' || orders.id = ob.name;

INSERT
INTO objects (object_id, parent_id, object_type_id, name)
SELECT objects_id_seq.nextval, ob.object_id, ot.object_type_id, furniture.name
FROM objtype ot,
     poshtarenko.furniture furniture,
     poshtarenko.sale sale,
     objects ob
WHERE ot.code = 'Furniture'
  AND furniture.id = sale.furniture_id (+)
  AND 'SALE №' || sale.id = ob.name (+);

SELECT object_id, parent_id, object_type_id, name FROM objects;

-- Деякі значення (меблі) в кінці таблиці мають parent_id = null, тому що в початковій таблиці
-- вони не були приписані до жодної батьківської сутності (продажу)

-- +---------+---------+--------------+-------------------+
-- |OBJECT_ID|PARENT_ID|OBJECT_TYPE_ID|NAME               |
-- +---------+---------+--------------+-------------------+
-- |1        |null     |1             |Serhii LyakhovetSky|
-- |2        |null     |1             |Danylo Kucherenko  |
-- |3        |null     |1             |Andriy Melnyk      |
-- |4        |null     |1             |Vasyl Vyshyvaniy   |
-- |5        |1        |2             |ORDER №1           |
-- |6        |1        |2             |ORDER №3           |
-- |7        |2        |2             |ORDER №2           |
-- |8        |4        |2             |ORDER №4           |
-- |9        |5        |3             |SALE №1            |
-- |10       |7        |3             |SALE №2            |
-- |11       |8        |3             |SALE №4            |
-- |12       |9        |4             |Bed N1             |
-- |13       |10       |4             |Table N1           |
-- |14       |11       |4             |Shelf N1           |
-- |15       |null     |4             |Bed N3             |
-- |16       |null     |4             |Bed N4             |
-- |17       |null     |4             |Bed N2             |
-- +---------+---------+--------------+-------------------+
