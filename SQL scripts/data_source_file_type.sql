----------------------------------------------------------------------------------------------------
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Myntra@123'

CREATE DATABASE SCOPED CREDENTIAL DBSPCRcustomerinsight_blob
WITH 
IDENTITY='PETAL',
SECRET='EqxDlB7t4trouG6VT18aFCRQo5weT4oPLRzhlZyr9cJcI2P2LaLF8WxAKpiclJu90Ue0+W8+Z5MIWHqri+jADw=='

CREATE EXTERNAL DATA SOURCE customerinsight_blob
WITH
(
    LOCATION='wasbs://analyticsbox@customerinsight.blob.core.windows.net/',
    CREDENTIAL= DBSPCRcustomerinsight_blob,
    TYPE=HADOOP
) ;
----------------------------------------------------------------------------------------------------
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Myntra@123'

CREATE DATABASE SCOPED CREDENTIAL DBSPCRadw-clickstream
WITH 
IDENTITY='PETAL',
SECRET='TylgfnsatUx7c7sOsEdn0vtJ1JE9+ordoMbv++sbjCCHKkUygu6RZvNngr4unz+FbhoCicUJQY06WIIQku4uCw=='

CREATE EXTERNAL DATA SOURCE adw-clickstream
WITH
(
    LOCATION='wasbs://adw-clickstream@myntrabi01.blob.core.windows.net/',
    CREDENTIAL= DBSPCRadw-clickstream,
    TYPE=HADOOP
) ;
----------------------------------------------------------------------------------------------------
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Myntra23'

CREATE DATABASE SCOPED CREDENTIAL DBSPCRmyntramadlytics01_clickstreamaggregates
WITH 
IDENTITY='myntramadlytics01_clickstreamaggregates',
SECRET='qfAYUjvKSJf2I9ZFoVAZRCpdiK1tG9RAFFY6AdTN3tHHlE3wauDbZz/ZQVnYOEkk+qt/Oml8WhT1cOSAjJNLKw=='

CREATE EXTERNAL DATA SOURCE myntramadlytics01_clickstreamaggregates
WITH
(
    LOCATION='wasbs://clickstream-aggregates@myntramadlytics01.blob.core.windows.net',
    CREDENTIAL= DBSPCRmyntramadlytics01_clickstreamaggregates,
    TYPE=HADOOP
 ) ;
----------------------------------------------------------------------------------------------------
CREATE EXTERNAL FILE FORMAT fileformat_comma  
WITH (  
    FORMAT_TYPE = DELIMITEDTEXT,  
    FORMAT_OPTIONS (  
        FIELD_TERMINATOR = ',',
        DATE_FORMAT = 'yyyy-MM-dd HH:mm:ss',
        ROW_TERMINATOR='\n'
        First_Row =2,
        Encoding = 'UTF8'),  
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.GzipCodec'
);
----------------------------------------------------------------------------------------------------
CREATE EXTERNAL FILE FORMAT fileformat_incremental  
WITH 
(  
    FORMAT_TYPE = DELIMITEDTEXT,  
    FORMAT_OPTIONS (  
        FIELD_TERMINATOR = '~||~',
        STRING_DELIMITER = 'µ‡',
        DATE_FORMAT = 'yyyy-MM-dd HH:mm:ss.fffffff',
        First_Row =1,
        Encoding = 'UTF8')
);
----------------------------------------------------------------------------------------------------
CREATE EXTERNAL FILE FORMAT CommaDelimitedFile  
WITH (  
    FORMAT_TYPE = DELIMITEDTEXT,  
    FORMAT_OPTIONS (  
        FIELD_TERMINATOR = ',',
        STRING_DELIMITER = '"',
        DATE_FORMAT = 'dd/MM/yyyy',
        First_Row =1,
        Encoding = 'UTF8'),  
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.GzipCodec'
);
----------------------------------------------------------------------------------------------------
CREATE EXTERNAL FILE FORMAT fileformat_tab  
WITH (  
    FORMAT_TYPE = DELIMITEDTEXT,  
    FORMAT_OPTIONS (  
        FIELD_TERMINATOR = '\t',
        DATE_FORMAT = 'yyyy-MM-dd HH:mm:ss.fff',
        First_Row =1,
        Encoding = 'UTF8'),  
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.GzipCodec'
);
----------------------------------------------------------------------------------------------------
CREATE EXTERNAL FILE FORMAT parquet_snappy_0  
WITH (  
    FORMAT_TYPE = PARQUET,   
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
);
----------------------------------------------------------------------------------------------------
CREATE EXTERNAL FILE FORMAT LoaderFileFormat  
WITH (  
    FORMAT_TYPE = PARQUET,  
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.GzipCodec'
);
----------------------------------------------------------------------------------------------------
select * from sys.external_file_formats where name='DDPCommaDelimitedFile_SkipHeader'
 select * from sys.external_data_sources where name='adw-commerce'