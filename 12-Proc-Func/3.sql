-- 3.1. Оформіть рішення завдань етапу 2 у вигляді програмного пакета. Наведіть
-- приклад виклику збереженої процедури та функції, враховуючи назву пакету.

CREATE OR REPLACE PACKAGE furniture_utils IS
    PROCEDURE insert_n_rows_to_furniture(n_rows IN NUMBER);
    FUNCTION calc_sum_price_by_producer(producer_name IN furniture.producer%TYPE) RETURN NUMBER;
END furniture_utils;
/

CREATE OR REPLACE PACKAGE BODY furniture_utils IS
    PROCEDURE insert_n_rows_to_furniture(n_rows IN NUMBER)
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

    FUNCTION calc_sum_price_by_producer(producer_name IN furniture.producer%TYPE)
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
END furniture_utils;
/

BEGIN
    insert_n_rows_to_furniture(3333);
    ROLLBACK;
    dbms_output.put_line('Загальна вартість всіх меблів : ' || furniture_utils.calc_sum_price_by_producer('Lviv_factory'));
END;
/

-- Time = ,66s
-- Загальна вартість всіх меблів : 21300