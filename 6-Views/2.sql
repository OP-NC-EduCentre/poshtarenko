-- 2.1 Створити віртуальну таблицю, структура та вміст якої відповідає рішенню завдання
-- 2.3 з лабораторної роботи No5, але враховує опцію «WITH READ ONLY»: отримати інформацію
-- про атрибутні типи. Отримати вміст таблиці.

CREATE OR REPLACE VIEW objecttype_attr
            (object_code,
             attr_id,
             attr_code,
             attr_name)
AS
SELECT o.code,
       a.attr_id,
       a.code,
       a.name
FROM objtype o,
     attrtype a
WHERE o.object_type_id = a.object_type_id
ORDER BY a.object_type_id, a.attr_id
WITH READ ONLY;

SELECT object_code,
       attr_id,
       attr_code,
       attr_name
FROM objecttype_attr;

-- +-----------+-------+---------------+------------------+
-- |OBJECT_CODE|ATTR_ID|ATTR_CODE      |ATTR_NAME         |
-- +-----------+-------+---------------+------------------+
-- |Client     |1      |NAME           |Імя               |
-- |Client     |2      |ADRESS         |Адреса            |
-- |Client     |3      |PHONE          |Телефон           |
-- |Client     |4      |BIRTHDAY       |День народження   |
-- |Order      |5      |CREATION_DATE  |Дата створення    |
-- |Order      |6      |DEADLINE_DATE  |Дата закінчення   |
-- |Order      |7      |SUMMARY_PRICE  |Остаточна вартість|
-- |Order      |8      |IS_PAID        |Чи оплачено       |
-- |Order      |9      |IS_DONE        |Чи виконано       |
-- |Sale       |10     |AMOUNT         |Кількість         |
-- |Furniture  |11     |NAME           |Назва             |
-- |Furniture  |12     |PRODUCER       |Виробник          |
-- |Furniture  |13     |IS_PRESENT     |Чи є в наявності  |
-- |Furniture  |14     |AMOUNT         |Кількість         |
-- |Furniture  |15     |PRODUCTION_TIME|Час виробництва   |
-- |Furniture  |16     |PRICE          |Ціна              |
-- |Furniture  |19     |TRANSPORTATION |Перевезення       |
-- |Truck      |17     |MAX WEIGHT     |Максимальна вага  |
-- |Truck      |18     |SPEED          |Швидкість         |
-- +-----------+-------+---------------+------------------+

-- 2.2 Виконати видалення одного рядка з віртуальної таблиці, створеної у попередньому
-- завданні. Прокоментувати реакцію СУБД.

DELETE FROM objecttype_attr WHERE objecttype_attr.attr_id = 5;

-- ORA-42399: cannot perform a DML operation on a read-only view
-- Як і передбачалося, view працює лише у режимі для читання і не дозволяє виконувати над нею DML команди

-- 2.3 Створити віртуальну таблицю, що містить дві колонки:
-- назва класу, кількість екземплярів об'єктів класу. Отримати вміст таблиці.

CREATE OR REPLACE VIEW object_count
    (object_type, objects_count)
AS
SELECT objtype.name,
       COUNT(objects.object_id)
FROM objtype,
     objects
WHERE objects.object_type_id = objtype.object_type_id
GROUP BY objtype.name;

SELECT object_type, objects_count FROM object_count;

-- +-----------+-----+
-- |OBJECT_TYPE|COUNT|
-- +-----------+-----+
-- |Меблі      |1    |
-- |Клієнт     |2    |
-- |Замовлення |2    |
-- |Вантажівки |1    |
-- +-----------+-----+


-- 2.4 Перевірити можливість виконання операції зміни даних у віртуальній таблиці,
-- створеної у попередньому завданні. Прокоментувати реакцію СУБД.

UPDATE object_count
SET objects_count = 500
WHERE object_count.object_type = 'Замовлення';

-- ORA-01732: data manipulation operation not legal on this view
-- БД не дає нам змінювати зміст таблиці, тому що тут присутня колонка, яка є результатом функції агрегації