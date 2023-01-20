select * from INFORMATION_SCHEMA.TABLES
where TABLE_SCHEMA='clickstream'
-----------------------------------------------------------------------------------------------------------------
--CREATE A DIFFERENT SCHEMA FOR INGESTION PURPOSE NAMED 'CLICKSTREAM'
create SCHEMA clickstream
-----------------------------------------------------------------------------------------------------------------
--CREATE AN EXTERNAL TABLE 
CREATE external TABLE clickstream.sessionstyledaily_2021_08_08
(
	[load_date] [varchar](100) NULL,
	[uidx] [varchar](100) NULL,
	[session_id] [varchar](100) NULL,
	[device_id] [varchar](100) NULL,
	[os] [varchar](100) NULL,
	[app_version] [varchar](100) NULL,
	[device_manufacturer] [varchar](100) NULL,
	[city] [varchar](100) NULL,
	[state] [varchar](100) NULL,
	[country] [varchar](100) NULL,
	[app_name] [varchar](100) NULL,
	[device_category] [varchar](100) NULL,
	[style_id] [varchar](100) NULL,
	[brand] [varchar](100) NULL,
	[article_type] [varchar](100) NULL,
	[gender] [varchar](100) NULL,
	[business_unit] [varchar](100) NULL,
	[master_category] [varchar](100) NULL,
	[current_commercial_type] [varchar](100) NULL,
	[supply_type] [varchar](100) NULL,
	[brand_type] [varchar](100) NULL,
	[addtocart] [bigint] NULL,
	[listcount] [bigint] NULL,
	[addtolist] [bigint] NULL,
	[pdpviews] [bigint] NULL,
	[pdpviewsdistinct] [varchar](100) NULL,
	[shares] [bigint] NULL,
	[similarstyleclicks] [bigint] NULL,
	[addtocollection] [bigint] NULL,
	[sizechartclick] [bigint] NULL,
	[productinfoclick] [bigint] NULL,
	[pdplikes] [bigint] NULL,
	[brokensizebuttonclicked] [bigint] NULL,
	[brokensizeclick] [bigint] NULL,
	[checkdelivery] [bigint] NULL,
	[clickforoffer] [bigint] NULL,
	[crosslink] [bigint] NULL,
	[crosslinkclick] [bigint] NULL,
	[follow] [bigint] NULL,
	[imageswipe] [varchar](100) NULL,
	[imagezoom] [bigint] NULL,
	[infoclick] [bigint] NULL,
	[moreprofiles] [bigint] NULL,
	[pdpunlike] [bigint] NULL,
	[profileclick] [bigint] NULL,
	[profilevisitclick] [bigint] NULL,
	[recommendedsize] [varchar](100) NULL,
	[sizerecoinfo] [varchar](100) NULL,
	[unfollow] [bigint] NULL,
	[similarproductsloadedbrokensizes] [bigint] NULL,
	[similarproductsclickedbrokensizes] [bigint] NULL,
	[similarproductsbuttonbrokensizes] [bigint] NULL,
	[similarproductsloadedlist] [bigint] NULL,
	[similarproductsbuttonclicklist] [bigint] NULL,
	[similarproductsclicklist] [bigint] NULL,
	[similarproductsclickeddialogbox] [bigint] NULL,
	[similarproductsclickedreco] [bigint] NULL,
	[similarproductsbuttonclickpdpicon] [bigint] NULL,
	[similarproductsloadedpdpicon] [bigint] NULL,
	[similarproductsclickedpdpicon] [bigint] NULL,
	[gaid] [varchar](400) NULL,
	[react_bundle_version] [varchar](400) NULL,
	[move_to_cart] [bigint] NULL,
	[add_to_wishlist_pdp] [bigint] NULL,
	[add_to_collection_pdp] [bigint] NULL,
	[remove_from_wishlist] [bigint] NULL,
	[remove_from_collection] [bigint] NULL,
	[checkdelivery_click] [bigint] NULL,
	[imageswipe_count] [bigint] NULL,
	[recommendedsize_count] [bigint] NULL,
	[sizerecoinfo_count] [bigint] NULL,
	[size_select] [bigint] NULL,
	[recommend_product_click] [bigint] NULL,
	[saha_click] [bigint] NULL,
	[color_switch] [bigint] NULL,
	[look_widget_click] [bigint] NULL,
	[video_card_click] [bigint] NULL,
	[video_play] [bigint] NULL,
	[youcam_click] [bigint] NULL,
	[share_click] [bigint] NULL,
	[cart_click] [bigint] NULL,
	[wishlist_click] [bigint] NULL,
	[similar_products_clicked] [bigint] NULL,
	[similar_products_loaded] [bigint] NULL,
	[similar_products_button_clicked] [bigint] NULL,
	[store_order_id] [varchar](400) NULL,
	[discounted_price] [numeric](12, 2) NULL,
	[mrp] [numeric](12, 2) NULL,
	[listviews] [bigint] NULL
)
WITH
(
	LOCATION='/test/commerce_tables/clickstream/sessionstyledaily/20210808/QID280665928_20210824_45516_0.parq.gz',		--NOTE: LOCATION DOES NOT INCLUDE CONTAINER NAME
      DATA_SOURCE = AzureStorage_mynt,                                           --NOTE: DATA SOURCE SHOULD BE CREATED VERY CAUTIOUSLY(IF IT'S NOT THERE CREATE ONE)
      FILE_FORMAT = Parquet_file_format 										 --NOTE: USE THE CORRECT FILE FORMAT(IF IT'S NOT THERE CREATE ONE)
)
-----------------------------------------------------------------------------------------------------------------
select top 10 * from clickstream.sessionstyledaily_2021_08_08					 --NOTE: THIS WILL MAP TO BLOB TO FETCH THE DATA(VIRTUALISATION OF TABLE)
-----------------------------------------------------------------------------------------------------------------
drop table clickstream.sessionstyledaily_2021_08_08
-----------------------------------------------------------------------------------------------------------------
--COPY COMMAND SYNTAX
COPY INTO clickstream.sessionstyledaily_2021_08_08								--NOTE: DEFINE THE SCHEMA OF THE TABLE BEFORE THIS STEP
FROM 'https://myntrabi01.blob.core.windows.net/adw-commerce/test/commerce_tables/clickstream/sessionstyledaily/20210808/QID280665928_20210824_45516_0.parq.gz'
WITH  
 ( FILE_TYPE = 'PARQUET',														--NOTE: THIS IS THE TYPE OF FILE WHICH COPY COMMAND WILL POINT
 CREDENTIAL = (IDENTITY='Shared Access Signature',SECRET='sp=racwdl&st=2021-08-25T07:47:06Z&se=2021-08-31T15:47:06Z&sv=2020-08-04&sr=c&sig=P8qq2%2FLKjUFmWmS1CpjgR8WBsK5bgiMxvlt%2FEW2VR5Q%3D')  
)
-----------------------------------------------------------------------------------------------------------------
--Create an external file format for PARQUET files.  
CREATE EXTERNAL FILE FORMAT Parquet_file_format  
WITH (  
        FORMAT_TYPE = PARQUET,
        DATA_COMPRESSION = 'org.apache.hadoop.io.compress.GzipCodec'  
    );
-----------------------------------------------------------------------------------------------------------------
COPY INTO test.demo_load
FROM 'https://datalakefordfframework.blob.core.windows.net/sourcefile/HR.student.txt'
WITH  
 ( FILE_TYPE = 'CSV',
 CREDENTIAL = (IDENTITY='Shared Access Signature',SECRET='sp=rl&st=2021-08-24T17:48:48Z&se=2021-08-25T01:48:48Z&sv=2020-08-04&sr=c&sig=B7c8XwLoZsw%2BGxW1jipXmVElnRbv9%2BmBbTaRmMUGjD4%3D'), 
 FIELDTERMINATOR=','
)
-----------------------------------------------------------------------------------------------------------------
copy into test.demo_load
from 'https://datalakefordfframework.blob.core.windows.net/sourcefile/HR.student.csv'
 WITH
 (
  FILE_TYPE = 'CSV',
   CREDENTIAL = (IDENTITY='Shared Access Signature',SECRET='sp=rl&st=2021-08-26T03:47:16Z&se=2021-08-31T11:47:16Z&sv=2020-08-04&sr=c&sig=%2FCoKU1N9LWkLWZAOBUf%2Bt1scvkVQvToPXSLNOCNJ8TM%3D'),
  FIELDTERMINATOR = ',',
  FIELDQUOTE = '',
  ROWTERMINATOR='0X0A',
  COMPRESSION = 'GZIP'
 );
 --Result: all the CSV loads give the same error "maxerrors"
-----------------------------------------------------------------------------------------------------------------
-- IDENTITY: any string (this is not used for authentication to Azure storage).  
-- SECRET: your Azure storage account key.  
CREATE DATABASE SCOPED CREDENTIAL AzureStorageCredential_mynt
WITH IDENTITY = 'user', 
Secret = 'TylgfnsatUx7c7sOsEdn0vtJ1JE9+ordoMbv++sbjCCHKkUygu6RZvNngr4unz+FbhoCicUJQY06WIIQku4uCw==';
-----------------------------------------------------------------------------------------------------------------
CREATE EXTERNAL DATA SOURCE AzureStorage_mynt with (  
      TYPE = HADOOP,
      LOCATION ='wasbs://adw-commerce@myntrabi01.blob.core.windows.net',  
      CREDENTIAL = AzureStorageCredential_mynt
);
drop external data source AzureStorage_mynt
-----------------------------------------------------------------------------------------------------------------
CREATE EXTERNAL FILE FORMAT skipHeader_CSV
WITH (FORMAT_TYPE = DELIMITEDTEXT,
      FORMAT_OPTIONS(
          FIELD_TERMINATOR = ',',
          STRING_DELIMITER = '"',
          FIRST_ROW = 2, 
          USE_TYPE_DEFAULT = True)
)
-----------------------------------------------------------------------------------------------------------------
select top 10 * from clickstream.daily_style_session_demo
-----------------------------------------------------------------------------------------------------------------
--COPYING SCHEMA OF ONE TABLE FROM ANOTHER TABLE(PUT WHERE 1=2, SO WILL NOT GET ANY ROWS IN NEW TABLE)
select * into clickstream.sessionstyledaily_2021_08_08__with_2000_2_DWu
from clickstream.sessionstyledaily_2021_08_08__with_1500DWu
where 1=2
-----------------------------------------------------------------------------------------------------------------
--CTAS loading data from external table 
create table clickstream.demo_load_copy_1
WITH(
      DISTRIBUTION=ROUND_ROBIN,
      CLUSTERED COLUMNSTORE INDEX
)
as 
select * from clickstream.demo_load_parquet_1
OPTION (label='copy_command')
-----------------------------------------------------------------------------------------------------------------
--USING EXTERNAL TABLE TO UNLOAD THE DATA TO BLOB
CREATE EXTERNAL TABLE [dbo].[demo_load_one] WITH ( 
        LOCATION = 'one/', 										--NOTE: LOCATION OF BLOB WITHOUT CONTAINER NAME
        DATA_SOURCE = [adw-commerce], 							--NOTE: SELECT THE RIGHT DATA SOURCE(IF IT'S NOT THERE DEFINE ONE)
        FILE_FORMAT = fileformat_comma							--NOTE: THIS WILL DEFINE HOW YOU DATA WILL BE STORED IN BLOB
) AS 
SELECT * FROM  clickstream.sessionstyledaily_2021_08_08			--NOTE: SOURCE TABLE 
---------------------------------------------------------------------------------------------------------------
copy into clickstream.sessionstyledaily_2021_08_08__with_2000_2_DWu
from 'https://myntrabi01.blob.core.windows.net/adw-commerce/test/commerce_tables/clickstream/sessionstyledaily/20210808/*.parq.gz'
 WITH
 (
  FILE_TYPE = 'PARQUET',
   CREDENTIAL = (IDENTITY='Shared Access Signature',SECRET='sp=racwdl&st=2021-09-06T06:15:12Z&se=2021-10-01T14:15:12Z&sv=2020-08-04&sr=c&sig=8uzj2t7eh8M2iMTpEBjW3LD%2BuZmoKfgppIoMmv0Fu4s%3D')
 );
---------------------------------------------------------------------------------------------------------------
 CREATE EXTERNAL TABLE [clickstream].[demo_load_one] WITH ( 
        LOCATION = '/test/commerce_tables/clickstream/sessionstyledaily/csv_zip/', 										--NOTE: LOCATION OF BLOB WITHOUT CONTAINER NAME
        DATA_SOURCE = [adw-commerce], 							--NOTE: SELECT THE RIGHT DATA SOURCE(IF IT'S NOT THERE DEFINE ONE)
        FILE_FORMAT = [DDPCommaDelimitedFile]							--NOTE: THIS WILL DEFINE HOW YOU DATA WILL BE STORED IN BLOB
) AS 
SELECT top 56449369 * FROM  clickstream.sessionstyledaily_2021_08_08	
---------------------------------------------------------------------------------------------------------------
copy into clickstream.sessionstyledaily_2021_08_08__csv_2000
from 'https://myntrabi01.blob.core.windows.net/adw-commerce/test/commerce_tables/clickstream/sessionstyledaily/csv_zip/QID286368250_20210901_24633_0.txt.gz'
 WITH
 (
  FILE_TYPE = 'CSV',
   CREDENTIAL = (IDENTITY='Shared Access Signature',SECRET='sp=racwdl&st=2021-09-06T06:15:12Z&se=2021-10-01T14:15:12Z&sv=2020-08-04&sr=c&sig=8uzj2t7eh8M2iMTpEBjW3LD%2BuZmoKfgppIoMmv0Fu4s%3D'),
     FIELDQUOTE = '"',
    FIELDTERMINATOR=','
 );
---------------------------------------------------------------------------------------------------------------
select * from sys.dm_exec_requests
--Note the distribution statement id  --9deccb4b-6e34-4565-9ed9-11b59fe3be05
---------------------------------------------------------------------------------------------------------------
 -- Monitor active queries
SELECT R.*
FROM sys.dm_exec_requests R
WHERE R.status not in ('Completed','Failed','Cancelled')
  AND R.session_id <> session_id()
ORDER BY R.start_time DESC;
---------------------------------------------------------------------------------------------------------------
--see the query text
SELECT t.text, r.*
FROM sys.dm_exec_requests AS r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS t
WHERE r.session_id<>@@spid;

select * from sys.dm_pdw_exec_requests
where status='running'

select * from sys.dm_pdw_exec_sessions
where status='running'
---------------------------------------------------------------------------------------------------------------
 select * from INFORMATION_SCHEMA.TABLES
where TABLE_SCHEMA='clickstream'
---------------------------------------------------------------------------------------------------------------
select * from sys.external_tables
---------------------------------------------------------------------------------------------------------------
select * from sys.sysusers
select * from sys.sql_logins
select * from sys.database_principals
--------------------------------------------------------------------------------------------------------------
select COUNT_BIG(*) from clickstream.sessionstyledaily_2021_08_08__1000_290GB       --3387375980
select COUNT_BIG(*) from clickstream.sessionstyledaily_2021_08_08__1000_580GB		--6774751960
select COUNT_BIG(*) from clickstream.sessionstyledaily_2021_08_08__1000_870GB		--10123840199

drop external table clickstream.sessionstyledaily_2021_08_08_ext_orc_7GB

select top 10 * from clickstream.sessionstyledaily_2021_08_08_ext_orc_7GB

--exec sp_spaceused 'clickstream.sessionstylehour_2021_08_26'             --79414720 KB
--exec sp_spaceused 'clickstream.sessionstylehour_2021_08_04'             --81734128 KB
--exec sp_spaceused 'clickstream.sessionstyledaily'                       --50962112 KB
--exec sp_spaceused 'clickstream.comprehensive_funnel_2021_03_09'         --54495568 KB
/*
https://myntrabi01.blob.core.windows.net/adw-commerce/test/commerce_tables/clickstream/sessionstyledaily/one/QID895393373_20210908_55227_0.parq.gz

copy into clickstream.sessionstyledaily_2021_08_08_with_300_1
from 'https://synapsecentral.blob.core.windows.net/testing/sessionstyledaily/parquet_4.83gb_each/QID280665928_20210824_45516_0.parq.gz'
 WITH
 (
  FILE_TYPE = 'PARQUET',
   CREDENTIAL = (IDENTITY='Shared Access Signature',SECRET='sp=racwdl&st=2021-09-06T14:52:48Z&se=2021-10-08T22:52:48Z&sv=2020-08-04&sr=c&sig=AYnmki0cjjkd5IuscvY5yZq%2FC5nphp%2F13O06JulqfKE%3D')
 );

 truncate table clickstream.sessionstyledaily_2021_08_08_with_300_1
 /*
 -----------------------------------------------------------------
 -----------------------------------------------------------------
 -----------------------------------------------------------------
 -----------------------------------------------------------------
 /*
CREATE EXTERNAL TABLE clickstream.demo_load_parquet_60_ext(
	[load_date] [varchar](100) NULL,
	[uidx] [varchar](100) NULL,
	[session_id] [varchar](100) NULL,
	[device_id] [varchar](100) NULL,
	[os] [varchar](100) NULL,
	[app_version] [varchar](100) NULL,
	[device_manufacturer] [varchar](100) NULL,
	[city] [varchar](100) NULL,
	[state] [varchar](100) NULL,
	[country] [varchar](100) NULL,
	[app_name] [varchar](100) NULL,
	[device_category] [varchar](100) NULL,
	[style_id] [varchar](100) NULL,
	[brand] [varchar](100) NULL,
	[article_type] [varchar](100) NULL,
	[gender] [varchar](100) NULL,
	[business_unit] [varchar](100) NULL,
	[master_category] [varchar](100) NULL,
	[current_commercial_type] [varchar](100) NULL,
	[supply_type] [varchar](100) NULL,
	[brand_type] [varchar](100) NULL,
	[addtocart] [bigint] NULL,
	[listcount] [bigint] NULL,
	[addtolist] [bigint] NULL,
	[pdpviews] [bigint] NULL,
	[pdpviewsdistinct] [varchar](100) NULL,
	[shares] [bigint] NULL,
	[similarstyleclicks] [bigint] NULL,
	[addtocollection] [bigint] NULL,
	[sizechartclick] [bigint] NULL,
	[productinfoclick] [bigint] NULL,
	[pdplikes] [bigint] NULL,
	[brokensizebuttonclicked] [bigint] NULL,
	[brokensizeclick] [bigint] NULL,
	[checkdelivery] [bigint] NULL,
	[clickforoffer] [bigint] NULL,
	[crosslink] [bigint] NULL,
	[crosslinkclick] [bigint] NULL,
	[follow] [bigint] NULL,
	[imageswipe] [varchar](100) NULL,
	[imagezoom] [bigint] NULL,
	[infoclick] [bigint] NULL,
	[moreprofiles] [bigint] NULL,
	[pdpunlike] [bigint] NULL,
	[profileclick] [bigint] NULL,
	[profilevisitclick] [bigint] NULL,
	[recommendedsize] [varchar](100) NULL,
	[sizerecoinfo] [varchar](100) NULL,
	[unfollow] [bigint] NULL,
	[similarproductsloadedbrokensizes] [bigint] NULL,
	[similarproductsclickedbrokensizes] [bigint] NULL,
	[similarproductsbuttonbrokensizes] [bigint] NULL,
	[similarproductsloadedlist] [bigint] NULL,
	[similarproductsbuttonclicklist] [bigint] NULL,
	[similarproductsclicklist] [bigint] NULL,
	[similarproductsclickeddialogbox] [bigint] NULL,
	[similarproductsclickedreco] [bigint] NULL,
	[similarproductsbuttonclickpdpicon] [bigint] NULL,
	[similarproductsloadedpdpicon] [bigint] NULL,
	[similarproductsclickedpdpicon] [bigint] NULL,
	[gaid] [varchar](400) NULL,
	[react_bundle_version] [varchar](400) NULL,
	[move_to_cart] [bigint] NULL,
	[add_to_wishlist_pdp] [bigint] NULL,
	[add_to_collection_pdp] [bigint] NULL,
	[remove_from_wishlist] [bigint] NULL,
	[remove_from_collection] [bigint] NULL,
	[checkdelivery_click] [bigint] NULL,
	[imageswipe_count] [bigint] NULL,
	[recommendedsize_count] [bigint] NULL,
	[sizerecoinfo_count] [bigint] NULL,
	[size_select] [bigint] NULL,
	[recommend_product_click] [bigint] NULL,
	[saha_click] [bigint] NULL,
	[color_switch] [bigint] NULL,
	[look_widget_click] [bigint] NULL,
	[video_card_click] [bigint] NULL,
	[video_play] [bigint] NULL,
	[youcam_click] [bigint] NULL,
	[share_click] [bigint] NULL,
	[cart_click] [bigint] NULL,
	[wishlist_click] [bigint] NULL,
	[similar_products_clicked] [bigint] NULL,
	[similar_products_loaded] [bigint] NULL,
	[similar_products_button_clicked] [bigint] NULL,
	[store_order_id] [varchar](400) NULL,
	[discounted_price] [numeric](12, 2) NULL,
	[mrp] [numeric](12, 2) NULL,
	[listviews] [bigint] NULL 

)  
WITH (LOCATION='/test/commerce_tables/clickstream/sessionstyledaily/one/',
      DATA_SOURCE = AzureStorage,  
      FILE_FORMAT = Parquet_file_format  
);
-------------------------------------------------------------------------------------------
create table clickstream.demo_load_one_parquet_60
WITH(
      DISTRIBUTION=ROUND_ROBIN,
      CLUSTERED COLUMNSTORE INDEX
)
as 
select * from clickstream.demo_load_parquet_60_ext
OPTION (label='copy_command')


select count_big(*) from clickstream.demo_load_one_parquet_60

drop table clickstream.demo_load_one_parquet_60
*/
-------------------------------------------------------------------------------------------
--access key
--xEsC7Ooaeoj3Fr9UOmuOMwcrkrYTaU/mf+LtHi6aI5J7itnLpIH9fwUPn6zBX1BO6KQtD6SOg2ItzUrvA3wDTA==
--SAS token
--sp=racwdl&st=2021-10-01T03:58:35Z&se=2021-12-31T11:58:35Z&sv=2020-08-04&sr=c&sig=pc%2F%2FbRYYREKXEOz0BGOTwkPMzWWcyfFhZyOMwPfR8wI%3D
--4.83 parquet location
--https://synapsecentral.blob.core.windows.net/testing/sessionstyledaily/parquet_4.83gb_each/QID280665928_20210824_45516_0.parq.gz
--csv location
--https://synapsecentral.blob.core.windows.net/testing/sessionstyledaily/csv_5.3gb_one/QID286368250_20210901_24633_0.txt.gz
--83MB parquet file location
--https://synapsecentral.blob.core.windows.net/testing/sessionstyledaily/parquet_83mb_each/QID895393373_20210908_55227_0.parq.gz
--dim_product parquet		--33328605
--https://synapsecentral.blob.core.windows.net/testing/20210906/dim_product_parquet/part-00000-06435902-c35d-482c-b353-49ec8c524198-c000.snappy.parquet
--seller_item_master
--https://synapsecentral.blob.core.windows.net/testing/seller_item_master/QID970932737_20211004_104035_0.parq.snappy
--fact_wh_inventory
--https://synapsecentral.blob.core.windows.net/testing/fact_wh_inventory/QID970948636_20211004_104727_0.parq.snappy
--fact_core_item			--189724535 
--https://synapsecentral.blob.core.windows.net/testing/20210906/fact_core_item_parquet/order_created_date=20210101/part-01056-d8817ded-93a9-47c3-9526-a77c68f44249.c000.snappy.parquet
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
--Partner portal data have been added
--Two schemas (customer_insights,user_segments) there is no data in user_segments this schema, unloaded the customer_insights in same storage.
--four tables have location
--inventory_and_listing (285477534)
--https://synapsecentral.blob.core.windows.net/testing/customer_insights/inventory_and_listing/QID12910511_20210921_130606_0.parq.snappy
--partner_return_aggregates (68916304)
--https://synapsecentral.blob.core.windows.net/testing/customer_insights/partner_return_aggregates/QID12925985_20210921_144910_13.parq.snappy
--partner_orders_aggregates (160819341)
--https://synapsecentral.blob.core.windows.net/testing/customer_insights/partner_orders_aggregates/QID12911031_20210921_130730_12.parq.snappy
--sjit_inventory (19693)
--https://synapsecentral.blob.core.windows.net/testing/customer_insights/sjit_inventory/QID12927047_20210921_145437_11.parq.snappy
--mdirect_listings (6003)
--https://synapsecentral.blob.core.windows.net/testing/customer_insights/mdirect_listings/QID12927187_20210921_145505_12.parq.snappy
--myntra_vms_partner_contact_address (45730)
--https://synapsecentral.blob.core.windows.net/testing/customer_insights/myntra_vms_partner_contact_address/QID12925478_20210921_144746_0.parq.snappy
--poi_table_392 (9)
--https://synapsecentral.blob.core.windows.net/testing/user_segments/poi_table_392/QID12938739_20210921_155951_11.parq.snappy
--sad_table_394
--https://synapsecentral.blob.core.windows.net/testing/user_segments/sad_table_394/QID12939360_20210921_160323_12.parq.snappy
-------------------------------------------------------------------------------------------
--clickstream.sessionstyledaily_2021_08_08_dwu_check
--Total execution time: 00:03:26.497
--ID: 77C6766B-840E-4015-93DC-411D16E219CC
--DW 100 to 500c. used 500c auto scaled.

/*
-----------------------------------------------------------------
table name- sessionstyledaily_2021_08_08_downscale
(56442645 rows affected)
C88DE01B-2666-48FF-955E-BD9D1234E23A
Total execution time: 00:09:32.613
-----------------------------------------------------------------
table name - sessionstyledaily_2021_08_08_upscale_100_1000
Dw 100 to 1000c
E579B45D-A7CC-4A9E-93FD-612FC847F0C8
Total execution time: 00:03:03.228
-----------------------------------------------------------------
table name - sessionstyledaily_2021_08_08_upscale_1000
Dw 1000c
B89878FC-64E8-4243-9C1E-0598636BEB88
Total execution time: 00:03:36.700
-----------------------------------------------------------------
table name - sessionstyledaily_2021_08_08_upscale_2000
DW- 2000
F8F19F63-012C-4D40-B8FA-EAC223AE8492
Total execution time: 00:04:34.211
-----------------------------------------------------------------
*/
--------------------------------------------------------------------------------------------------------------------------------
/*
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bidb].[dim_product]
(
	[id] [bigint] NULL,
	[sku_id] [bigint] NULL,
	[sku_code] [varchar](50) NULL,
	[vendor_article_number] [varchar](50) NULL,
	[style_id] [varchar](20) NULL,
	[style_name] [varchar](300) NULL,
	[style_status] [varchar](5) NULL,
	[article_number] [varchar](1000) NULL,
	[product_option_size] [varchar](140) NULL,
	[gender] [varchar](20) NULL,
	[season_code] [varchar](20) NULL,
	[season] [varchar](30) NULL,
	[year] [bigint] NULL,
	[brand_id] [varchar](64) NULL,
	[brand] [varchar](100) NULL,
	[brand_type] [varchar](100) NULL,
	[brand_group] [varchar](255) NULL,
	[supply_type] [varchar](63) NULL,
	[commercial_type] [varchar](255) NULL,
	[usage_attr] [varchar](100) NULL,
	[occasion_attr] [varchar](255) NULL,
	[fashion_type] [varchar](20) NULL,
	[base_colour] [varchar](100) NULL,
	[age_group] [varchar](100) NULL,
	[article_type_id] [bigint] NULL,
	[article_type] [varchar](255) NULL,
	[sub_category_id] [varchar](100) NULL,
	[sub_category] [varchar](100) NULL,
	[master_category_id] [varchar](100) NULL,
	[master_category] [varchar](100) NULL,
	[group_category] [varchar](100) NULL,
	[vendor_id] [bigint] NULL,
	[article_mrp] [float] NULL,
	[article_mrp_excl_tax] [float] NULL,
	[tax_rate] [float] NULL,
	[style_created_date] [bigint] NULL,
	[style_created_time] [bigint] NULL,
	[style_catalogued_date] [bigint] NULL,
	[style_catalogued_time] [bigint] NULL,
	[business_group] [varchar](255) NULL,
	[remarks] [varchar](255) NULL,
	[photoshoot_priority] [bigint] NULL,
	[photoshoot_rule_id] [bigint] NULL,
	[catalog_priority] [bigint] NULL,
	[catalog_rule_id] [bigint] NULL,
	[photoshoot_stn_barcode] [varchar](2000) NULL,
	[photoshoot_issue_date] [bigint] NULL,
	[photoshoot_issue_time] [bigint] NULL,
	[default_image] [varchar](1024) NULL,
	[first_inward_date] [bigint] NULL,
	[first_inward_time] [bigint] NULL,
	[last_inward_date] [bigint] NULL,
	[last_inward_time] [bigint] NULL,
	[gtin] [varchar](14) NULL,
	[category_head] [varchar](200) NULL,
	[category_manager] [varchar](2000) NULL,
	[cm_ownership] [varchar](255) NULL,
	[catalogue_manager] [varchar](2000) NULL,
	[current_discount] [varchar](256) NULL,
	[style_exclusive_flag] [varchar](7) NULL,
	[is_active] [smallint] NULL,
	[valid_from] [bigint] NULL,
	[valid_to] [bigint] NULL,
	[last_modified_on] [datetime2](7) NULL,
	[business_unit] [varchar](100) NULL,
	[category_manager_email] [varchar](200) NULL,
	[category_head_email] [varchar](200) NULL,
	[repex_name] [varchar](200) NULL,
	[repex_email] [varchar](200) NULL,
	[master_brand] [varchar](100) NULL,
	[catalog_live_date] [bigint] NULL,
	[hsn_code] [varchar](50) NULL,
	[myntra_hsn] [varchar](128) NULL,
	[vendor_hsn] [varchar](128) NULL,
	[size] [varchar](400) NULL,
	[myntra_size] [varchar](400) NULL,
	[inferred_size] [varchar](400) NULL,
	[unified_size] [varchar](400) NULL,
	[style_category] [varchar](255) NULL,
	[old_business_unit] [varchar](100) NULL,
	[vendor_article_name] [varchar](100) NULL,
	[manufacturer_info] [varchar](255) NULL,
	[country_of_origin] [varchar](255) NULL,
	[listing_status] [varchar](6) NULL,
	[seller_approval_status] [varchar](6) NULL,
	[platform_id] [bigint] NULL,
	[list_display_name] [varchar](255) NULL,
	[master_business_unit] [varchar](100) NULL,
	[sub_business_unit] [varchar](100) NULL,
	[sub_brand_type] [varchar](100) NULL
)
WITH
(
	DISTRIBUTION = HASH ( [sku_id] ),
	CLUSTERED INDEX
	(
		[sku_id] ASC,
		[platform_id] ASC
	)
)
GO

*/
--------------------------------------------------------------------------------------------------------------------------------
/*

CREATE TABLE [bidb].[Fact_core_item_1]
(
	[order_group_id] [bigint] NULL,
	[order_id] [bigint] NULL,
	[item_id] [bigint] NULL,
	[sku_id] [bigint] NULL,
	[style_id] [varchar](50) NULL,
	[core_item_id] [varchar](35) NULL,
	[store_id] [varchar](20) NULL,
	[store_line_id] [varchar](50) NULL,
	[store_release_id] [varchar](20) NULL,
	[seller_id] [varchar](15) NULL,
	[po_id] [varchar](100) NULL,
	[warehouse_id] [smallint] NULL,
	[pps_item_id] [varchar](30) NULL,
	[item_status] [varchar](10) NULL,
	[order_status] [varchar](10) NULL,
	[return_status] [varchar](64) NULL,
	[wms_item_status] [varchar](20) NULL,
	[is_booked] [smallint] NULL,
	[is_shipped] [smallint] NULL,
	[is_realised] [smallint] NULL,
	[is_returned] [smallint] NULL,
	[is_delivered] [smallint] NULL,
	[is_rto] [smallint] NULL,
	[is_exchange] [smallint] NULL,
	[return_id] [bigint] NULL,
	[rto_id] [bigint] NULL,
	[exchange_release_id] [bigint] NULL,
	[item_cancellation_reason_id] [int] NULL,
	[vendor_id] [bigint] NULL,
	[idproduct] [bigint] NULL,
	[brand_id] [varchar](64) NULL,
	[article_type_id] [bigint] NULL,
	[brand] [varchar](100) NULL,
	[brand_type] [varchar](50) NULL,
	[article_type] [varchar](100) NULL,
	[gender] [varchar](20) NULL,
	[master_category] [varchar](100) NULL,
	[supply_type] [varchar](15) NULL,
	[po_type] [varchar](30) NULL,
	[basis_of_margin] [varchar](30) NULL,
	[vendor_code] [varchar](20) NULL,
	[primary_vat] [float] NULL,
	[selling_vat_percentage] [decimal](6, 3) NULL,
	[agreed_buying_margin] [float] NULL,
	[tax_type] [varchar](9) NULL,
	[item_purchase_price_inc_tax] [float] NULL,
	[item_landed_price] [float] NULL,
	[unit_price_with_tax] float NULL,
	[unit_price_without_tax] float NULL,
	[order_quantity] [int] NULL,
	[quantity] [int] NULL,
	[product_discount] [float] NULL,
	[cart_discount] [float] NULL,
	[cashback_redeemed] [float] NULL,
	[coupon_discount] [float] NULL,
	[payment_gateway_discount] FLOAT NULL,
	[tax_usr_recovered] [float] NULL,
	[loyalty_pts_used] [float] NULL,
	[item_mrp_value] [float] NULL,
	[tax_rate] [decimal](22, 4) NULL,
	[shipping_charges] [float] NULL,
	[gift_charges] [decimal](12, 4) NULL,
	[cod_charges] [decimal](12, 4) NULL,
	[discount_id] [bigint] NULL,
	[discount_rule_id] [bigint] NULL,
	[discount_rule_rev_id] [bigint] NULL,
	[effective_discount_percent] [float] NULL,
	[funding_basis] [varchar](20) NULL,
	[discount_limit] [float] NULL,
	[funding_percentage] [float] NULL,
	[discount_funding] [varchar](40) NULL,
	[or_discount_rule_category_flag] [varchar](40) NULL,
	[sor_flag] [varchar](30) NULL,
	[item_revenue_inc_cashback] [float] NULL,
	[effective_discount] [float] NULL,
	[vendor_funded_trade_discount] [float] NULL,
	[vendor_funding] [decimal](22, 4) NULL,
	[tax] [float] NULL,
	[brand_margin] [decimal](22, 4) NULL,
	[vat_reimbursement] [float] NULL,
	[cogs] float NULL,
	[entry_tax] [float] NULL,
	[royalty_commission] [float] NULL,
	[rgm_base] float NULL,
	[rgm_royalty] float NULL,
	[rgm_final] float NULL,
	[is_refunded] [char](1) NULL,
	[refund_amount] float NULL,
	[payment_method] [varchar](10) NULL,
	[order_created_by] [varchar](110) NULL,
	[idcustomer] [bigint] NULL,
	[order_created_date] [bigint] NULL,
	[order_created_time] [bigint] NULL,
	[order_release_created_date] [bigint] NULL,
	[order_queued_date] [bigint] NULL,
	[order_packed_date] [bigint] NULL,
	[order_packed_time] [bigint] NULL,
	[order_cancel_date] [bigint] NULL,
	[order_cancel_time] [bigint] NULL,
	[order_shipped_date] [bigint] NULL,
	[order_shipped_time] [bigint] NULL,
	[order_delivered_date] [bigint] NULL,
	[order_delivered_time] [bigint] NULL,
	[order_completed_date] [bigint] NULL,
	[restocked_date] [bigint] NULL,
	[restocked_time] [bigint] NULL,
	[order_rto_date] [bigint] NULL,
	[zipcode] [varchar](10) NULL,
	[address] [varchar](1) NULL,
	[idlocation] [bigint] NULL,
	[location_type] [varchar](200) NULL,
	[idcourier] [bigint] NULL,
	[courier_code] [varchar](10) NULL,
	[warehouse_pincode] [bigint] NULL,
	[reverse_logistics_cost] [float] NULL,
	[total_individual_logistics_cost] [float] NULL,
	[logistics_cost] [float] NULL,
	[last_modified_on] [datetime2](7) NULL,
	[avg_sku_age] [bigint] NULL,
	[is_vendor_exception] [smallint] NULL,
	[is_try_and_buy] [smallint] NULL,
	[customer_promise_datetime] [datetime2](7) NULL,
	[on_hold_reason_id_fk] [smallint] NULL,
	[shipment_cancellation_reason_id] [bigint] NULL,
	[gift_card_amount] [decimal](22, 4) NULL,
	[vat_adj_refund_amount] [decimal](12, 4) NULL,
	[vat_adj_pps_id] [varchar](65) NULL,
	[final_amount] float NULL,
	[sale_order_item_code] [varchar](30) NULL,
	[wallet_redeemed] [float] NULL,
	[nsv_item_purchase_price_inc_tax] [float] NULL,
	[charges_paid_by_loyalty_pts] [float] NULL,
	[charges_paid_by_giftcard] [float] NULL,
	[charges_paid_by_wallet] [float] NULL,
	[refund_neft] FLOAT NULL,
	[refund_loyalty] FLOAT NULL,
	[refund_gc_amount] FLOAT NULL,
	[refund_wallet] float NULL,
	[charges_refund_by_wallet] [float] NULL,
	[charges_refund_by_loyalty_pts] [float] NULL,
	[is_first_order] [char](1) NULL,
	[is_first_brand_order] [char](1) NULL,
	[store_order_id] [varchar](50) NULL,
	[coupon_code] [varchar](60) NULL,
	[actual_promise_datetime] [datetime2](7) NULL,
	[packaging_cost] float NULL,
	[payment_gateway_cost] [decimal](22, 4) NULL,
	[warehouse_cost] float NULL,
	[customer_care_cost] float NULL,
	[device_id] [varchar](120) NULL,
	[advertising_id] [varchar](80) NULL,
	[bi_last_modified_on] [datetime2](7) NULL,
	[cgst_tax_rate] [decimal](22, 4) NULL,
	[cgst_tax_amount] [float] NULL,
	[sgst_tax_rate] [decimal](22, 4) NULL,
	[sgst_tax_amount] [float] NULL,
	[igst_tax_rate] [decimal](22, 4) NULL,
	[igst_tax_amount] [float] NULL,
	[mynts_used] [float] NULL,
	[bank_discount_used] [float] NULL,
	[refund_mynts] [decimal](12, 4) NULL,
	[refund_bank_discount] float NULL,
	[charges_refund_by_bank_discount] [float] NULL,
	[charges_paid_by_bank_discount] [float] NULL,
	[item_inward_date] [bigint] NULL,
	[buyer_id] [bigint] NULL,
	[virtual_sku_id] [varchar](30) NULL,
	[virtual_style_id] [varchar](20) NULL,
	[lmc_warehouse_id] [bigint] NULL,
	[packet_id] [bigint] NULL,
	[store_credit_used] [float] NULL,
	[charges_paid_by_store_credit] [float] NULL,
	[refund_store_credit] [decimal](12, 4) NULL,
	[charges_refund_by_store_credit] [float] NULL,
	[seller_type] [varchar](45) NULL,
	[seller_terms_id] [bigint] NULL,
	[latest_terms_id] [bigint] NULL,
	[commission] [decimal](18, 2) NULL,
	[forward_logistics_revenue] [bigint] NULL,
	[reverse_logistics_revenue] [bigint] NULL,
	[source_owner_id] [bigint] NULL,
	[platform_charges] [decimal](12, 4) NULL,
	[additional_charges] [decimal](12, 4) NULL,
	[additional_discounts] [decimal](12, 4) NULL,
	[unified_address_id] [varchar](255) NULL,
	[user_agent_id] [int] NULL,
	[platform_id] [bigint] NULL,
	[actual_cogs] FLOAT NULL,
	[actual_item_purchase_price] [float] NULL,
	[payment_group_id] [varchar](255) NULL,
	[transactionid] [varchar](256) NULL
)
WITH
(
	DISTRIBUTION = HASH ( [item_id] )
--	CLUSTERED COLUMNSTORE INDEX ORDER ([order_created_date])
)
GO

*/
--------------------------------------------------------------------------------------------------------------------------------
--https://synapsecentral.blob.core.windows.net/testing/20210906/fact_inventory_item_parquet/inward_date=20210101/part-00000-4eff464e-250f-40ec-a111-b1d2e16ae7dc.c000.snappy.parquet
/*			--73824146 
CREATE TABLE [bidb].[fact_inventory_item_1]
(
	[core_item_id] DECIMAL(19, 0) NULL,
	[sku_id] [bigint] NULL,
	[order_id] DECIMAL(19, 0) NULL,
	[item_barcode] DECIMAL(19, 0) NULL,
	[item_purchase_price] FLOAT NULL,
	[enabled] [bigint] NULL,
	[quality] [varchar](4) NULL,
	[item_status] [varchar](20) NULL,
	[lot_id] [bigint] NULL,
	[po_sku_id] [bigint] NULL,
	[grn_sku_id] [bigint] NULL,
	[po_barcode] [varchar](50) NULL,
	[grn_barcode] [varchar](50) NULL,
	[po_id] [bigint] NULL,
	[warehouse_id] [bigint] NULL,
	[item_purchase_price_inc_tax] FLOAT NULL,
	[zone_id] DECIMAL(19, 0) NULL,
	[section_id] DECIMAL(19, 0) NULL,
	[bin_id] DECIMAL(19, 0) NULL,
	[bin_barcode] [varchar](20) NULL,
	[carton_barcode] [varchar](20) NULL,
	[lot_barcode] [varchar](50) NULL,
	[inward_date] [bigint] NULL,
	[inward_time] [bigint] NULL,
	[internal_order_id] [varchar](20) NULL,
	[reject_reason_code] [varchar](30) NULL,
	[reject_reason_description] [varchar](200) NULL,
	[rejected_date] [bigint] NULL,
	[rejected_time] [bigint] NULL,
	[action_status] [varchar](30) NULL,
	[rejected_at] [varchar](30) NULL,
	[last_modified_on] [varchar](50) NULL,
	[item_last_modified_on] [varchar](50) NULL,
	[rejected_item_last_modified_on] [varchar](50) NULL,
	[store_id] [smallint] NULL,
	[item_action_status] [varchar](50) NULL,
	[return_order_id] [bigint] NULL,
	[invoice_sku_id] DECIMAL(19, 0) NULL,
	[buyer_id] DECIMAL(19, 0) NULL,
	[platform_id] [bigint] NULL,
	[source_owner_id] [bigint] NULL,
	[store_platform_id] [bigint] NULL,
	[source_type] [varchar](50) NULL,
	[inward_request_id] [bigint] NULL,
	[id] DECIMAL(19, 0) NULL,
	[src_inward_date] [bigint] NULL,
	[actual_item_purchase_price] float NULL,
	[tax_amount] FLOAT NULL,
	[actual_item_purchase_price_inc_tax] FLOAT NULL
)
WITH
(
	DISTRIBUTION = HASH ( [sku_id] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO
*/
--------------------------------------------------------------------------------------------------------------------------------
--https://synapsecentral.blob.core.windows.net/testing/20210906/fact_atp_inventory_parquet/part-00000-95979dba-bedc-49c6-ae7e-93457dc2c2c1-c000.snappy.parquet
/*
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bidb].[fact_atp_inventory]
(
	[id] [bigint] NULL,
	[store_id] [bigint] NULL,
	[seller_id] [bigint] NULL,
	[supply_type] [varchar](15) NULL,
	[sku_id] [bigint] NULL,
	[sku_code] [varchar](128) NULL,
	[is_sku_active] [smallint] NULL,
	[style_id] [bigint] NULL,
	[style_status] [varchar](15) NULL,
	[inventory_count] [bigint] NULL,
	[blocked_order_count] [bigint] NULL,
	[is_live_on_portal] [smallint] NULL,
	[lead_time] [bigint] NULL,
	[enabled] [smallint] NULL,
	[last_synced_on] [datetime2](7) NULL,
	[available_in_warehouses] [varchar](128) NULL,
	[vendor_id] [bigint] NULL,
	[created_by] [varchar](50) NULL,
	[created_on] [datetime2](7) NULL,
	[src_last_modified_on] [datetime2](7) NULL,
	[version] [bigint] NULL,
	[is_active] [smallint] NULL,
	[last_modified_on] [datetime2](7) NULL,
	[blocked_order_count_from_oms] [bigint] NULL,
	[net_inventory_count_from_wms] [bigint] NULL,
	[overall_blocked_order_count_oms] [bigint] NULL,
	[inventory_count_from_wms] [bigint] NULL
)
WITH
(
	DISTRIBUTION = HASH ( [sku_id] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO
*/
--------------------------------------------------------------------------------------------------------------------------------
--https://synapsecentral.blob.core.windows.net/testing/20210920/order_line_parquet/part_created_on=202101/part-00612-30aaad7a-c09d-438d-afe3-07fb4c59fb3c.c000.snappy.parquet
--255442822 
/*
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bidb].[order_line]
(
	[id] [bigint] NULL,
	[created_on] [bigint] NULL,
	[updated_on] [bigint] NULL,
	[order_line_item_id] [bigint] NULL,
	[order_release_id] [bigint] NULL,
	[points_credited_on] [bigint] NULL,
	[amount] [bigint] NULL,
	[order_delivered_on] [bigint] NULL,
	[order_id] [varchar](255) NULL,
	[points_earned] [bigint] NULL,
	[status] [varchar](255) NULL,
	[uidx] [varchar](255) NULL,
	[sku_id] [varchar](255) NULL,
	[header] [varchar](255) NULL,
	[message] [varchar](255) NULL,
	[style_id] [varchar](20) NULL,
	[is_non_returnable] [int] NULL,
	[non_returnable_on] [bigint] NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO
*/
--------------------------------------------------------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bidb].[fact_wh_inventory]
(
	[id] [numeric](19, 0) NULL,
	[warehouse_id] [bigint] NULL,
	[warehouse_name] [varchar](128) NULL,
	[store_id] [bigint] NULL,
	[seller_id] [bigint] NULL,
	[vendor_id] [bigint] NULL,
	[supply_type] [varchar](128) NULL,
	[sku_id] [bigint] NULL,
	[sku_code] [varchar](128) NULL,
	[inventory_count] [bigint] NULL,
	[blocked_order_count] [bigint] NULL,
	[created_by] [varchar](50) NULL,
	[created_on] [datetime2](7) NULL,
	[last_modified_on] [datetime2](7) NULL,
	[last_synced_on] [datetime2](7) NULL,
	[pushed_order_count] [bigint] NULL,
	[version] [bigint] NULL,
	[proc_sla] [bigint] NULL,
	[platform_id] [bigint] NULL,
	[store_partner_id] [bigint] NULL,
	[seller_partner_id] [bigint] NULL,
	[order_system] [varchar](50) NULL
)
WITH
(
	DISTRIBUTION = HASH ( [sku_id] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO
ALTER TABLE [bidb].[fact_wh_inventory] ADD  DEFAULT ((1)) FOR [platform_id]
GO
--------------------------------------------------------------------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bidb].[seller_item_master]
(
	[id] [bigint] NULL,
	[seller_id] [bigint] NULL,
	[sku_code] [varchar](128) NULL,
	[style_id] [bigint] NULL,
	[lead_time] [bigint] NULL,
	[created_on] [datetime2](7) NULL,
	[last_modified_on] [datetime2](7) NULL,
	[enabled] [smallint] NULL,
	[sku_id] [bigint] NULL,
	[seller_sku_code] [varchar](128) NULL,
	[listing_status] [varchar](6) NULL,
	[listing_comments] [varchar](1000) NULL,
	[seller_approval_status] [varchar](6) NULL,
	[seller_comments] [varchar](1000) NULL,
	[store_id] [bigint] NULL,
	[platform_id] [bigint] NULL,
	[option_id] [bigint] NULL,
	[is_active_for_store] [bigint] NULL,
	[beta_approval_status] [varchar](6) NULL,
	[supply_type] [varchar](63) NULL,
	[commercial_type] [varchar](255) NULL,
	[seller_mrp] [numeric](16, 4) NULL,
	[country_of_origin1] [varchar](512) NULL,
	[country_of_origin2] [varchar](512) NULL,
	[country_of_origin3] [varchar](512) NULL,
	[country_of_origin4] [varchar](512) NULL,
	[country_of_origin5] [varchar](512) NULL,
	[manufacturer_info] [varchar](1000) NULL,
	[packer_info] [varchar](512) NULL,
	[importer_info] [varchar](512) NULL
)
WITH
(
	DISTRIBUTION = HASH ( [style_id] ),
	CLUSTERED COLUMNSTORE INDEX
)
GO
