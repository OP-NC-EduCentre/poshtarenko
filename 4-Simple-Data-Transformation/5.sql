-- 5.1 Для однієї з таблиць створити команду отримання кількості рядків таблиці, згрупованих по
-- одній з колонок, яка також повинна бути отримана, об'єднавши її з командою отримання загальної
-- кількості рядків із зазначенням слова «Разом:», наприклад:

SELECT
    producer,
    COUNT(producer) AS "Count"
FROM furniture
GROUP BY producer
UNION ALL
SELECT
    'Total count of furniture :',
    COUNT(id)
FROM furniture;

-- PRODUCER|Count
-- Lviv factory|3
-- RRR Company|1
-- Based Corporation|1
-- Kyiv furniture|1
-- Total count of furniture :|6