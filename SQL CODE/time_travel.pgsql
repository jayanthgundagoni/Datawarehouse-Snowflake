CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.test(
    id INT,
    first_name STRING,
    last_name STRING,
    email STRING,
    gender STRING,
    Job STRING,
    Phone STRING
);

CREATE OR REPLACE file format MANAGE_DB.file_formats.csv_file
    type = csv
    field_delimiter = ','
    skip_header = 1;

CREATE OR REPLACE STAGE MANAGE_DB.external_stages.time_travel_stage
    URl = 's3://data-snowflake-fundamentals/time-travel/'
    file_format = MANAGE_DB.file_formats.csv_file

LIST @MANAGE_DB.external_stages.time_travel_stage;

COPY INTO OUR_FIRST_DB.PUBLIC.test
FROM @MANAGE_DB.external_stages.time_travel_stage
files = ('customers.csv')

SELECT * FROM OUR_FIRST_DB.PUBLIC.test;

// USE CASE: Update data (by mistake)

UPDATE OUR_FIRST_DB.PUBLIC.test
SET FIRST_NAME = 'Joyen';

// Using time travel method 1-2 minutes back

SELECT * FROM OUR_FIRST_DB.public.test at (OFFSET => -60*2)

TRUNCATE TABLE OUR_FIRST_DB.PUBLIC.test;

COPY INTO OUR_FIRST_DB.PUBLIC.test
FROM @MANAGE_DB.external_stages.time_travel_stage
files = ('customers.csv')

ALTER SESSION SET TIMEZONE = 'UTC';
SELECT DATEADD(DAY, 1, CURRENT_TIMESTAMP);

//2024-07-21 22:31:22.617 +0000

UPDATE OUR_FIRST_DB.public.test
SET Job = 'Data Scientist';

SELECT * FROM OUR_FIRST_DB.public.test before (timestamp => '2024-07-20 22:33:22.617'::timestamp)

TRUNCATE TABLE OUR_FIRST_DB.PUBLIC.test;

// ALTERING TABLE (by mistake)
UPDATE OUR_FIRST_DB.PUBLIC.test
SET email = null;

//01b5cdcf-0001-f103-0006-1fc60001ce72
SELECT * FROM OUR_FIRST_DB.public.test before (statement => '01b5cdcf-0001-f103-0006-1fc60001ce72')

