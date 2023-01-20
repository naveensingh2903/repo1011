EXEC sp_configure 'polybase enabled',1;
go  
----------------------------------------------------------------------------------------------------------
RECONFIGURE
----------------------------------------------------------------------------------------------------------
EXEC sp_configure @configname='hadoop connectivity', @configvalue=7;
GO
----------------------------------------------------------------------------------------------------------
RECONFIGURE
----------------------------------------------------------------------------------------------------------
create database polybasedemo
----------------------------------------------------------------------------------------------------------
create MASTER KEY ENCRYPTION BY PASSWORD='test@123'
use polybasedemo
go  
----------------------------------------------------------------------------------------------------------
CREATE DATABASE SCOPED CREDENTIAL [AzureStoreage_1]
WITH
IDENTITY='test_Account',
secret ='kE8a0xIkHFmG7ZL3dpxJTo/c5DVkkYBRF2W7pTYJ/VYzUtvy/D4RFw8+vv4MqGpq0Ld9luqBDJKnnz7K8qhHVA=='
----------------------------------------------------------------------------------------------------------
CREATE EXTERNAL DATA SOURCE azure_blob_store
WITH
(
    TYPE=hadoop,
    LOCATION=  'wasbs://polybase@polybasedemo01.blob.core.windows.net',
    credential=[AzureStoreage_1]
)
----------------------------------------------------------------------------------------------------------
create EXTERNAL FILE FORMAT text_file
WITH
(
    FORMAT_TYPE=delimitedtext,
    FORMAT_OPtions(FIELD_TERMINATOR=',')
)
----------------------------------------------------------------------------------------------------------
create EXTERNAL TABLE SQLExternal
(
    worker_id int,
    first_name varchar(30),
    last_name varchar(30),
    salary bigint,
    department varchar(30)
)
WITH
(
    LOCATION='/mycsvfile.txt',
    data_source=azure_blob_store,
    FILE_FORMAT=text_file
);
----------------------------------------------------------------------------------------------------------
select * from SQLExternal
