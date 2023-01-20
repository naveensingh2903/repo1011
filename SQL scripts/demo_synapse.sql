--------------------------------------------------------------------------------------------------------------
--## What does Master key do ?
--## It gives the ability to encrpyt the credentials that will be stored later.

create master key ENCRYPTION by password='Datasturdy123#'
GO
--------------------------------------------------------------------------------------------------------------
drop master key
--------------------------------------------------------------------------------------------------------------
--## What is database scoped credentials ?
--## The credential is used by the database to access to the external location anytime the 
--## database is performing an operation that requires access.
--## You can give any name want. Just enter the key cautiously. Key is the Primary key of your Blob storage
--## This is my blob storage key you have to enter you blob storage key


CREATE DATABASE SCOPED CREDENTIAL [AzureStorage_1]
WITH
IDENTITY='test_Account',
secret ='MCIf92B6kH+z5RP9s9EreWSmjjrxznu9V2tNHLY8YYUoYxHUONDhj3x6a0nKaeQzhlr8u+Pdijiq062oCk0yRw=='
--------------------------------------------------------------------------------------------------------------
drop database scoped credential AzureStorage_1
--------------------------------------------------------------------------------------------------------------
--## Now its time to create external data source.
--## Where is data source ?
--## Here we define the data source like where our data is stored, like in my case I have stored the data in
--## Azure blob storage(Blob storage name= 'polybasedemo01', container name= 'polybase')
--## In location 

CREATE EXTERNAL DATA SOURCE AzureStorage_demo with (  
      TYPE = HADOOP,
      LOCATION ='abfss://ziploan@ziploan.dfs.core.windows.net',  
      CREDENTIAL = AzureStorage_1
);
--------------------------------------------------------------------------------------------------------------
drop external data source AzureStorage_demo
--------------------------------------------------------------------------------------------------------------
--## Now we have define file format.
--## What is the file type?
--## Here we define in file type according to the format in which the data is stored in source location. 
--## Is it stored in csv, txt, zip, parquet format ?
--## I have gave file format name 'text_file' and field terminated by ',' for csv file

CREATE EXTERNAL FILE FORMAT skipHeader_CSV
WITH (FORMAT_TYPE = DELIMITEDTEXT,
      FORMAT_OPTIONS(
          FIELD_TERMINATOR = ',',
          --STRING_DELIMITER = '"',
          FIRST_ROW = 2, 
          USE_TYPE_DEFAULT = True)
)

--drop external file FORMAT skipHeader_CSV

--------------------------------------------------------------------------------------------------------------
--## How to connect to source data?
--## Till now we have defined 'data source', 'file type' now its time to create an external table
--## that will connect to 'data source' and its defined 'file type'.
--## External table- It is the representation of the data that is resourced outside the sql server engine.
--## External table schema should be defined according to the data.
--## ..............
--## In this we have to give :
--## 'data_source' means which location we are going to ping for the data.
--## 'file_format' means which file format data this table will support for the defined schema.

create external table ext_revised 
(
    time_ref VARCHAR(100),
    account varchar(100),
    code VARCHAR(100),
    country_code VARCHAR(100),
    product_type VARCHAR(100),
    value float,
    [status] VARCHAR(100)
)
with 
(
      DATA_SOURCE = AzureStorage_demo,                                         
	  LOCATION='/csv_files/revised.csv',		
      FILE_FORMAT = skipHeader_CSV 									
)

--drop external table ext_revised
--------------------------------------------------------------------------------------------------------------
--## Now it's time to query the table

select top 10 * from ext_revised

--------------------------------------------------------------------------------------------------------------
--## Till now all the data is in Blob Storage, we are working virtually with Blob data 
--## through 'SQLExternal' table.
--## To Move the data to our instance, we will create another table(not an external one) 
--## and load the load into it, from Blob Storage.
--## new table name- internal_table
--## source table- SQLExternal

select * into DW_revised
from ext_revised
--------------------------------------------------------------------------------------------------------------
drop table DW_revised

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
--------------------------------------------------------------------------------------------------------------
copy into clickstream.sessionstyledaily_2021_08_08__csv_2000
from 'https://myntrabi01.blob.core.windows.net/adw-commerce/test/commerce_tables/clickstream/sessionstyledaily/csv_zip/QID286368250_20210901_24633_0.txt.gz'
 WITH
 (
  FILE_TYPE = 'CSV',
   CREDENTIAL = (IDENTITY='Shared Access Signature',SECRET='sp=racwdl&st=2021-09-06T06:15:12Z&se=2021-10-01T14:15:12Z&sv=2020-08-04&sr=c&sig=8uzj2t7eh8M2iMTpEBjW3LD%2BuZmoKfgppIoMmv0Fu4s%3D'),
     FIELDQUOTE = '"',
    FIELDTERMINATOR=','
 );
--------------------------------------------------------------------------------------------------------------
CREATE EXTERNAL FILE FORMAT skipHeader_CSV_1
WITH (FORMAT_TYPE = DELIMITEDTEXT,
      FORMAT_OPTIONS(
          FIELD_TERMINATOR = ',',
          STRING_DELIMITER = '"',
          FIRST_ROW = 2, 
          USE_TYPE_DEFAULT = True)
)

select * from sys.external_file_formats
--------------------------------------------------------------------------------------------------------------
--Create an external file format for PARQUET files.  
CREATE EXTERNAL FILE FORMAT parquet_snappy  
WITH (  
         FORMAT_TYPE = PARQUET  
         , DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'    
    );

drop external file format parquet_snappy
--------------------------------------------------------------------------------------------------------------
CREATE EXTERNAL FILE FORMAT parquet_gzip  
WITH (  
         FORMAT_TYPE = PARQUET  
         , DATA_COMPRESSION = 'org.apache.hadoop.io.compress.GzipCodec'    
    );

drop external file format parquet_gzip
--------------------------------------------------------------------------------------------------------------
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
    speed8 float
)
WITH
(
    LOCATION='/parquet_files/station=402260/part-r-00000-ddaee723-f3f6-4f25-a34b-3312172aa6d7.snappy.parquet',
    DATA_SOURCE=AzureStorage_demo,
    FILE_FORMAT=parquet_snappy
)
--------------------------------------------------------------------------------------------------------------
select top 10 * from ext_station
drop external table ext_station
--------------------------------------------------------------------------------------------------------------
copy into copy_table_parquet
from 'https://ziploan.blob.core.windows.net/ziploan/parquet_files/station=402260/part-r-00000-ddaee723-f3f6-4f25-a34b-3312172aa6d7.snappy.parquet'
 WITH
 (
  FILE_TYPE = 'PARQUET',
   CREDENTIAL = (IDENTITY='Shared Access Signature',SECRET='sp=r&st=2021-10-31T03:26:00Z&se=2021-12-31T11:26:00Z&sv=2020-08-04&sr=c&sig=EBiRIZ1WRyCPLQDxoHwJ71kSGOzy4Ak%2BfVQhz23%2FSZM%3D')
 );
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
copy into copy_table_csv
from 'https://myntrabi01.blob.core.windows.net/adw-commerce/test/commerce_tables/clickstream/sessionstyledaily/csv_zip/QID286368250_20210901_24633_0.txt.gz'
 WITH
 (
  FILE_TYPE = 'CSV',
   CREDENTIAL = (IDENTITY='Shared Access Signature',SECRET='sp=r&st=2021-10-31T03:26:00Z&se=2021-12-31T11:26:00Z&sv=2020-08-04&sr=c&sig=EBiRIZ1WRyCPLQDxoHwJ71kSGOzy4Ak%2BfVQhz23%2FSZM%3D'),
     FIELDQUOTE = '"',
    FIELDTERMINATOR=','
 );
 --------------------------------------------------------------------------------------------------------------
 