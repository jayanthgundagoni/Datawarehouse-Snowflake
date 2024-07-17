// Database to manage stage objects, file formats, etc.

CREATE OR REPLACE DATABASE MANAGE_DB;

CREATE OR REPLACE SCHEMA external_stages;

// Creating External stage
CREATE OR REPLACE STAGE MANAGE_DB.external_stages.aws_stage
    url = "s3://dw-snowflake-jay/instacart/"
    credentials = (aws_key_id = '<>' aws_secret_key = '<>');

// Description of external stage
DESC STAGE MANAGE_DB.external_stages.aws_stage;

// To see the details of the stage
LIST @aws_stage;

CREATE OR REPLACE TABLE MANAGE_DB.PUBLIC.ORDERS(
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));

SELECT * FROM MANAGE_DB.PUBLIC.ORDERS;

CREATE OR REPLACE STAGE MANAGE_DB.external_stages.aws_stage
    url='s3://bucketsnowflakes3';

LIST @aws_stage;

COPY INTO MANAGE_DB.PUBLIC.ORDERS
FROM @aws_stage
file_format = (type = csv field_delimiter = ',', skip_header=1)
files=('OrderDetails.csv')

CREATE OR REPLACE TABLE MANAGE_DB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT
);

COPY INTO MANAGE_DB.PUBLIC.ORDERS_EX
FROM (SELECT s.$1, s.$2 FROM @MANAGE_DB.external_stages.aws_stage s)
file_format=(type=csv field_delimiter=',' skip_header=1)
files=('OrderDetails.csv');

SELECT * FROM MANAGE_DB.PUBLIC.ORDERS_EX;

CREATE OR REPLACE TABLE MANAGE_DB.PUBLIC.ORDERS_EX1(
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    CATEGORY_SUBSTRING VARCHAR(255)
);

COPY INTO MANAGE_DB.PUBLIC.ORDERS_EX1
FROM (SELECT
        s.$1,
        s.$2,
        s.$3,
        CASE WHEN CAST(s.$3 as int) < 0 THEN 'not profitable' ELSE 'profitable' END
        from @MANAGE_DB.external_stages.aws_stage s)
file_format = (type=csv field_delimiter=',' skip_header=1)
files=('OrderDetails.csv');

SELECT * FROM MANAGE_DB.PUBLIC.ORDERS_EX1;