--## What is PolyBase ?
--## PolyBase enables your SQL server instance to query data with T-SQL directly from SQL server, Oracle,
--## MongoDB, Teradata, Hadoop cluster, Cosmos DB without separately installing client connection software.
--## PolyBase allows T-SQL queries to join data from external source to relational table in an instance in
--## SQL server.
--------------------------------------------------------------------------------------------------------------
--## What is data virtualisation in PolyBase ?
--## PolyBase allow the data to be in original source place and it can be queried through T-SQL commands
--## as it resides in SQL server instance. Here we are making vitual External table. Then using that virtual
--## table to query data through normal T-SQL command.
--------------------------------------------------------------------------------------------------------------
--## After installation PolyBase must be enabled to access its features.

exec sp_configure @configname = 'polybase enabled', @configvalue = 1;
RECONFIGURE;

--------------------------------------------------------------------------------------------------------------
--## To confirm installation is done run the T-SQL command. It will return 1 if installation is done else 0.

SELECT SERVERPROPERTY ('IsPolyBaseInstalled') AS IsPolyBaseInstalled;

--------------------------------------------------------------------------------------------------------------
--## Now we have to configure its connectivity. Here we are connecting through 'hadoop connectivity' because
--## Azure Bolb storage is built on top of Hadoop.

EXEC sp_configure @configname='hadoop connectivity', @configvalue=7;
GO
--------------------------------------------------------------------------------------------------------------

--## To start from scratch make a new database 'polybasedemo01'
create database polybasedemo01;

use polybasedemo01

--------------------------------------------------------------------------------------------------------------
--## What does Master key do ?
--## It gives the ability to encrpyt the credentials that will be stored later.

create master key ENCRYPTION by password='test@123'
use polybasedemo01
GO

--------------------------------------------------------------------------------------------------------------
--## What is database scoped credentials ?
--## The credential is used by the database to access to the external location anytime the 
--## database is performing an operation that requires access.
--## You can give any name want. Just enter the key cautiously. Key is the Primary key of your Blob storage
--## This is my blob storage key you have to enter you blob storage key


CREATE DATABASE SCOPED CREDENTIAL [AzureStoreage_1]
WITH
IDENTITY='test_Account',
secret ='kE8a0xIkHFmG7ZL3dpxJTo/c5DVkkYBRF2W7pTYJ/VYzUtvy/D4RFw8+vv4MqGpq0Ld9luqBDJKnnz7K8qhHVA=='

--------------------------------------------------------------------------------------------------------------
--## Now its time to create external data source.
--## Where is data source ?
--## Here we define the data source like where our data is stored, like in my case I have stored the data in
--## Azure blob storage(Blob storage name= 'polybasedemo01', container name= 'polybase')
--## In location 
CREATE EXTERNAL DATA SOURCE azure_blob_store
WITH
(
    TYPE=hadoop,
    LOCATION=  'wasbs://polybase@polybasedemo01.blob.core.windows.net',
    credential=[AzureStoreage_1]
)

--------------------------------------------------------------------------------------------------------------
--## Now we have define file format.
--## What is the file type?
--## Here we define in file type according to the format in which the data is stored in source location. 
--## Is it stored in csv, txt, zip, parquet format ?
--## I have gave file format name 'text_file' and field terminated by ',' for csv file

create EXTERNAL FILE FORMAT text_file
WITH
(
    FORMAT_TYPE=delimitedtext,
    FORMAT_OPtions(FIELD_TERMINATOR=',')
)

--------------------------------------------------------------------------------------------------------------
--## How to connect to source data?
--## Till now we have defined 'data source', 'file type' now its time to create an external table
--## that will connect to 'data source' and its defined 'file type'.
--## External table- It is the representation of the data that is resourced outside the sql 
--## server engine. Outside could be Azure blob storage, Data lake, HDInsight etc.
--## External table schema should be defined according to the data.
--## My data looks like this:
--## 001,'Monika','Arora',100000,'HR'
--## 002,'Niharika','Verma',80000,'Admin'
--## ..............
--## In this we have to give :
--## 'data_source' means which location we are going to ping for the data.
--## 'file_format' means which file format data this table will support for the defined schema.

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

--------------------------------------------------------------------------------------------------------------
--## Now it's time to query the table

select * from SQLExternal

--------------------------------------------------------------------------------------------------------------
--## Till now all the data is in Blob Storage, we are working virtually with Blob data 
--## through 'SQLExternal' table.
--## To Move the data to our instance, we will create another table(not an external one) 
--## and load the load into it, from Blob Storage.
--## new table name- internal_table
--## source table- SQLExternal

select * into internal_table
from SQLExternal

--------------------------------------------------------------------------------------------------------------
--## Verify it by query the data
--## On the left panel you can see two tables one table has 'external' written 
--## explicitly other one is normal table. 
select * from internal_table

--------------------------------------------------------------------------------------------------------------

CREATE EXTERNAL TABLE PopulationCETAS1 WITH (
        LOCATION = '/Test/',
        DATA_SOURCE = [azure_blob_store],
        FILE_FORMAT = [text_file]
) AS
SELECT top(100)
    *
FROM
  ext.fact_Order
