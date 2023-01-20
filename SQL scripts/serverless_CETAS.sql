USE demo_serverless
--------------------------------------------------------------------------------------
--for parquet
create external table ext_demo_parquet
with
(
    LOCATION='/ext_par/',
    DATA_SOURCE=powerbi,
    FILE_FORMAT=parquet_snappy
) as
SELECT  * FROM
OPENROWSET
(
    BULK 'https://adlspowerbipoc.dfs.core.windows.net/powerbi/parquet_files/station=402260/part-r-00000-ddaee723-f3f6-4f25-a34b-3312172aa6d7.snappy.parquet',
    FORMAT = 'PARQUET'
) as results
--------------------------------------------------------------------------------------
select top 10  * from ext_demo_parquet
--------------------------------------------------------------------------------------
--for csv
create external table ext_demo_csv
with
(
    LOCATION='/ext_csv_1/',
    DATA_SOURCE=powerbi,
    FILE_FORMAT=parquet_snappy
) as
SELECT  * FROM
OPENROWSET
(   BULK 'https://adlspowerbipoc.dfs.core.windows.net/powerbi/csv_files/revised.csv',
    FORMAT = 'CSV',
    PARSER_VERSION = '2.0',
    FIRSTROW=2
) 
WITH
(
time_ref VARCHAR(20),
account varchar(20),
code VARCHAR(20),
country_code VARCHAR(20),
product_type VARCHAR(20),
value FLOAT,
[status] VARCHAR(20)
) as results

--------------------------------------------------------------------------------------
drop external table ext_demo_csv
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
select top 10 * from ext_csv
--------------------------------------------------------------------------------------



