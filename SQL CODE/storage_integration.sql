CREATE OR REPLACE STORAGE INTEGRATION s3_init
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = S3
    ENABLED = TRUE
    STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::905418095022:role/snowflake-s3-connection'
    STORAGE_ALLOWED_LOCATIONS = ('s3://dw-snowflake-jay')
    COMMENT ='Creating connection to S3'

DESC INTEGRATION s3_init;

CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_S3_INIT(
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30)
);

CREATE OR REPLACE file format MANAGE_DB.file_formats.csv_fileformat
    type = csv
    field_delimiter = ','
    skip_header = 1
    null_if = ('NULL', 'null')
    empty_field_as_null = TRUE;

CREATE OR REPLACE STAGE MANAGE_DB.external_stages.csv_folder
    url = 's3://dw-snowflake-jay'
    STORAGE_INTEGRATION = s3_init
    FILE_FORMAT = MANAGE_DB.file_formats.csv_fileformat

LIST @MANAGE_DB.external_stages.csv_folder;

COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_S3_INIT
    FROM @MANAGE_DB.external_stages.csv_folder;

SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_S3_INIT;