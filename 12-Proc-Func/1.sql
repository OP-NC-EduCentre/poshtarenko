-- 1.1. Повторіть виконання завдання 4 етапу 1 із попередньої лабораторної роботи:
-- − циклічно внести 5000 рядків;
-- − визначити загальний час на внесення зазначених рядків;
-- − вивести на екран значення часу.

DECLARE
    t1    TIMESTAMP;
    t2    TIMESTAMP;
    delta NUMBER;
BEGIN
    t1 := SYSTIMESTAMP;
    FOR i IN 1..5000
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
ROLLBACK;

-- Time = 1,056s

-- 1.2. Повторіть виконання попереднього завдання, порівнявши час виконання
-- циклічних внесень рядків, використовуючи два способи: FOR і FORALL.

CREATE TABLE client1
(
    id   INT PRIMARY KEY,
    name VARCHAR(128)
);

CREATE TABLE client2
(
    id   INT PRIMARY KEY,
    name VARCHAR(128)
);

DECLARE
    TYPE num_tab IS TABLE OF client.id%TYPE INDEX BY PLS_INTEGER;
    TYPE name_tab IS TABLE OF client.name%TYPE INDEX BY PLS_INTEGER;
    client_ids          num_tab;
    client_names        name_tab;
    iterations CONSTANT PLS_INTEGER := 5000;
    t1                  INTEGER;
    t2                  INTEGER;
    delta1              INTEGER;
    delta2              INTEGER;
BEGIN
    FOR j IN 1..iterations
        LOOP
            client_ids(j) := j;
            client_names(j) := TO_CHAR(j);
        END LOOP;
    t1 := dbms_utility.get_time;

    FOR i IN 1..iterations
        LOOP
            INSERT
            INTO client1 (id, name)
            VALUES (client_ids(i), client_names(i));
        END LOOP;
    t2 := dbms_utility.get_time;

    delta1 := t2 - t1;
    t1 := dbms_utility.get_time;

    FORALL i IN 1..iterations
        INSERT
        INTO client2 (id, name)
        VALUES (client_ids(i), client_names(i));
    t2 := dbms_utility.get_time;

    delta2 := t2 - t1;
    dbms_output.put_line('FOR-loop: ' || delta1 || 'ms');
    dbms_output.put_line('FORALL-operator: ' || delta2 || 'ms');
    COMMIT;
END;
/
ROLLBACK;

-- FOR-loop: 37ms
-- FORALL-operator: 4ms

-- 1.3. Для однієї з таблиць отримайте рядки з використанням курсору та пакетної
-- обробки SELECT-операції з оператором BULK COLLECT.

DECLARE
    CURSOR furniture_list_cursor IS
        SELECT id,
               name,
               price
        FROM furniture;
    TYPE furniture_list_bulk_type IS TABLE OF furniture_list_cursor%ROWTYPE;
    furniture_list_bulk furniture_list_bulk_type;
BEGIN
    dbms_output.put_line('Список меблів (використовуємо CURSOR) :');
    dbms_output.put_line(RPAD('ID', 20, ' ') || RPAD('Name', 20, ' ') || 'Price');
    FOR furniture_item IN furniture_list_cursor
        LOOP
            dbms_output.put_line(RPAD(furniture_item.id, 20, ' ')
                || RPAD(furniture_item.name, 20, ' ')
                || furniture_item.price);
        END LOOP;

    dbms_output.put_line('Список меблів (використовуємо BULK COLLECT) :');
    SELECT id,
           name,
           price BULK COLLECT
    INTO furniture_list_bulk
    FROM furniture;
    dbms_output.put_line(RPAD('ID', 20, ' ') || RPAD('Name', 20, ' ') || 'Price');
    FOR i IN furniture_list_bulk.first..furniture_list_bulk.last
        LOOP
            dbms_output.put_line(RPAD(furniture_list_bulk(i).id, 20, ' ')
                || RPAD(furniture_list_bulk(i).name, 20, ' ')
                || furniture_list_bulk(i).price);
        END LOOP;
END;
/

-- Список меблів (використовуємо CURSOR) :
-- ID                  Name                Price
-- 1                   Bed NNN1            7000
-- 2                   Table N33           5500
-- 3                   Table N2            13000
-- 4                   Bed N3              9500
-- 6                   Shelf N453          3000
-- 5                   Bed N4              11300
-- Список меблів (використовуємо BULK COLLECT) :
-- ID                  Name                Price
-- 1                   Bed NNN1            7000
-- 2                   Table N33           5500
-- 3                   Table N2            13000
-- 4                   Bed N3              9500
-- 6                   Shelf N453          3000
-- 5                   Bed N4              11300

