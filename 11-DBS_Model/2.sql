-- 2.1. Повторити виконання завдання 3 етапу 1, забезпечивши контроль відсутності даних у
-- відповіді на запит із використанням винятку.

DECLARE
    v_furniture_price furniture.price%TYPE;
BEGIN
    SELECT price
    INTO v_furniture_price
    FROM furniture
    WHERE name = 'Not existing furniture';
    dbms_output.put_line('Furniture price = ' || v_furniture_price);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Furniture with selected name not found');
END;
/

-- Furniture with selected name not found

-- 2.2. Повторити виконання завдання 3 етапу 1, забезпечивши контроль отримання
-- багаторядкової відповіді на запит.

DECLARE
    v_furniture_price furniture.price%TYPE;
BEGIN
    SELECT price
    INTO v_furniture_price
    FROM furniture
    WHERE name LIKE '%Table%';
    dbms_output.put_line('Furniture price = ' || v_furniture_price);
EXCEPTION
    WHEN too_many_rows THEN
        dbms_output.put_line('Query return more than 1 furniture');
END;
/

-- Query return more than 1 furniture

-- 2.3. Повторити виконання завдання 3 етапу 1, забезпечивши контроль за внесенням
-- унікальних значень.

BEGIN
    INSERT
    INTO client (id, name, address, phone_number, birthday, email)
    VALUES (1, 'Volker Ritter', 'Odesa, Govorova str. 4A', '+51(401)590-01-22',
            TO_DATE('10/07/1985', 'DD/MM/YYYY'), 'volker@ukr.com.ua');
EXCEPTION
    WHEN dup_val_on_index THEN
        dbms_output.put_line('Unique constraint is violated');
END;
/

-- Unique constraint is violated