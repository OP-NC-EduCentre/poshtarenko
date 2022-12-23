-- 2.1. Повторити виконання завдання 1 етапу 1, створивши процедуру з вхідним
-- параметром у вигляді кількості рядків, що вносяться.
-- Навести приклад виконання створеної процедури.

CREATE OR REPLACE PROCEDURE insert_n_rows_to_furniture(n_rows IN NUMBER)
    IS
    t1    TIMESTAMP;
    t2    TIMESTAMP;
    delta NUMBER;
BEGIN
    t1 := SYSTIMESTAMP;
    FOR i IN 1..n_rows
        LOOP
            INSERT
            INTO client (id, name, address, phone_number, birthday, email)
            VALUES (client_id_seq.nextval, 'Charlotte Rat', 'Kyiv, Istorychna str. 4A', '+56(401)590-01-22',
                    TO_DATE('10/07/1999', 'DD/MM/YYYY'), 'charlotte@ukr.com.ua');
        END LOOP;
    t2 := SYSTIMESTAMP;
    delta := TO_NUMBER(TO_CHAR(t2, 'HHMISS.FF3'), '999999.999') -
             TO_NUMBER(TO_CHAR(t1, 'HHMISS.FF3'), '999999.999');
    dbms_output.put_line('Time = ' || delta || 's');
END;
/

BEGIN
    insert_n_rows_to_furniture(3333);
    ROLLBACK;
END;
/

-- Time = ,741s

-- 2.2. Створити функцію, яка повертає суму значень однієї з цілих колонок однієї з
-- таблиць. Навести приклад виконання створеної функції.

CREATE OR REPLACE FUNCTION calc_sum_price_by_producer(producer_name IN furniture.producer%TYPE)
    RETURN NUMBER
    IS
    result NUMBER;
BEGIN
    SELECT SUM(price)
    INTO result
    FROM furniture
    WHERE producer = producer_name;
    RETURN result;
END;
/

BEGIN
    dbms_output.put_line('Загальна вартість всіх меблів : ' || calc_sum_price_by_producer('Lviv_factory'));
END;
/

-- Загальна вартість всіх меблів : 21300