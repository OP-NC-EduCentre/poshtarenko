-- 5.1 Створити таблицю описів значень атрибутів екземплярів об'єктів.

CREATE TABLE attributes
(
    attr_id       NUMBER(10),
    object_id     NUMBER(20),
    value         VARCHAR2(4000),
    date_value    DATE,
    list_value_id NUMBER(10)
);

ALTER TABLE attributes
    ADD CONSTRAINT attributes_pk
        PRIMARY KEY (attr_id, object_id);
ALTER TABLE attributes
    ADD CONSTRAINT attributes_list_value_id_fk
        FOREIGN KEY (list_value_id) REFERENCES lists (list_value_id);
ALTER TABLE attributes
    ADD CONSTRAINT attributes_attr_id_fk
        FOREIGN KEY (attr_id) REFERENCES attrtype (attr_id);
ALTER TABLE attributes
    ADD CONSTRAINT attributes_object_id_fk
        FOREIGN KEY (object_id) REFERENCES objects (object_id);

-- 5.2 На основі вмісту двох рядків двох таблиць, заповнених у лабораторній роботі No3, та опису
-- атрибутів екземплярів об'єктів, заповнити описи значень атрибутів екземплярів об'єктів.

ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';

INSERT INTO attributes(attr_id, object_id, value)
    VALUES (1, 1, 'Сергій Ляховецький');
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (2, 1, 'М. Канів, вул. Батуринська 13');
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (3, 1, '+38049849841');
INSERT INTO attributes(attr_id, object_id, date_value)
    VALUES (4, 1, '11/02/1986');

INSERT INTO attributes(attr_id, object_id, value)
    VALUES (1, 2, 'Дмитро Компанієць');
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (2, 2, 'М. Южне, вул. Хіміків 14');
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (3, 2, '+38093178132');
INSERT INTO attributes(attr_id, object_id, date_value)
    VALUES (4, 2, '27/11/1993');

INSERT INTO attributes(attr_id, object_id, date_value)
    VALUES (5, 3, '21/10/2022');
INSERT INTO attributes(attr_id, object_id, date_value)
    VALUES (6, 3, '21/11/2022');
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (7, 3, 11000.00);
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (8, 3, 'N');
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (9, 3, 'N');

INSERT INTO attributes(attr_id, object_id, date_value)
    VALUES (5, 4, '13/09/2022');
INSERT INTO attributes(attr_id, object_id, date_value)
    VALUES (6, 4, '01/10/2022');
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (7, 4, 5000.00);
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (8, 4, 'Y');
INSERT INTO attributes(attr_id, object_id, value)
    VALUES (9, 4, 'N');


-- 5.3 Модифікувати рішення завдання 4.3, отримавши колекцію екземплярів об'єктів за заданим
-- значенням одного з атрибутів об'єктів.

-- Отримаємо наших клієнтів з їхніми номерами телефонів.

SELECT clients.object_id,
       clients.name,
       phone.value phone
FROM objects clients,
     objtype clients_type,
     attributes phone
WHERE clients_type.code = 'Client'
  AND clients_type.object_type_id = clients.object_type_id
  AND clients.object_id = phone.object_id
  AND phone.attr_id = 3;

-- +---------+------------------+------------+
-- |OBJECT_ID|NAME              |PHONE       |
-- +---------+------------------+------------+
-- |1        |Сергій Ляховецький|+38049849841|
-- |2        |Дмитро Компанієць |+38093178132|
-- +---------+------------------+------------+