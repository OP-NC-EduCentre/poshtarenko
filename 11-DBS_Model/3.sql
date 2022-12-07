-- 3.1. Виконайте DELETE-запит із попередніх рішень, додавши аналіз даних із неявного
-- курсору. Наприклад, кількість віддалених рядків

BEGIN
    DELETE FROM sale;
    dbms_output.put_line('Total deleted rows = ' || SQL%ROWCOUNT);
END;

-- Total deleted rows = 3

-- 3.2. Повторіть виконання завдання 3 етапу 1 з використанням явного курсору.

DECLARE
    CURSOR furniture_avg_sum_list IS
        SELECT producer,
               AVG(price) AS avg_price
        FROM furniture
        GROUP BY producer;
BEGIN
    dbms_output.put_line(RPAD('producer', 20, ' ') || 'avg_price');
    FOR producer_avg_price IN furniture_avg_sum_list
        LOOP
            dbms_output.put_line(RPAD(producer_avg_price.producer, 20, ' ')
                || producer_avg_price.avg_price);
        END LOOP;
END;
/

-- producer            avg_price
-- Lviv factory        7100
-- Based Corporation   11250
-- Kyiv furniture      5500

-- 3.3. З урахуванням вашої предметної області створити анонімний PL/SQL-блок, який
-- викликатиме один із варіантів подібних SQL-запитів залежно від значення версії СУБД.
-- При вирішенні використовувати:
-- − значення змінної DBMS_DB_VERSION.VERSION;
-- − явний курсор із параметричним циклом.

-- Створення запиту для отримання топ-5 найдорожчих меблів, згідно встановленої версії СКБД Oracle

BEGIN
    dbms_output.put_line('Oracle version = ' || dbms_db_version.version);

    IF dbms_db_version.version < 12 THEN
        DECLARE
            CURSOR furniture_list IS
                WITH furniture_name_price AS (SELECT name, price
                                              FROM furniture
                                              ORDER BY price DESC),
                     furniture_name_price_rownum AS (SELECT rownum AS r,
                                                            name,
                                                            price
                                                     FROM furniture_name_price)
                SELECT name,
                       price
                FROM furniture_name_price_rownum
                WHERE r <= 5;
        BEGIN
            dbms_output.put_line(RPAD('furniture', 15, ' ') || 'price');
            FOR item IN furniture_list
                LOOP
                    dbms_output.put_line(RPAD(item.name, 15, ' ')
                        || item.price);
                END LOOP;
        END;

    ELSE
        DECLARE
            CURSOR furniture_list IS
                SELECT name, price
                FROM furniture
                ORDER BY price DESC FETCH FIRST 5 ROWS ONLY;
        BEGIN
            dbms_output.put_line(RPAD('furniture', 15, ' ') || 'price');
            FOR item IN furniture_list
                LOOP
                    dbms_output.put_line(RPAD(item.name, 15, ' ')
                        || item.price);
                END LOOP;
        END;
    END IF;
END;
/

-- Oracle version = 18
-- furniture      price
-- Table N2       13000
-- Bed N4         11300
-- Bed N3         9500
-- Bed NNN1       7000
-- Table N33      5500



