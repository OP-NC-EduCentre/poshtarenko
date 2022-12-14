-- 1.1. Для всіх таблиць нової БД створити генератори послідовності, щоб забезпечити
-- автоматичне створення нових значень колонок, які входять у первинний ключ. Врахувати наявність
-- рядків у таблицях. Виконати тестове внесення одного рядка до кожної таблиці.

SELECT MAX(code) FROM type;
-- 3
CREATE SEQUENCE type_code_seq START WITH 4;
INSERT INTO type (code, name, description)
    VALUES (type_code_seq.nextval, 'Shelf', 'ddd');

SELECT MAX(id) FROM furniture;
-- 4
CREATE SEQUENCE furniture_id_seq START WITH 5;
INSERT INTO furniture (id, name, type_code, producer, amount, production_time, price)
    VALUES (furniture_id_seq.nextval, 'Bed N1', 1, 'Lviv factory', 100, 50, 10000);

SELECT MAX(id) FROM client;
-- 2
CREATE SEQUENCE client_id_seq START WITH 3;
INSERT INTO client (id, name, address, phone_number, birthday)
    VALUES (client_id_seq.nextval, 'Andriy Melnyk', 'Kriviy Rih, some str. 1', '38049846544', '11/11/1991');

SELECT MAX(id) FROM "ORDER";
-- 2
CREATE SEQUENCE order_id_seq START WITH 3;
INSERT INTO "ORDER" (id, client_id, creation_date, deadline_date, summary_price, is_paid, is_done)
    VALUES (order_id_seq.nextval, 1, '14/10/2022', '01/11/2022', 3000, 'N', 'N');

SELECT MAX(id) FROM sale;
-- 2
CREATE SEQUENCE sale_id_seq START WITH 3;
INSERT INTO sale (id, order_id, furniture_id, amount)
    VALUES (sale_id_seq.nextval, 1, 1, 5);


-- 1.2 Для всіх пар взаємопов'язаних таблиць створити транзакції, що включають дві INSERT-
-- команди внесення рядка в дві таблиці кожної пари з урахуванням зв'язку між PK-колонкою першої
-- таблиці і FK-колонкою 2-ї таблиці пари з використанням псевдоколонок NEXTVAL і CURRVAL.

INSERT INTO type (code, name)
    VALUES (type_code_seq.nextval, 'chair');

INSERT INTO furniture (id, name, type_code, producer, amount, production_time, price)
VALUES (furniture_id_seq.nextval, 'Shelf N1', type_code_seq.currval , 'Lviv factory', 100, 50, 10000);

INSERT INTO client (id, name, address, phone_number, birthday)
    VALUES (client_id_seq.nextval, 'Vasyl Vyshyvaniy', 'Lemberg, some str. 1', '380494354654', '01/03/1999');

INSERT INTO "ORDER" (id, client_id, creation_date, deadline_date, summary_price, is_paid, is_done)
    VALUES (order_id_seq.nextval, client_id_seq.currval, '14/10/2022', '01/11/2022', 3000, 'N', 'N');

INSERT INTO sale (id, order_id, furniture_id, amount)
    VALUES (sale_id_seq.nextval, order_id_seq.currval, furniture_id_seq.currval, 3);

-- 1.3 Отримати інформацію про створені генератори послідовностей, використовуючи системну
-- таблицю СУБД Oracle.

SELECT type_code_seq.currval FROM dual;
-- 5

SELECT furniture_id_seq.currval FROM dual;
-- 6

SELECT client_id_seq.currval FROM dual;
-- 4

SELECT order_id_seq.currval FROM dual;
-- 4

SELECT sale_id_seq.currval FROM dual;
-- 4

-- 1.4 Використовуючи СУБД Oracle >= 12 для однієї з таблиць створити генерацію унікальних
-- значень PK-колонки через DEFAULT-оператор. Виконати тестове внесення одного рядка до таблиці.

ALTER TABLE client MODIFY
    (id DEFAULT client_id_seq.nextval NOT NULL);

INSERT INTO client (id, name, address, phone_number, birthday)
    VALUES (client_id_seq.nextval, 'Sheih Mansur', 'Kyiv, some str. 1', '38014856532', '23/02/1979');