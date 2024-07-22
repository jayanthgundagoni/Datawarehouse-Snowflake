CREATE OR REPLACE DATABASE DATA_S;

CREATE OR REPLACE STAGE aws_stage
    url = 's3://bucketsnowflakes3';

//List files in stage
LIST @aws_stage;

//Create table
CREATE OR REPLACE TABLE ORDERS (
    ORDER_ID VARCHAR(30),
    AMOUNT INTEGER,
    PROFIT INTEGER,
    QUANTITY INTEGER,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30)
);

// Load data using copy command
COPY INTO ORDERS
    FROM @MANAGE_DB.external_stages.aws_stage
    file_format = (type = csv field_delimiter =',' skip_header=1)
    pattern = '.*OrderDetails.*';

CREATE OR REPLACE SHARE ORDERS_SHARE;

---- SETUP GRANTS ---

//Grant usage on database
GRANT USAGE ON DATABASE DATA_S TO SHARE ORDERS_SHARE;

//Grant usage on schema
GRANT USAGE ON SCHEMA DATA_S.PUBLIC TO SHARE ORDERS_SHARE;

//Grant SELECT on table
GRANT SELECT ON TABLE DATA_S.PUBLIC.ORDERS TO SHARE ORDERS_SHARE;

//Validate
SHOW GRANTS TO SHARE ORDERS_SHARE;

--Create Reader Account--

CREATE MANAGED ACCOUNT tech_jay_account
ADMIN_NAME = tech_jay_admin,
ADMIN_PASSWORD = 'Jayanth12345'
TYPE = READER;

ALTER SHARE ORDERS_SHARE
ADD ACCOUNT = WC67323;



