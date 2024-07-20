//setting up table

CREATE OR REPLACE STAGE MANAGE_DB.EXTERNAL_STAGES.time_travel_stage
    URL = 's3://data-snowflake-fundamentals/time-travel/'
    file_format = MANAGE_DB.file_formats.csv_file;

CREATE OR REPLACE TABLE OUR_FIRST_DB.public.customers (
    id INT,
    first_name STRING,
    last_name STRING,
    email STRING,
    gender STRING,
    Job STRING,
    Phone STRING
);

COPY INTO OUR_FIRST_DB.public.customers
FROM @MANAGE_DB.EXTERNAL_STAGES.time_travel_stage
files = ('customers.csv');

SELECT * FROM OUR_FIRST_DB.public.customers;

DROP TABLE OUR_FIRST_DB.public.customers;

UNDROP TABLE OUR_FIRST_DB.public.customers;

//Undrop Commands

DROP SCHEMA OUR_FIRST_DB.public;

SELECT * FROM OUR_FIRST_DB.public.customers;

UNDROP SCHEMA OUR_FIRST_DB.public;

DROP DATABASE OUR_FIRST_DB;

UNDROP DATABASE OUR_FIRST_DB;