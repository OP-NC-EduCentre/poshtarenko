-- 1. Одна з колонок таблиць повинна містити строкове значення з двома словами,
-- розділеними пробілом. Виконайте команду UPDATE, помінявши місцями ці два слова.

UPDATE client
SET name = REGEXP_REPLACE(name, '([[:alpha:]]+)[[:space:]]([[:alpha:]]+)', '\2 \1');

SELECT name
FROM client;

-- +-------------------+
-- |NAME               |
-- +-------------------+
-- |Lyakhovetsky Serhii|
-- |Kucherenko Danylo  |
-- |Hanna Hanna        |
-- |Hromova Sofia      |
-- +-------------------+

-- 2. Одна з колонок таблиць має містити строкове значення з електронною поштовою
-- адресою у форматі EEE@EEE.EEE.UA, де E – будь-яка латинська буква. Створіть запит,
-- вилучення логіна користувача з електронної адреси (підстрока перед символом @).


SELECT REGEXP_REPLACE(email, '^(([[:alpha:]]+)\@[[:alpha:]]{3}\.[[:alpha:]]{3}\.ua)$', '\2') login
FROM client;


-- +-------------+
-- |LOGIN        |
-- +-------------+
-- |serhiilutsk  |
-- |dankucherenko|
-- |hanna        |
-- |shromova     |
-- +-------------+


-- 3. Одна з колонок таблиць повинна містити строкове значення з номером мобільного
-- телефону у форматі +XX(XXX)XXX-XX-XX, де X – цифра. Виконайте команду UPDATE,
-- додавши перед номером телефону фразу «Mobile:».

UPDATE client
SET phone_number = REGEXP_REPLACE(phone_number, '^(\+\d{2}\(\d{3}\)\d{3}-\d{2}-\d{2})$', 'Mobile:\1');

SELECT phone_number
FROM client;

-- +------------------------+
-- |PHONE_NUMBER            |
-- +------------------------+
-- |Mobile:+12(313)231-13-43|
-- |Mobile:+36(365)137-91-85|
-- |Mobile:+58(401)590-01-22|
-- |Mobile:+91(823)348-18-96|
-- +------------------------+

-- 4. Додайте до колонки з електронною адресою обмеження цілісності, що забороняє
-- вносити дані, відмінні від формату електронної адреси, використовуючи команду ALTER TABLE
-- таблиця ADD CONSTRAINT обмеження CHECK (умова). Перевірте роботу обмеження на двох
-- прикладах UPDATE-запитів із правильними та неправильними значеннями колонки.

ALTER TABLE client
    ADD CONSTRAINT email_is_correct
        CHECK (
            REGEXP_LIKE(
                    email,
                    '^([[:alpha:]]+\@[[:alpha:]]{3}\.[[:alpha:]]{3}\.ua)$'));

INSERT
INTO client (name, phone_number, email)
VALUES ('Tom White', '+15(823)324-18-12', 'some wrong string');

-- [23000][2290] ORA-02290: check constraint (POSHTARENKO.EMAIL_IS_CORRECT) violated

INSERT
INTO client (name, phone_number, email)
VALUES ('Tom White', '+15(823)324-18-12', 'tomwhite@ukr.com.ua');

-- OK : 1 row affected in 17 ms

-- 5. Видаліть зайві дані з колонки з номером мобільного телефону, залишивши тільки номер
-- телефону в заданому форматі.

UPDATE client
SET phone_number = REGEXP_REPLACE(phone_number, '(Mobile:)(\+\d{2}\(\d{3}\)\d{3}-\d{2}-\d{2})$', '\2');

SELECT phone_number FROM client;

-- +-----------------+
-- |PHONE_NUMBER     |
-- +-----------------+
-- |+12(313)231-13-43|
-- |+15(823)324-18-12|
-- |+36(365)137-91-85|
-- |+58(401)590-01-22|
-- |+91(823)348-18-96|
-- +-----------------+


-- 6. Додайте в колонку з мобільним телефоном обмеження цілісності, що забороняє вносити
-- дані, відмінні від формату, записаного в завданні 3. Перевірте роботу обмеження на двох
-- прикладах UPDATE-запитів із правильними та неправильними значеннями колонки.

ALTER TABLE client
    ADD CONSTRAINT phone_is_correct
        CHECK (
            REGEXP_LIKE(
                    phone_number,
                    '^(\+\d{2}\(\d{3}\)\d{3}-\d{2}-\d{2})$'));

INSERT
INTO client (name, phone_number, email)
VALUES ('Monica', '+380664898995', 'monica@ukr.com.ua');

-- [23000][2290] ORA-02290: check constraint (POSHTARENKO.PHONE_IS_CORRECT) violated

INSERT
INTO client (name, phone_number, email)
VALUES ('Tom White', '+14(823)348-18-96', 'tomwhite@ukr.com.ua');

-- OK : 1 row affected in 18 ms