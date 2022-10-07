-- 1.1 Для кожної таблиці БД створити команди внесення даних, тобто внести по два рядки.
INSERT INTO type (code, name)
VALUES (1, 'Bed');
INSERT INTO type (code, name)
VALUES (2, 'Table');

INSERT INTO furniture (id, name, type_code, producer, amount, production_time, price)
VALUES (1, 'Bed N1', 1, 'Lviv factory', 10, 30, 7000.00);
INSERT INTO furniture (id, name, type_code, producer, amount, production_time, price)
VALUES (2, 'Table N1', 2, 'Kyiv furniture', 35, 15, 2500.00);

-- Вимушений задати формат дати ще тут, адже наступні таблиці мають колонки з типом Date
ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';

INSERT INTO client (id, name, address, phone_number, birthday)
VALUES (1, 'Serhii Lyakhovetsky', 'Lutsk, Some str. 5', '380656259428', '27/12/1999');
INSERT INTO client (id, name, address, phone_number, birthday)
VALUES (2, 'Danylo Kucherenko', 'Kharkiv, Some str. 13', '38065688311', '19/03/1984');

INSERT INTO "ORDER" (id, client_id, creation_date, deadline_date, summary_price, is_paid, is_done)
VALUES (1, 1, '01/10/2022', '01/11/2022', 7000.00 * 5, 'Y', 'N');
INSERT INTO "ORDER" (id, client_id, creation_date, deadline_date, summary_price, is_paid, is_done)
VALUES (2, 2, '15/09/2022', '22/09/2022', 2500.00 * 7, 'Y', 'Y');

INSERT INTO sale (id, order_id, furniture_id, amount)
VALUES (1, 1, 1, 5);
INSERT INTO sale (id, order_id, furniture_id, amount)
VALUES (2, 2, 2, 7);

-- 1.2 Для однієї з таблиць створити команду додавання колонки типу date з урахуванням
-- предметної області.
ALTER TABLE furniture
    ADD last_supply_date DATE;

-- 1.3 Для зазначеної таблиці створити команду на внесення одного рядка, але з невизначеним
-- значенням колонки типу date.
INSERT INTO furniture (id, name, type_code, producer, amount, production_time, price, last_supply_date)
VALUES (3, 'Bed N2', 001, 'RRR Company', 30, 45, 13000.00, NULL);

-- 1.4 Створити команду налаштування формату date = dd/mm/yyyy
ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';

-- 1.5 Для задіяної в завданні 1.2 таблиці створити ще одну команду на внесення одного рядка
-- з урахуванням значення колонки типу date.
INSERT INTO furniture (id, name, type_code, producer, amount, production_time, price, last_supply_date)
VALUES (4, 'Bed N3', 001, 'Based Corporation', 30, 60, 9000.00, '30/01/2022');

-- 1.6 Для однієї з таблиць, що містить обмеження цілісності потенційного ключа, виконати
-- команду додавання нового рядка зі значенням колонки, що порушує це обмеження. Перевірити
-- реакцію СКБД на таку зміну.

INSERT INTO type (code, name, description)
VALUES (3, 'Bed', 'Some description...');

-- Результат : помилка
-- [23000][1] ORA-00001: unique constraint (POSHTARENKO.TYPE_NAME_UNIQUE) violated

-- 1.7 Для однієї з таблиць, що містить обмеження цілісності зовнішнього ключа, виконати
-- команду додавання нового рядка зі значенням колонки зовнішнього ключа, який відсутній у
-- колонці первинного ключа відповідної таблиці. Перевірити реакцію СКБД на подібне додавання,
-- яке порушує обмеження цілісності зовнішнього ключа.

INSERT INTO "ORDER" (id, client_id, creation_date, deadline_date, summary_price, is_paid, is_done)
VALUES  (3, 1234567, '01/01/2022', '15/01/2022', 3000.00, 'Y', 'Y');
-- Результат : помилка
-- [23000][2291] ORA-02291: integrity constraint (POSHTARENKO.ORDER_CLIENT_ID_FK) violated - parent key not found

