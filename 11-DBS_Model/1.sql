-- 1.1. Виберіть таблицю бази даних, що містить стовпець типу date. Оголосіть змінні, що
-- відповідають стовпцям цієї таблиці, використовуючи посилальні типи даних. Надайте змінним
-- значення, використовуйте SQL-функції для формування значень послідовності, перетворення
-- дати до вибраного стилю. Виведіть на екран рядок.

DECLARE
    v_client client%ROWTYPE;
BEGIN
    v_client.id := client_id_seq.nextval;
    v_client.name := 'Volker Ritter';
    v_client.phone_number := '+382184984161';
    v_client.email := 'volker1985@urk.net';
    v_client.address := 'Odesa, Govorova str. 4A';
    v_client.birthday := TO_DATE('10/07/1985', 'DD/MM/YYYY');
    dbms_output.put_line('id = ' || v_client.id);
    dbms_output.put_line('birthday = ' || v_client.birthday);
END;
/

-- id = 107
-- birthday = 10.07.1985

-- 1.2. Додати інформацію до однієї з таблиць, обрану у попередньому завданні.
-- Використовувати формування нового значення послідовності та перетворення формату дати.

BEGIN
    INSERT
    INTO client (id, name, address, phone_number, birthday, email)
    VALUES (client_id_seq.nextval, 'Volker Ritter', 'Odesa, Govorova str. 4A', '+51(401)590-01-22',
            TO_DATE('10/07/1985', 'DD/MM/YYYY'), 'volker@ukr.com.ua');
END;
/

-- OK

-- 1.3. Для однієї з таблиць створити команду отримання середнього значення однієї з
-- цілих колонок, використовуючи умову вибірки за заданим значенням іншої колонки. Результат
-- присвоїти змінній і вивести на екран.

DECLARE
    v_furniture_avg_price furniture.price%TYPE;
BEGIN
    SELECT AVG(price)
    INTO v_furniture_avg_price
    FROM furniture
    WHERE producer = 'Lviv factory';
    dbms_output.put_line('Average price of Lviv factory furniture = ' || v_furniture_avg_price);
END;
/

-- Average price of Lviv factory furniture = 7100

-- 1.4. Виконайте введення 5 рядків у таблицю бази даних, використовуючи цикл з
-- параметрами. Значення первинного ключа генеруються автоматично, решта даних дублюється.

BEGIN
    FOR i IN 1..5
        LOOP
            INSERT
            INTO client (id, name, address, phone_number, birthday, email)
            VALUES (client_id_seq.nextval, 'Charlotte Rat', 'Kyiv, Istorychna str. 4A', '+56(401)590-01-22',
                    TO_DATE('10/07/1999', 'DD/MM/YYYY'), 'charlotte@ukr.com.ua');
        END LOOP;
END;
/

-- OK