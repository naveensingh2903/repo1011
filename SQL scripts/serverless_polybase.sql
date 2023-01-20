CREATE MASTER KEY ENCRYPTION BY PASSWORD='Datasturdy123#';
--------------------------------------------------------------------------------------
CREATE DATABASE SCOPED CREDENTIAL [cred_powerbi]
WITH IDENTITY='SHARED ACCESS SIGNATURE',
SECRET='?sv=2020-08-04&ss=bfqt&srt=sco&sp=rwdlacupx&se=2021-12-31T13:32:42Z&st=2021-10-31T05:32:42Z&spr=https,http&sig=fTSFNU02XHQBH%2FZgngYyp5chvku%2BR6ZPcqQRX1qFuQU%3D';
--------------------------------------------------------------------------------------
CREATE EXTERNAL DATA SOURCE powerbi
WITH 
(   
    LOCATION='https://adlspowerbipoc.dfs.core.windows.net/powerbi/',
    CREDENTIAL= [cred_powerbi]
)
--------------------------------------------------------------------------------------
CREATE EXTERNAL FILE FORMAT parquet_snappy
WITH
(  
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
)
--------------------------------------------------------------------------------------
CREATE EXTERNAL FILE FORMAT csv_file
WITH
(
    FORMAT_TYPE=DELIMITEDTEXT,
    FORMAT_OPTIONS
    (
        FIELD_TERMINATOR=',',
        USE_TYPE_DEFAULT=TRUE,
        STRING_DELIMITER='"',
        ENCODING='UTF8'
    )
)
--------------------------------------------------------------------------------------
CREATE EXTERNAL FILE FORMAT csv_file_second_line
WITH
(
    FORMAT_TYPE=DELIMITEDTEXT,
    FORMAT_OPTIONS
    (
        FIELD_TERMINATOR=',',
        USE_TYPE_DEFAULT=TRUE,
        FIRSTROW=2,
        STRING_DELIMITER='"',
        ENCODING='UTF8'
    )
)
--------------------------------------------------------------------------------------
create external table ext_station
(
    timeperiod VARCHAR(100),
    flow1 int,
    occupancy1 float,
    speed1 float,
    flow2 int,
    occupancy2 float,
    speed2 float,
    flow3 int,
    occupancy3 float,
    speed3 float,
    flow4 int,
    occupancy4 float,
    speed4 float,
    flow5 int,
    occupancy5 float,
    speed5 float,
    flow6 int,
    occupancy6 float,
    speed6 float,
    flow7 int,
    occupancy7 float,
    speed7 float,
    flow8 int,
    occupancy8 float,
    speed8 float,
)
WITH
(
    LOCATION='/parquet_files/station=402260/part-r-00000-ddaee723-f3f6-4f25-a34b-3312172aa6d7.snappy.parquet',
    DATA_SOURCE=powerbi,
    FILE_FORMAT=parquet_snappy
)

drop external table ext_station
select top 10 * from ext_station
drop external table ext_revised
--------------------------------------------------------------------------------------
create external table ext_csv
(
    time_ref VARCHAR(20),
    account varchar(20),
    code VARCHAR(20),
    country_code VARCHAR(20),
    product_type VARCHAR(20),
    value float,
    [status] VARCHAR(20)
)
WITH
(
    LOCATION='/csv_files/revised.csv',
    DATA_SOURCE=powerbi,
    FILE_FORMAT=csv_file_second_line
)
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
select * from sys.dm_external_data_processed

select [type],[data_processed_mb],cast(5*[data_processed_mb]/(1024*1024) as DECIMAL(12,2)) as approximate_cost
from sys.dm_external_data_processed
--------------------------------------------------------------------------------------

