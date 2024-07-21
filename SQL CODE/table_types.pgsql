CREATE OR REPLACE DATABASE PDB;

CREATE OR REPLACE TABLE PDB.public.customers (
   id int,
   first_name string,
  last_name string,
  email string,
  gender string,
  Job string,
  Phone string);
  
CREATE OR REPLACE TABLE PDB.public.helper (
   id int,
   first_name string,
  last_name string,
  email string,
  gender string,
  Job string,
  Phone string);
    
// Stage and file format
CREATE OR REPLACE FILE FORMAT MANAGE_DB.file_formats.csv_file
    type = csv
    field_delimiter = ','
    skip_header = 1;
    
CREATE OR REPLACE STAGE MANAGE_DB.external_stages.time_travel_stage
    URL = 's3://data-snowflake-fundamentals/time-travel/'
    file_format = MANAGE_DB.file_formats.csv_file;
    
LIST  @MANAGE_DB.external_stages.time_travel_stage;

// Copy data and insert in table
COPY INTO PDB.public.helper
FROM @MANAGE_DB.external_stages.time_travel_stage
files = ('customers.csv');


CREATE OR REPLACE DATABASE TDB;

CREATE OR REPLACE TRANSIENT TABLE TDB.public.customers_transient(
   id int,
   first_name string,
  last_name string,
  email string,
  gender string,
  Job string,
  Phone string);

INSERT INTO TDB.public.customers_transient
SELECT t1.* FROM OUR_FIRST_DB.public.customers t1
CROSS JOIN (SELECT * FROM OUR_FIRST_DB.public.customers) t2

SHOW TABLES;
)

SELECT * FROM PDB.public.helper;

// Show table and validate
SHOW TABLES;

DROP TABLE TDB.public.customers_transient;


UNDROP TABLE TDB.public.customers_transient;

SHOW TABLES;

CREATE OR REPLACE TRANSIENT SCHEMA TRANSIENT_SCHEMA;

SHOW SCHEMAS;

CREATE OR REPLACE TABLE TDB.public.customers_transient_1(
   id int,
   first_name string,
  last_name string,
  email string,
  gender string,
  Job string,
  Phone string);

  SHOW TABLES;

  CREATE OR REPLACE TABLE PDB.public.customers(
   id int,
   first_name string,
  last_name string,
  email string,
  gender string,
  Job string,
  Phone string);

INSERT INTO pdb.public.customers
SELECT t1.* FROM OUR_FIRST_DB.public.customers t1

CREATE OR REPLACE TEMPORARY TABLE PDB.public.temp_table(
   id int,
   first_name string,
  last_name string,
  email string,
  gender string,
  Job string,
  Phone string);

INSERT INTO PDB.public.temp_table
SELECT * FROM PDB.public.customers;

SELECT * FROM PDB.public.temp_table;