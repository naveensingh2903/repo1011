--CREATE INDEXED VIEW ON A TABLE 
---------------------------------------------------------------------------
--Create the view with schema binding
USE database_name
GO
CREATE VIEW view_name
WITH SCHEMABINDING 								
AS
SELECT 
column_name_1,column_name_2,column_name_3
FROM table_name 
GO
--------------------------------------------------------------------------
--create clustered index over to that
CREATE UNIQUE CLUSTERED INDEX clustered_index_name ON table_name(column_name_1,column_name_2,column_name_3);
--------------------------------------------------------------------------
--If using standard edition of SQL server then we have to explicitly mention noexpand while querying
SELECT * FROM index_name WITH (NOEXPAND) 
WHERE column_name_1 >12
--------------------------------------------------------------------------





