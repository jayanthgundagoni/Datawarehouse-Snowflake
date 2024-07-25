CREATE OR REPLACE TABLE SPOTIFY_DB.PUBLIC.tblAlbum(
    album_id VARCHAR(50),
    name VARCHAR(50),
    release_date DATE,
    total_tracks INTEGER,
    url VARCHAR(255)
);

CREATE OR REPLACE TABLE SPOTIFY_DB.PUBLIC.tblArtist(
    artist_id VARCHAR(50),
    artist_name VARCHAR(50),
    external_url VARCHAR(255)
);

CREATE OR REPLACE TABLE SPOTIFY_DB.PUBLIC.tblSongs(
    song_id VARCHAR(255),
    song_name VARCHAR(50),
    duration_ms INTEGER,
    url VARCHAR(255),
    popularity INTEGER,
    song_added DATE,
    album_id VARCHAR(255),
    artist_id VARCHAR(255)
);

// Create file format
CREATE OR REPLACE FILE FORMAT MANAGE_DB.FILE_FORMATS.csv_file_format
    type = csv
    field_delimiter = ','
    skip_header = 1
    null_if = ('NULL','null')
    empty_field_as_null = TRUE;

// Creating storage integration
create or replace storage integration s3_init
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE 
  STORAGE_AWS_ROLE_ARN = '<Insert here>'
  STORAGE_ALLOWED_LOCATIONS = ('s3://spotify-etl-project-jayanth')
   COMMENT = 'Creating connection to S3' 


// Create stage object with integration object & file format object
CREATE OR REPLACE stage MANAGE_DB.external_stages.transformed_data
    URL = 's3://spotify-etl-project-jayanth/transformed_data/'
    STORAGE_INTEGRATION = s3_init
    FILE_FORMAT = MANAGE_DB.file_formats.csv_file_format

LIST @MANAGE_DB.external_stages.transformed_data

// Create a schema for pipes to keep the things organized
CREATE OR REPLACE SCHEMA SPOTIFY_DB.PIPES;


//Define Pipe for Album Table
CREATE OR REPLACE pipe SPOTIFY_DB.PIPES.ALBUM_PIPE
auto_ingest = TRUE
AS
COPY INTO SPOTIFY_DB.PUBLIC.tblAlbum
FROM @MANAGE_DB.external_stages.transformed_data/album_data/
file_format = (type = csv field_delimiter = "," skip_header=1 error_on_column_count_mismatch=false)
ON_ERROR = 'CONTINUE';

//Define Pipe for Artist Table
CREATE OR REPLACE pipe SPOTIFY_DB.PIPES.ARTIST_PIPE
auto_ingest = TRUE
AS
COPY INTO SPOTIFY_DB.PUBLIC.tblArtist
FROM @MANAGE_DB.external_stages.transformed_data/artist_data/
file_format = (type = csv field_delimiter = "," skip_header=1 error_on_column_count_mismatch=false)
ON_ERROR = 'CONTINUE';

//Define Pipe for Songs Table
CREATE OR REPLACE pipe SPOTIFY_DB.PIPES.SONGS_PIPE
auto_ingest = TRUE
AS
COPY INTO SPOTIFY_DB.PUBLIC.tblSongs
FROM @MANAGE_DB.external_stages.transformed_data/songs_data/
file_format = (type = csv field_delimiter = "," skip_header=1 error_on_column_count_mismatch=false)
ON_ERROR = 'CONTINUE';

ALTER PIPE SPOTIFY_DB.PIPES.SONGS_PIPE REFRESH;

SELECT * FROM SPOTIFY_DB.PUBLIC.tblSongs;