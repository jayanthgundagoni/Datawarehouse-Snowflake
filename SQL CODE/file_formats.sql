CREATE OR REPLACE SCHEMA MANAGE_DB.file_formats;

//Create File Format Object
CREATE OR REPLACE FILE FORMAT MANAGE_DB.file_formats.my_file_format;

DESC file format MANAGE_DB.file_formats.my_file_format;

ALTER FILE FORMAT MANAGE_DB.file_formats.my_file_format
SET skip_header = 1;

//Changing file format
CREATE OR REPLACE file format MANAGE_DB.file_formats.my_file_format
    TYPE = JSON,
    TIME_FORMAT = AUTO;

CREATE OR REPLACE FILE FORMAT MANAGE_DB.file_formats.csv_file_format
TYPE = CSV,
FIELD_DELIMITER = ','
SKIP_HEADER = 1;

TRUNCATE TABLE MANAGE_DB.PUBLIC.ORDERS;

COPY INTO MANAGE_DB.PUBLIC.ORDERS
    FROM @MANAGE_DB.external_stages.aws_stage
    file_format = (FORMAT_NAME = MANAGE_DB.file_formats.csv_file_format)
    files = ('OrderDetails.csv');

SELECT * FROM MANAGE_DB.PUBLIC.ORDERS;
