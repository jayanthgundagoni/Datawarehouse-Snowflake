CREATE TABLE customer (
   customer_id INT,
   customer_name VARCHAR(50),
   customer_email VARCHAR(50),
   customer_phone VARCHAR(15),
   load_date DATE,
	 customer_address VARCHAR(255)
);

INSERT INTO customer VALUES
   (1, 'John Doe', 'john.doe@example.com', '123-456-7890', '2022-01-01', '123 Main St'),
   (2, 'Jane Doe', 'jane.doe@example.com', '987-654-3210', '2022-01-01', '456 Elm St'),
   (3, 'Bob Smith', 'bob.smith@example.com', '555-555-5555', '2022-01-01', '789 Oak St');


SELECT * FROM customer;

-- Applying SCD1 
UPDATE customer SET customer_address = '795 Maple St' WHERE customer_id = 2;

-- Applying SCD2
ALTER TABLE customer ADD COLUMN customer_segment VARCHAR(20);
ALTER TABLE customer ADD COLUMN start_date DATE;
ALTER TABLE customer ADD COLUMN end_date DATE;
ALTER TABLE customer ADD COLUMN version BIGINT DEFAULT 1;

SELECT * FROM customer;

UPDATE customer SET customer_segment = 'Gold', start_date = '2022-02-01', end_date = '9999-12-31' WHERE customer_id = 2;

-- updating customer_segment from Gold to Platinum using SCD2
INSERT INTO customer
SELECT
    customer_id,
    customer_name,
    customer_email,
    customer_phone,
    load_date,
    customer_address,
    'Platinum',
    '2022-03-01',
    '9999-12-31',
    version+1
FROM customer WHERE customer_id = 2;

SELECT * FROM customer WHERE customer_id = 2;

UPDATE customer SET end_date = '2022-02-28' WHERE customer_id = 2 and version = 1;

-- SCD3

ALTER TABLE customer ADD COLUMN prev_segment VARCHAR(255);

INSERT into customer
SELECT
    customer_id,
    customer_name,
    customer_email,
    customer_phone,
    load_date,
    customer_address,
    'Silver',
    '2022-03-01',
    '9999-12-31',
    version+1,
    customer_segment
FROM customer WHERE customer_id = 2 and version = 2;