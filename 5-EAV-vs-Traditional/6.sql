-- 6.1 Створити таблицю описів зв'язків "іменована асоціація" між екземплярами об'єктів.
CREATE TABLE objreference
(
    attr_id   NUMBER(20),
    reference NUMBER(20),
    object_id NUMBER(20)
);

ALTER TABLE OBJREFERENCE ADD CONSTRAINT OBJREFERENCE_PK
    PRIMARY KEY (ATTR_ID,REFERENCE,OBJECT_ID);
ALTER TABLE OBJREFERENCE ADD CONSTRAINT OBJREFERENCE_REFERENCE_FK
    FOREIGN KEY(REFERENCE) REFERENCES OBJECTS(OBJECT_ID);
ALTER TABLE OBJREFERENCE ADD CONSTRAINT OBJREFERENCE_OBJECT_ID_FK
    FOREIGN KEY (OBJECT_ID) REFERENCES OBJECTS(OBJECT_ID);
ALTER TABLE OBJREFERENCE ADD CONSTRAINT OBJREFERENCE_ATTR_ID_FK
    FOREIGN KEY (ATTR_ID) REFERENCES ATTRTYPE (ATTR_ID);

-- 6.2 Заповнити таблицю зв'язків з урахуванням можливих зв'язків «іменована асоціація» між
-- раніше створеними екземплярами об'єктів класів.

-- Спочатку створимо відповідні об'єкти, бо раніше створені об'єкти не мають зв'язків
-- типу "іменована асоціація"
INSERT INTO objects (object_id, parent_id, object_type_id, name, description)
    VALUES (5, NULL, 4, 'Диван №333', NULL);
INSERT INTO objects (object_id, parent_id, object_type_id, name, description)
    VALUES (6, NULL, 5, 'Вантажівка «MAN»', NULL);


-- Об'єкт класу FURNITURE ("Диван №333", object_id = 5) буде зв'язаний з об'єктом класу
-- TRUCK ("Вантажівка «MAN»", object_id = 6) атрибутним зв'язком "TRANSPORTATION" (attr_id = 19)
-- з кратністю "багато до одного" (тобто багато меблів до одної вантажівки)
INSERT INTO objreference (attr_id, object_id, reference)
    VALUES (19, 5, 6);
