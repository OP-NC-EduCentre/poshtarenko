ALTER TABLE Type ADD CONSTRAINT type_pk PRIMARY KEY (code);
ALTER TABLE Type ADD CONSTRAINT type_name_unique UNIQUE (name);
ALTER TABLE Type MODIFY (name NOT NULL);

ALTER TABLE Furniture ADD CONSTRAINT furniture_pk PRIMARY KEY (id);
ALTER TABLE Furniture Modify (name NOT NULL);
ALTER TABLE Furniture ADD CONSTRAINT furniture_type_code_fk 
    FOREIGN KEY (type_code) REFERENCES Type(code);
ALTER TABLE Furniture ADD CONSTRAINT amount_is_positive CHECK (amount > 0);
ALTER TABLE Furniture ADD CONSTRAINT production_time_not_zero CHECK (production_time > 0);
ALTER TABLE Furniture ADD CONSTRAINT price_not_zero CHECK (price > 0);

ALTER TABLE Client ADD CONSTRAINT client_pk PRIMARY KEY (id);
ALTER TABLE Client MODIFY (name NOT NULL);
ALTER TABLE Client MODIFY (phone_number NOT NULL);
ALTER TABLE Client ADD CONSTRAINT phone_number_unique UNIQUE (phone_number);

-- Назва "orders_pk", а не "order_pk", тому що чомусь виводилася помилка що constraint
-- з назвою "order_pk" вже існує :(
ALTER TABLE "Order" ADD CONSTRAINT orders_pk PRIMARY KEY (id);
ALTER TABLE "Order" ADD CONSTRAINT order_client_id_fk
    FOREIGN KEY (client_id) REFERENCES Client(id);
ALTER TABLE "Order" MODIFY (creation_date NOT NULL);
ALTER TABLE "Order" MODIFY (deadline_date NOT NULL);
ALTER TABLE "Order" ADD CONSTRAINT order_summary_price_not_zero CHECK (summary_price > 0);
ALTER TABLE "Order" ADD CONSTRAINT order_is_paid_boolean CHECK (is_paid = 'Y' OR is_paid = 'N');
ALTER TABLE "Order" ADD CONSTRAINT order_is_done_boolean CHECK (is_done = 'Y' OR is_done = 'N');

ALTER TABLE Sale ADD CONSTRAINT sale_pk PRIMARY KEY (id);
ALTER TABLE Sale ADD CONSTRAINT sale_order_id_fk
    FOREIGN KEY (order_id) REFERENCES "Order"(id);
ALTER TABLE Sale ADD CONSTRAINT sale_furniture_id_fk
    FOREIGN KEY (furniture_id) REFERENCES Furniture(id);
ALTER TABLE Sale ADD CONSTRAINT sale_amount_not_zero CHECK (amount > 0);