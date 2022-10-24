-- 4.1 Створити таблицю описів екземплярів об'єктів.
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

-- 4.2 На основі вмісту двох рядків двох таблиць, заповнених у лабораторній роботі No3,
-- заповнити описи екземплярів об'єктів.

INSERT INTO objects (object_id, parent_id, object_type_id, name, description)
    VALUES (1, NULL, 1, 'Сергій Ляховецький', NULL);
INSERT INTO objects (object_id, parent_id, object_type_id, name, description)
    VALUES (2, NULL, 1, 'Дмитро Компанієць', NULL);

INSERT INTO objects (object_id, parent_id, object_type_id, name, description)
    VALUES (3, 1, 2, 'Замовлення №1', NULL);
INSERT INTO objects (object_id, parent_id, object_type_id, name, description)
    VALUES (4, 2, 2, 'Замовлення №2', NULL);


-- 4.3 Отримати колекцію екземплярів об'єктів для одного з об'єктних типів, використовуючи
-- його код.

SELECT object_id, name
FROM objects
WHERE object_type_id = 1;

-- +---------+------------------+
-- |OBJECT_ID|NAME              |
-- +---------+------------------+
-- |1        |Сергій Ляховецький|
-- |2        |Дмитро Компанієць |
-- +---------+------------------+

-- 4.4 Отримати один екземпляр об'єкта заданого імені для одного з об'єктних типів,
-- використовуючи його код.

SELECT clients.object_id, clients.name
FROM objects clients,
     objtype
WHERE clients.object_id = 2
  AND objtype.code = 'Client'
  AND objtype.object_type_id = clients.object_type_id;

-- +---------+-----------------+
-- |OBJECT_ID|NAME             |
-- +---------+-----------------+
-- |2        |Дмитро Компанієць|
-- +---------+-----------------+