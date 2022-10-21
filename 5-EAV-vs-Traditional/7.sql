-- 7.1 Виконати запит до БД, результат якого відповідає результату виконання запиту на підставі
-- рішення завдання No 4.2 лабораторної роботи No 3:
-- Для однієї з таблиць створити команду отримання значень всіх колонок (явно перерахувати) за
-- окремими рядками з урахуванням умови: символьне значення однієї з колонок має співпадати з якимось
-- константним значенням.

SELECT clients.object_id   id,
       clients.name        name,
       address.value       address,
       phone.value         phone,
       birthday.date_value birthday
FROM objects clients,
     objtype clients_type,
     attributes address,
     attributes phone,
     attributes birthday
WHERE clients_type.code = 'Client'
  AND clients_type.object_type_id = clients.object_type_id
  AND clients.object_id = address.object_id
  AND address.attr_id = 2
  AND clients.object_id = phone.object_id
  AND phone.attr_id = 3
  AND clients.object_id = birthday.object_id
  AND birthday.attr_id = 4
  AND address.value LIKE 'М. Южне%';

-- +--+-----------------+------------------------+------------+----------+
-- |ID|NAME             |ADDRESS                 |PHONE       |BIRTHDAY  |
-- +--+-----------------+------------------------+------------+----------+
-- |2 |Дмитро Компанієць|М. Южне, вул. Хіміків 14|+38093178132|1993-11-27|
-- +--+-----------------+------------------------+------------+----------+

-- 7.2 Виконати запит до БД, результат якого відповідає результату виконання запиту на підставі
-- рішення завдання No 6.1 лабораторної роботи No 3:
-- Для однієї з таблиць створити команду отримання кількості рядків таблиці.

SELECT COUNT(object_id) AS "Count of clients"
FROM objects
WHERE object_type_id = 1;

-- Результат :
-- 2

-- 7.3 Виконати запит до БД, результат якого відповідає результату виконання запиту на підставі
-- рішення завдання No 3.2 лабораторної роботи No 4:
-- Для двох таблиць, пов'язаних через PK-колонку та FK-колонку, створити команду отримання двох
-- колонок першої та другої таблиць з використанням екві-з’єднання таблиць. Використовувати префікси.

-- Виведемо імена клієнтів разом з датою дедлайну виконання їхніх замовлень

SELECT client_name.value              AS client_name,
       order_deadline_date.date_value AS order_deadline
FROM objects clients,
     objects orders,
     attributes client_name,
     attributes order_deadline_date
WHERE clients.object_id = orders.parent_id
  AND clients.object_id = client_name.object_id
  AND client_name.attr_id = 1
  AND orders.object_id = order_deadline_date.object_id
  AND order_deadline_date.attr_id = 6;

-- +------------------+--------------+
-- |CLIENT_NAME       |ORDER_DEADLINE|
-- +------------------+--------------+
-- |Сергій Ляховецький|2022-11-21    |
-- |Дмитро Компанієць |2022-10-01    |
-- +------------------+--------------+